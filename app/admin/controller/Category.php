<?php
/**
 * Created by PhpStorm.
 * User: hujj
 * Date: 2017/2/23
 * Time: 9:23
 */
namespace app\admin\controller;

use app\common\service\Category as CategoryService;

class Category extends Base
{
    protected $category;

    public function __construct(CategoryService $category)
    {
        parent::__construct();
        $this->category = $category;
    }

    /**
     * 显示指定模型的字段列表
     * @return \think\Response
     */
    public function index()
    {
        $this->pageTitle = "栏目管理";
        $this->assign('pageTitle',$this->pageTitle);
        $this->assign("categorys", $this->category->getCategorys());
        $this->assign("pid", "");
        return $this->fetch();
    }

    /**
     * 显示创建子栏目.
     *
     * @param int $id
     * @return \think\Response
     */
    public function createSub($id)
    {
        $this->assign("categorys", $this->category->getCategorys());
        $this->assign("pid", $id);
        $data = $this->fetch();
        return $this->success("新建子栏目", url("index"), $data);
    }

    /**
     * 编辑栏目
     *
     * @param int $id
     * @return \think\Response
     */
    public function edit($id)
    {
        $category = $this->category->getCategoryById($id);
        if($category){
            $this->assign("categorys", $this->category->getCategorys());
            $this->assign("category", $category);
            $data = $this->fetch();
            return $this->success("编辑栏目", url("index"), $data);
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
        $res = $this->category->saveCategory($data);
        if($res) {
            return $this->success(lang("保存成功"), url("index"));
        }else{
            return $this->error($this->category->getError());
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
        $res = $this->category->deleteCategory($id);
        if($res) {
            return $this->success(lang("删除成功"), url("index"));
        }else{
            return $this->error($this->category->getError());
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
        $res = $this->category->updataCategorySort($param["param"]);
        if($res) {
            return $this->success("排序成功", url("index"));
        }else{
            return $this->error($this->category->getError());
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
        $res = $this->category->updateStatus($id, $status);
        if($res){
            return $this->success(lang("保存成功"));
        }else{
            return $this->error($this->category->getError());
        }
    }

    /**
     * 更新指定是否主导航
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function nav($id, $nav)
    {
        $res = $this->category->updateNav($id, $nav);
        if($res){
            return $this->success(lang("保存成功"));
        }else{
            return $this->error($this->category->getError());
        }
    }
}