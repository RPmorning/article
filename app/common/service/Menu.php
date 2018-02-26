<?php

namespace app\common\Service;

use app\common\model\Menu as MenuModel;

class Menu extends MenuModel
{
    /**
     * 获取所有菜单
     * @param integer $status
     * @return mixed
     */
    public function getMenus($status = 1)
    {
        $menus = $this::all(['status'=> $status]);
        if($menus){
            return $menus;
        }else{
            $this->error = "系统暂无菜单";
            return false;
        }
    }
    /**
     * 保存菜单
     * @param array $data
     */
    public function saveMenu($data)
    {
        // 表单验证
        $validate = validate('Menu');
        if($validate->check($data)) {
            $url = $data["module"] . "/" . $data["controller"] . "/" . $data["action"];
            $data["url"] = empty($data["param"]) ? $url : ($url  . "/" .$data["param"]);
            $data["level"] = $data["level"] + 1;

            $ruleData = array(
                "url" => $data["url"],
                "name" => $data["name"]
            );
            try {
                if(isset($data["id"])) { // 更新
                    $menu = $this::get($data["id"]);
                    $ruleId = $menu->authRule->id;
                    if($menu->allowField(true)->save($data)){
                        $menu->authRule()->where("id","$ruleId")->update($ruleData);
                        $this->error = "菜单更新成功";
                    }else{
                        $this->error = "菜单更新失败";
                        return false;
                    }
                }else{ // 新增
                    if($this->allowField(true)->save($data)){
                        $this->authRule()->save($ruleData);
                        $this->error = "菜单新增成功";
                    }else{
                        $this->error = "菜单新增失败";
                        return false;
                    }
                }
                return true;
            } catch (\Exception $e) {
               $this->error = $e->getMessage();
               return false;
            }
        } else{
            $this->error = $validate->getError();;
            return false;
        }
    }
    /**
     * 获取指定菜单
     * @param array $data
     */
    public function getMenuById($id)
    {
        $menu = $this::get($id);
        if($menu){
            $url = explode("/", $menu->url);
            $menu->module = $url[0];
            $menu->controller = $url[1];
            $menu->action = $url[2];
            $menu->param = isset($url[3]) ? $url[3] : null;
            return $menu;
        }else{
            $this->error = "该菜单不存在";
            return false;
        }
    }

    /**
     * 删除指定菜单
     *
     * @param array $data
     * @return bool
     */
    public function deleteMenu($id)
    {
        $menu = $this::get(["pid" => $id]);
        if($menu) {
            $this->error = "删除失败，当前菜单拥有子菜单";
            return false;
        }
        $menu = $this::get($id);
        if($menu){
            if($menu->delete()){
                $menu->authRule->delete();
            }else{
                $this->error = "菜单删除失败";
                return false;
            }
            $this->error = "菜单删除成功";
            return true;
        }else{
            $this->error = "该菜单不存在";
            return false;
        }
    }

    /**
     * 排序菜单
     *
     * @param array $data
     * @return bool
     */
    public function updataMenuSort($data)
    {
        $result = $this->saveAll($data);
        if($result) {
            return true;
        }else{
            $this->error = "排序失败";
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

    // 生成模块控制器方法
    public function buildRun()
    {
        $admin = [
            "admin" => [
                'controller'=>  ['Community'],
                'view'      =>  ['server/community'],
            ]
        ];
        \think\Build::run($admin, APP_PATH);

    }
}