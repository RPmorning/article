<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/2/7-0007
 * Time: 12:01
 */
namespace app\common\service;
use app\common\model\Role as RoleModel;

class Role extends RoleModel
{

    /**
     * 获取所有角色
     * @return model 成功返回角色模型，失败-返回-1
     */
    public function getRoles()
    {
        $roles = RoleModel::paginate();
        if ($roles) {
            return $roles;
        } else {
            $this->error = '角色不存在或被禁用';
            return false;
        }
    }

    public static function getRuleMenu($id)
    {
        // 获取类型为菜单且启用的规则
        $map = array('status'=>1);
        $authRule= \app\common\model\Menu::where($map)->column("id", "url");
        if ($authRule) {
            return $authRule;
        } else {
            return false;
        }
    }

    /**
     * 获取指定角色信息
     * @param  integer  $id 角色主键
     * @return array|integer 成功返回数组，失败-返回-1
     */
    public function getRoleInfo($id)
    {
        $role = RoleModel::get($id);
        if ($role) {
            return $role;
        } else {
            return false;
        }
    }

    /**
     * 更新指定角色的菜单权限规则
     * @param  integer  $id 角色主键
     * @return array 成功返回规则模型标识，失败-返回-1
     */
    public function updateRuleMenu($data)
    {
        if(RoleModel::update($data)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 获取角色 for 部门
     * @return model 成功返回角色模型，失败-返回-1
     */
    public function getRoleForDepartment(){
        $roles = RoleModel::where('status',1)->where('id','neq',1)->select();
        if ($roles) {
            return $roles;
        } else {
            $this->error = '角色不存在或被禁用';
            return false;
        }
    }

    /**
     * 更新指定资源状态
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function updateStatus($id, $status)
    {
        $res = $this->where('id', $id)->update(['status' => $status]);
        if($res){
            return true;
        }else{
            $this->error = "状态更新失败";
            return false;
        }
    }

    public function getThisRole($id){
        $role = RoleModel::where('id',$id)->find();
        if($role){
            return $role;
        }else{
            return false;
        }
    }

    public function updateRole($res){
        $data = RoleModel::update($res);
        if($data){
            return 1;
        }else{
            return 0;
        }
    }

    public function saveRole($res){
        $role = new RoleModel();
        $role->save($res);
        $resId = $role->id;
        if($resId){
            return $resId;
        }else{
            return false;
        }
    }

    public function deleteRole($id){
        if($id == 1) {
            $this->error = "不能删除超级管理员";
            return false;
        }
        $role = $this::get($id);
        $operation = \app\common\model\Operation::get($role['operation_id']);
        if($role){
            try {
                $role->delete();
                $operation->delete();
                return true;
            } catch (\Exception $e) {
                $this->error = $e->getMessage();
                return false;
            }
        }else{
            $this->error = "该角色不存在";
            return false;
        }
    }

    /**
     * 得到角色 for member
     */
    public function getRoleMember($departmentId){
        $d_role_id = \app\common\model\Department::where('id',$departmentId)->value('d_role_id');
        $role = RoleModel::field('id,name')->where('id','neq',1)
            ->where('id','in',$d_role_id)
            ->where('status',1)->select();
        if($role){
            return $role;
        }else{
            $this->error = '角色不存在或被禁用';
            return false;
        }
    }
}
