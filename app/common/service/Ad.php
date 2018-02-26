<?php

namespace app\common\service;

use app\common\model\Ad as AdModel;

class Ad extends AdModel
{
    /**
     * 获取文档列表
     * @param int $categoryId 分类ID
     * @return tree
     */
    public static function getAds()
    {

        $ad= parent::with("member")->order("id desc")->paginate();
        if($ad){
            return $ad;
        }else{
            return false;
        }
    }


    /**
     * 保存文档
     * @param array $data
     */
    public function saveAd($data)
    {
        $data["member_id"] = UID;
        try {
            if(isset($data["id"])) { // 更新
                $ad = $this::get($data["id"]);
                if(!$ad) return false;
                $ad->allowField(true)->save($data);
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
     * 获取指定广告
     *
     * @param integer $id
     * @parame integer $status
     * @return mixed
     */
    public static function getAdById($id, $status = -1)
    {
        $map["id"] = $id;
        if($status == 1) $map["status"] = 1;
        $ad = parent::get($map, 'member');
        if($ad){
            return $ad;
        }else{
            return false;
        }
    }

    /**
     * 删除指定文档
     *
     * @param array $data
     * @return bool
     */
    public function deleteAd($id)
    {
        $ad = $this::get($id);
        if($ad){
            try {
                $ad->delete();
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