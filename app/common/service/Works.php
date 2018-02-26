<?php

namespace app\common\service;

use app\common\model\Works as WorksModel;

class Works extends WorksModel
{
    /**
     * 获取作品列表
     * @param int $categoryId 分类ID
     * @param int $status 状态
     * @return tree
     */
    public function getWorks($categoryId = null, $status = -1)
    {
        $map = [];
        if($categoryId) $map["category_id"] = $categoryId;
        if($status == 1) $map["status"] = 1;
        $works= $this::with("member")->where($map)->field('content',true)->order("id desc")->paginate();
        if($works){
            return $works;
        }else{
            $this->error = "还没有作品";
            return false;
        }
    }


    /**
     * 保存作品
     * @param array $data
     */
    public function saveWorks($data)
    {
        $data["member_id"] = UID;
        try {
            if(isset($data["id"])) { // 更新
                $works = $this::get($data["id"]);
                if(!$works) return false;
                $works->allowField(true)->save($data);
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
     * 获取指定作品
     *
     * @param integer $id
     * @parame integer $status
     * @return mixed
     */
    public static function getWorksById($id, $status = -1)
    {
        $map["id"] = $id;
        if($status == 1) $map["status"] = 1;
        $works = parent::get($map, 'member');
        if($status == 1){ // 实现前一篇 后一篇
            // 获取内容图片
            $images = get_content_images($works->getData("content"));
            $works->images = $images;
            $cid = $works->getData("category_id");
            $map['category_id'] = array('eq', $cid);
            $works->url = url('category/index','mid=1&id='.$cid);
            $map['id'] = array('lt',$id);
            $prev = self::where($map)->order("id desc")->field("id,name")->limit(1)->find();
            if($prev)  $prev->url = url('detail/index','mid=1&id='.$prev->id);
            $map['id'] = array('gt',$id);
            $next = self::where($map)->order("id asc")->field("id,name")->limit(1)->find();
            if($next) $next->url = url('detail/index','mid=1&id='.$next->id);
            $works->prev = $prev;
            $works->next = $next;
        }
        if($works){
            return $works;
        }else{
            return false;
        }
    }

    /**
     * 删除指定作品
     *
     * @param array $data
     * @return bool
     */
    public function deleteWorks($id)
    {
        $works = $this::get($id);
        if($works){
            try {
                $works->delete();
                return true;
            } catch (\Exception $e) {
                $this->error = $e->getMessage();
                return false;
            }
        }else{
            $this->error = "该作品不存在";
            return false;
        }
    }

    /**
     * 排序作品
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