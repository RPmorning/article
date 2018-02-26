<?php
/**
 * Created by PhpStorm.
 * User: hujj
 * Date: 2017/2/23
 * Time: 9:23
 */
namespace app\admin\controller;

use app\common\service\Page as PageService;
use app\common\service\Category as CategoryService;

class Page extends Base
{
    protected $page;
    protected $category;
    public function __construct(PageService $page, CategoryService $category)
    {
        parent::__construct();
        $this->page = $page;
        $this->category = $category;
    }

    /**
     * 显示指定模型的字段列表
     * @param int @cid 栏目分类ID
     * @return \think\Response
     */
    public function index($cid = null)
    {

        $this->pageTitle = "页面管理";
        $this->assign('pageTitle',$this->pageTitle);
        $categorys = $this->category->getCategorysByType(1);
        $this->assign("categorys", $categorys);
        if(empty($cid)){
            $categorysArray = collection($categorys)->toArray();
            $cid = $categorysArray[0]["id"];
        }
        $this->assign("page", $this->page->getPageById($cid));
        return $this->fetch();
    }

    /**
     * 保存资源
     *
     * @return \think\Response
     */
    public function save()
    {
        $data = $this->request->post();
        $cid = $data["category_id"];
        $res = $this->page->savePage($data);
        if($res) {
            return $this->success(lang("save success"), url("index", ["cid"=>$cid]));
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
        $res = $this->page->deletePage($id);
        if($res) {
            return $this->success(lang("delete success"), url("index"));
        }else{
            return $this->error(lang("delete failed"));
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
        $res = $this->page->updataSort($param["param"]);
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
        $res = $this->page->updateStatus($id, $status);
        if($res){
            return $this->success(lang("save success"));
        }else{
            return $this->error(lang("save failed"));
        }
    }


    /**
     * 编辑器图片上传
     * @return \think\response\Json
     */
    public function file()
    {
        $file = $this->request->file("file");
        $path = $this->page->saveCover($file);
        if($path){
            $result = [
                'code' => 0,
                'data' => [
                    'src' => config('upload')['path'] . DS . $path
                ]
            ];
        }else{
            $result = [
                'code' => 1,
                'msg' =>  $this->page->getError(),
                'data' => [
                    'src' => ''
                ]
            ];
        }
        return json($result, 200);
    }
}