<?php

namespace app\common\service;

use app\common\model\Link as LinkModel;

class Link extends LinkModel
{
    /**
     * 获取文档列表
     * @param int $status 状态
     * @return tree
     */
    public static function getLinks($status = null)
    {
        $map = [];
        if($status) $map["status"] = $status;
        $link= parent::with("member")->where($map)->field('content',true)->paginate();
        if($link){
            return $link;
        }else{
            return false;
        }
    }


    /**
     * 保存文档
     * @param array $data
     */
    public function saveLink($data)
    {
        $data["member_id"] = UID;
        try {
            if(isset($data["id"])) { // 更新
                $link = $this::get($data["id"]);
                if(!$link) return false;
                $link->allowField(true)->save($data);
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
     * 获取指定文档
     *
     * @param integer $id
     * @return mixed
     */
    public function getLinkById($id)
    {
        $link = $this::get($id, 'member');
        if($link){
            return $link;
        }else{
            $this->error = "该文档不存在";
            return false;
        }
    }

    /**
     * 删除指定文档
     *
     * @param array $data
     * @return bool
     */
    public function deleteLink($id)
    {
        $link = $this::get($id);
        if($link){
            try {
                $link->delete();
                return true;
            } catch (\Exception $e) {
                $this->error = $e->getMessage();
                return false;
            }
        }else{
            $this->error = "该文档不存在";
            return false;
        }
    }

    /**
     * 排序文档
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
}