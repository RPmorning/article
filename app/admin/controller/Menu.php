<?php
/**
 * Created by PhpStorm.
 * User: hujj
 * Date: 2017/2/23
 * Time: 9:23
 */
namespace app\admin\controller;

use app\common\service\Menu as MenuService;

class Menu extends Base
{
    protected $menu;

    public function __construct(MenuService $menu)
    {
        parent::__construct();
        $this->menu = $menu;
    }


    /**
     * 显示菜单列表.
     *
     */
     public function index()
     {
         $this->pageTitle = "系统菜单";
         $this->assign('pageTitle',$this->pageTitle);
         $this->assign('systemMenus', tree_select($this->menu->getMenus(0)));
         $this->assign("pid", "");
         return $this->fetch();
     }

    /**
     * 显示创建子菜单.
     *
     * @param int $id
     * @return \think\Response
     */
    public function create($id)
    {
        $this->assign('systemMenus', tree_select($this->menu->getMenus(0)));
        $this->assign("pid", $id);
        $data = $this->fetch();
        return $this->success("新建子菜单", url("index"), $data);
    }

    /**
     * 编辑菜单
     *
     * @param int $id
     * @param int $pid
     * @return \think\Response
     */
    public function edit($id)
    {
        $menu =  $this->menu->getMenuById($id);
        if($menu){
            $this->assign('systemMenus', tree_select($this->menu->getMenus(0)));
            $this->assign("menu", $menu);
            $data = $this->fetch();
            return $this->success("编辑菜单", url("index"), $data);
        }else{
            return $this->error("编辑失败");
        }
    }


    /**
     * 保存新建的资源
     *
     * @return \think\Response
     */
    public function save()
    {
        $data = $this->request->post();
        $res = $this->menu->saveMenu($data);
        if($res) {
            return $this->success($this->menu->getError(), url("index"));
        }else{
            return $this->error($this->menu->getError());
        }

    }


    /**
     * 删除指定资源
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function delete($id)
    {
        $res = $this->menu->deleteMenu($id);
        if($res) {
            return $this->success($this->menu->getError(), url("index"));
        }else{
            return $this->error($this->menu->getError());
        }
    }

    /**
     * 生成指定资源
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function build($id)
    {
        $res = $this->menu->buildRun();
        if($res) {
            return $this->success("生成成功", url("index"));
        }else{
            return $this->error("生成失败");
        }
    }

    /**
     * 对资源进行排序
     *
     * @return \think\Request  $request
     */
    public function sort()
    {
        $param = $this->request->param();
        $res = $this->menu->updataMenuSort($param["param"]);
        if($res) {
            return $this->success("排序成功", url("index"));
        }else{
            return $this->error($this->menu->getError());
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
        $res = $this->menu->updateStatus($id, $status);
        if($res){
            return $this->success(lang("save success"));
        }else{
            return $this->error(lang("save failed"));
        }
    }

    /**
     * 显示图标资源
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function icon()
    {
        $data = $this->fetch();
        return $this->success("图标选择", url("index"), $data);
    }
}