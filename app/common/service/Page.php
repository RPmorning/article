<?php

namespace app\common\service;

use app\common\model\Page as PageModel;

class Page extends PageModel
{
    /**
     * 获取页面列表
     * @param int $categoryId 分类ID
     * @return
     */
    public function getPages($categoryId = null)
    {
        $map = [];
        if($categoryId) $map["category_id"] = $categoryId;
        $pages = $this::with("member")->where($map)->paginate();
        if($pages){
            return $pages;
        }else{
            $this->error = "还没有页面";
            return false;
        }
    }


    /**
     * 保存页面
     * @param array $data
     */
    public function savePage($data)
    {
        $data["member_id"] = UID;
        try {
            if(empty($data["id"])) { // 新增
                $this::allowField(true)->save($data);
            }else{ // 更新
                $page = $this::get(["category_id" => $data["id"]]);
                if(!$page) return false;
                $page->allowField(true)->save($data);
            }
            return true;
        } catch (\Exception $e) {
            $this->error = $e->getMessage();
            return false;
        }
    }

    /**
     * 获取指定页面
     *
     * @param integer $cid
     * @return mixed
     */
    public function getPageById($cid)
    {
        $page = $this::get(["category_id"=>$cid], 'member');
        if($page){
            return $page;
        }else{
            $this->error = "该页面不存在";
            return false;
        }
    }




    /**
     * 保存封面图片，不含数据库保存
     * @return array 成功返回网站参数配置，失败-返回-false
     */
    public function saveCover($file)
    {
        if(empty($file)) {
            $this->error = '请选择上传文件';
            return false;
        }
        static $upload = null;
        if (!$upload) {
            $upload = new \sckr\Upload();
        }
        $info = $upload->uploadFile($file, "image");
        if($info){
            return $info;
        }else{
            $this->error = $upload->getError();
            return false;
        }
    }
}