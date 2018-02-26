<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/2/9-0009
 * Time: 10:55
 */
namespace app\admin\controller;

use app\common\service\Department as DepartmentServices;
use app\common\service\Role;
use think\Request;

class Department extends Base
{
    protected $department;
    protected $role;

    public function __construct(DepartmentServices $department,Role $role)
    {
        parent::__construct();
        $this->department = $department;
        $this->role = $role;
    }

    public function index(){
        $this->pageTitle = "部门管理";
        $this->assign('pageTitle',$this->pageTitle);
//        $department = $this->department->getDepartments();
//        $this->assign('department',$department);
        $this->assign('department', tree_select(get_department_all()));
//        $roles = $this->role->getRoleForDepartment();
//        $this->assign('roles',$roles);
        return $this->fetch();
    }

    public function createDepartment(Request $request){
        $res = $request->param();
        $res['data']['d_role_id'] = $res['d_role_id'];
        $data = $this->department->createDepartment($res['data']);
        if($data == 1){
            return $this->success('新建成功');
        }else{
            return $this->error('新建失败');
        }
    }

    /**
     * 更新指定资源状态
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function status($id, $status)
    {
        $res = $this->department->updateStatus($id, $status);
        if($res){
            return $this->success("保存成功");
        }else{
            return $this->error("保存失败");
        }
    }

    //添加子部门
    public function createSub(Request $request){
        $res = $request->param();
        $roles = $this->role->getRoleForDepartment();
        $this->assign('roles',$roles);
        $this->assign("pid", $res['id']);
        $data = $this->fetch('create');
        return $this->success("新建子部门", url("create"), $data);
    }

    /**
     * @param $id 部门id
     * 编辑部门
     */
    public function edit($id){
        $department = $this->department->getThisDepartment($id);
//        $d_role = explode(',',$department['d_role_id']);
//        $this->assign('d_role',$d_role);
        $this->assign('department',$department);
        $roles = $this->role->getRoleForDepartment();
        $this->assign('roles',$roles);
        $data = $this->fetch('edit');
        return $this->success("编辑部门", url("edit"), $data);
    }

    public function updateDepartment(Request $request){
        $res = $request->param();
        $res['data']['d_role_id'] = $res['d_role_id'];
        $data = $this->department->updateDepartment($res['data']);
        if($data == 1){
            return $this->success('更新成功');
        }else{
            return $this->error('更新失败');
        }
    }

    /**
     * @param $id
     * 删除指定资源
     */
    public function delete($id){
        $res = $this->department->deleteCategory($id);
        if($res) {
            return $this->success(lang("删除成功"), url("index"));
        }else{
            return $this->error($this->department->getError());
        }
    }
}