<?php
/**
 * Created by PhpStorm.
 * User: hujj
 * Date: 2017/2/23
 * Time: 9:23
 */
namespace app\admin\controller;

use app\common\service\Member as MemberService;
use app\common\service\Department;
use app\common\service\Role;
use think\Request;

class Member extends Base
{
    protected $member;
    protected $role;
    protected $department;

    public function __construct(MemberService $member,Department $department,Role $role)
    {
        parent::__construct();
        $this->member = $member;
        $this->department = $department;
        $this->role = $role;
    }

    /**
     * 显示成员列表
     * @return html
     */
    public function index()
    {
        $this->pageTitle = "用户管理";
        $this->assign('pageTitle',$this->pageTitle);

        // 查询用户数据
        $members =  $this->member->getMembers();
        $this->assign('members', $members);
//        dump(collection($members)->toArray());die();
        $department = $this->department->getDepartment();
        $this->assign('department',$department);
        return $this->fetch();
    }

    /**
     * 显示创建资源表单页.
     *
     *  @return html
     */
    public function create()
    {
        $this->pageTitle = "创建用户";
        $this->assign('pageTitle',$this->pageTitle);
        return $this->fetch();
    }

    /**
     * 保存新建的资源
     *
     * @param  Member  $member
     * @param  \think\Request  $request
     * @return \think\Response
     */
    public function save()
    {
        // 获取经过过滤的全部post变量且保存
        $data = $this->request->param();
        $result = $this->validate($data,'Member.create');
        if(true !== $result) {
            return $this->error($result);
        }
        if($this->member->saveInfo($data)){
            return $this->success('保存成功');
        }else{
            return $this->error($this->member->getError());
        }
    }

    /**
     * 显示编辑资源表单页.
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function edit($id,$departmentId)
    {
        $memberInfo =  $this->member->getMemberInfo($id);
        if($memberInfo){
            $department = $this->department->getDepartment();
            $this->assign('department',$department);
            $role = $this->role->getRoleMember($departmentId);
            $this->assign('role',$role);

            $this->assign("member", $memberInfo);
            $data = $this->fetch();
            return $this->success("编辑用户", url("index"), $data);
        }else{
            return $this->error("编辑失败");
        }
    }

    /**
     * 保存更新的资源
     * @param  int  $id
     * @return \think\Response
     */
    public function update()
    {
        // 获取经过过滤的全部post变量且保存
        $data = $this->request->param();
        $result = $this->validate($data,'Member.update');
        if(true !== $result) {
            return $this->error($result);
        }
        if($this->member->updateInfo($data)){
            return $this->success('保存成功');
        }else{
            return $this->error($this->member->getError());
        }

    }

    /**
     * 删除指定资源
     * @param  int  $id
     * @return \think\Response
     */
    public function delete($id)
    {
        try{
            $res = $this->member->delMember($id);
            if($res) {
                return $this->success('删除成功', url("index"));
            }else{
                return $this->error($this->member->getError());
            }
        }catch (Exception $e){
            return $this->error($e->getMessage());
        }
    }

    /**
     * 更新指定资源状态
     *
     * @return \think\Response
     */
    public function status()
    {
        $data = $this->request->param();
        if($this->member->updateStatus($data)){
            return $this->success('保存成功');
        }else{
            return $this->error($this->member->getError());
        }
    }

    /**
     * 更新修改密码
     *
     * @return \think\Response
     */
    public function password()
    {
        $data = $this->fetch();
        return $this->success("修改密码", url("index"), $data);
    }

    /**
     * 更新指定用户密码
     *
     * @return \think\Response
     */
    public function updatePassword()
    {
        $data = $this->request->param();
        $result = $this->validate($data,'Member.repassword');
        if(true !== $result) {
            return $this->error($result);
        }
        if($this->member->updatePassword($data)){
            return $this->success('保存成功');
        }else{
            return $this->error($this->member->getError());
        }
    }

    /**
     * @param $id
     * 得到想过部门的角色
     */
    public function getRoles($id){
        $resultId = \app\common\model\Department::where('id',$id)->value('d_role_id');
        $result   = \app\common\model\Role::where('id','in',$resultId)->select();

//        $result = Db::name('tnaddress_1')->field('id,address')->where('pid', $id)->select();

        return $result;
    }

}