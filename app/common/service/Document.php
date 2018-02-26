<?php

namespace app\common\service;

use app\common\model\Document as DocumentModel;
use app\common\service\Asset as AssetService;

class Document extends DocumentModel
{
    /**
     * 获取文档列表
     * @param int $categoryId 分类ID
     * @return tree
     */
    public function getDocuments($categoryId = null, $status = -1)
    {
        $map = [];
        if($categoryId) $map["category_id"] = $categoryId;
        if($status == 1) $map["status"] = 1;
        $document= $this::with(["member"])->where($map)->order("id desc")->paginate();
        if($document){
            return $document;
        }else{
            $this->error = "还没有文档";
            return false;
        }
    }


    /**
     * 保存文档
     * @param array $data
     */
    public function saveDocument($data)
    {
        $data["member_id"] = UID;
        try {
            if(isset($data["id"])) { // 更新
                $document = $this::get($data["id"]);
                if(!$document) return false;
                $document->allowField(true)->save($data);
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
     * @parame integer $status
     * @return mixed
     */
    public static function getDocumentById($id, $status = -1)
    {
        $map["id"] = $id;
        if($status == 1) $map["status"] = 1;
        $document = parent::get($map, 'member');
        $asset  = AssetService::where("file_path", $document->cover)->value("filename");
        $document->filename = $asset;
        if($status == 1){ // 实现前一篇 后一篇
            $cid = $document->getData("category_id");
            $map['category_id'] = array('eq', $cid);
            $document->url = url('category/index','mid=2&id='.$cid);
            $map['id'] = array('lt',$id);
            $prev = self::where($map)->order("id desc")->field("id,name")->limit(1)->find();
            if($prev)  $prev->url = url('detail/index','mid=2&id='.$prev->id);
            $map['id'] = array('gt',$id);
            $next = self::where($map)->order("id asc")->field("id,name")->limit(1)->find();
            if($next) $next->url = url('detail/index','mid=2&id='.$next->id);
            $document->prev = $prev;
            $document->next = $next;
        }
        if($document){
            return $document;
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
    public function deleteDocument($id)
    {
        $document = $this::get($id);
        if($document){
            try {
                $document->delete();
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
     * 保存文档附件，不含数据库保存
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
        $info = $upload->uploadFile($file, "file");
        if($info){
            return $info;
        }else{
            $this->error = $upload->getError();
            return false;
        }
    }
}