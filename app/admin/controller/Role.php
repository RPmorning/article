<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/2/7-0007
 * Time: 11:31
 */
namespace app\admin\controller;

use app\common\model\Operation;
use app\common\service\Role as RoleService;
use think\Request;
use app\common\service\Category;

class Role extends Base
{

    protected $role;
    protected $category;

    public function __construct(RoleService $role,Category $category)
    {
        parent::__construct();
        $this->role = $role;
        $this->category = $category;
        $this->assign("roles", $this->role->getRoles());
    }

    /**
     * 显示角色列表
     *
     * @return html
     */
    public function index()
    {
        $this->pageTitle = "角色列表";
        $this->assign('pageTitle',$this->pageTitle);
        $category = $this->category->getCategorysForRole();
        $this->assign('category',$category);
        return $this->fetch();
    }
    /**
     * 显示菜单授权资源列表
     *
     * @return html
     */
    public function menu($id)
    {
        $this->pageTitle = "菜单授权";
        $this->assign('pageTitle',$this->pageTitle);
        $authRule = RoleService::getRuleMenu($id);
        $role = $this->role->getRoleInfo($id);
        $this->assign("rules", $role->rules);
        $this->assign("authRule", $authRule);
        return $this->fetch();
    }

    //更新人员的菜单
    public function updatemenu(){
        $post = $this->request->post();
        try{
            $res = $this->role->updateRuleMenu($post);
            if($res) {
//                return $this->success(lang("save success"), url("menu", "id=".$post["id"]));
                return $this->success(lang("菜单更新成功"), url('index'));
            }else{
                return $this->error(lang("菜单更新失败"));
            }
        }catch (Exception $e){
            return $this->error($e->getMessage());
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
        $res = $this->role->updateStatus($id, $status);
        if($res){
            return $this->success("保存成功");
        }else{
            return $this->error("保存失败");
        }
    }


    /**
     * @param $id
     * 编辑角色信息
     */
    public function edit($id){
        $role = $this->role->getThisRole($id);
        $this->assign('role',$role);
//        $aa = $role->opertain->id;
//        dump($aa);die();
        $category = $this->category->getCategorysForRole();
        $this->assign('category',$category);

        $data = $this->fetch('edit');
        return $this->success("编辑角色", url("edit"), $data);
    }

    public function update(Request $request){
        $res = $request->param();

        $res['data']['category'] = $res['role_category'];
        $res['role'] = ['name'=>$res['data']['name'],'desc'=>$res['data']['desc'],'id'=>$res['data']['id']];
        unset($res['data']['name']);
        unset($res['data']['desc']);
        unset($res['data']['id']);

        $res['data']['id'] = $res['data']['oid'];
        unset($res['data']['oid']);
        if(!isset($res['data']['operation_create'])){
            $res['data']['operation_create'] = 0;
        }
        if(!isset($res['data']['operation_update'])){
            $res['data']['operation_update'] = 0;
        }
        if(!isset($res['data']['operation_delete'])){
            $res['data']['operation_delete'] = 0;
        }
        if(!isset($res['data']['operation_check'])){
            $res['data']['operation_check'] = 0;
        }
        Operation::update($res['data']);

        $data = $this->role->updateRole($res['role']);
        if($data == 1){
            return $this->success('更新成功');
        }else{
            return $this->error('更新失败');
        }
    }

    /**
     * @param Request $request
     * 新建角色
     */
    public function save(Request $request){
        $res = $request->param();
        $res['data']['category'] = $res['role_category'];
        $res['role'] = ['name'=>$res['data']['name'],'desc'=>$res['data']['desc']];
        unset($res['data']['name']);
        unset($res['data']['desc']);

        $operation = new Operation();
        $operation->save($res['data']);

        $res['role']['operation_id'] = $operation->getLastInsID();
        $data = $this->role->saveRole($res['role']);
        if($data){
            return $this->success('新建成功,请继续菜单授权','/admin/role/menu/id/'.$data);
        }else{
            return $this->error('新建失败');
        }
    }

    /**
     * @param $id
     * 删除指定资源
     */
    public function delete($id){
        $res = $this->role->deleteRole($id);
        if($res) {
            return $this->success(lang("删除成功"), url("index"));
        }else{
            return $this->error($this->role->getError());
        }
    }

//    public function create(){
//
//        return $this->fetch();
//    }

    public function category(){
        $this->pageTitle = "添加菜单";
        $this->assign('pageTitle',$this->pageTitle);
        $category = $this->category->getCategorysForRole();
        $this->assign('category',$category);
        return $this->fetch('create');
    }
}
