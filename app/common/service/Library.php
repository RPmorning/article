<?php

namespace app\common\service;

use app\common\model\Library as LibraryModel;
use app\common\model\Asset as AssetModel;

class Library extends LibraryModel
{
    /**
     * 获取期刊列表
     * @param int $status 状态
     * @return tree
     */
    public function getLibrarys($status = -1)
    {
//        $map = [];
//        if($status) $map["status"] = 1;
        $library= $this::with("member")->paginate();
        if($library){
            return $library;
        }else{
            $this->error = "还没有文件头";
            return false;
        }
    }


    /**
     * 保存期刊
     * @param array $data
     */
    public function saveLibrary($data)
    {
        $data["member_id"] = UID;
        try {
            if(isset($data["id"])) { // 更新
                $library = $this::get($data["id"]);
                if(!$library) return false;
                $library->allowField(true)->save($data);
            }else{ // 新增
                $this::allowField(true)->save($data);
            }
            return true;
        } catch (\Exception $e) {
            $this->error = $e->getMessage();
            return false;
        }
    }

    /**
     * 获取指定期刊
     *
     * @param integer $id
     * @parame integer $status
     * @return mixed
     */
    public static function getLibraryById($id)
    {
        $library = LibraryModel::where('id',$id)->find();
        if($library){
            return $library;
        }else{
            return false;
        }
    }

    /**
     * 删除指定期刊
     *
     * @param array $data
     * @return bool
     */
    public function deleteLibrary($id)
    {
        $library = $this::get($id);
        if($library){
            try {
                $library->delete();
                return true;
            } catch (\Exception $e) {
                $this->error = $e->getMessage();
                return false;
            }
        }else{
            $this->error = "该期刊不存在";
            return false;
        }
    }

    /**
     * 排序期刊
     *
     * @param array $data
     * @return bool
     */
    public function updataSort($data)
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
    /**
     * 保存封面图片，不含数据库保存
     * @return array 成功返回网站参数配置，失败-返回-false
     */
    public function saveAttachment($file)
    {
        if(empty($file)) {
            $this->error = '请选择上传文件';
            return false;
        }
        static $upload = null;
        if (!$upload) {
            $upload = new \sckr\Upload();
        }
        $info = $upload->uploadFile($file, "file");
        if($info){
            return $info;
        }else{
            $this->error = $upload->getError();
            return false;
        }
    }
}