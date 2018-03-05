<?php

namespace app\common\service;

use app\common\model\Article as ArticleModel;

class Article extends ArticleModel
{
    /**
     * 获取文章列表
     * @param int $categoryId 分类ID
     * @param int $status 状态
     * @return tree
     */
//    public function getArticles($categoryId = null, $status = -1)
//    {
//        $map = [];
//        if($categoryId) $map["category_id"] = $categoryId;
//        if($status == 1) $map["status"] = $status;
//        $articles = $this::with("member")->where($map)->field('content',true)->order("id desc")->paginate();
//        if($articles){
//            return $articles;
//        }else{
//            $this->error = "还没有文章";
//            return false;
//        }
//    }
    public function getArticles($categoryId = null, $status = -1)
    {
        $uid = session('user_auth')['uid'];
        $user = \app\common\model\Member::where('id',$uid)->find();
        $categories = $user->role->operation->category;
        $map = [];
        if($categoryId) $map["category_id"] = $categoryId;
        if($status == 1) $map["status"] = $status;

        if($categoryId){
            $articles = $this::with("member")->where($map)
                ->field('content',true)->order("update_time desc")->paginate();
        }else{
            $articles = $this::with("member")->where($map)
            ->where('category_id','in',$categories)
                ->field('content',true)->order("update_time desc")->paginate();
        }
        if($articles){
            return $articles;
        }else{
            $this->error = "还没有文章";
            return false;
        }
    }

    /**
     * 获取用户对文章的权限
     */
    public function getArticlePower(){
        $uid = session('user_auth')['uid'];
        $user = \app\common\model\Member::where('id',$uid)->find();
        $operation = $user->role->operation_id;
        $power = \app\common\model\Operation::where('id',$operation)->find();
        if($power){
            return $power;
        }else{
            return false;
        }
    }

    /**
     * 根据文章名称获取列表
     * @param int $categoryId 分类ID
     * @param int $status 状态
     * @return tree
     */
    public function getArticleByName($name)
    {
        $map = [];
        if($name) $map["name"] = ['like', '%' .$name . '%'];
        $map["status"] = 1;
        $articles = $this::with("member")->where($map)->field('content',true)->order("id desc")->paginate();
        if($articles){
            return $articles;
        }else{
            $this->error = "还没有文章";
            return false;
        }
    }


    /**
     * 保存文章
     * @param array $data
     */
    public function saveArticle($data)
    {
        $data["member_id"] = UID;
        try {
            if(isset($data["id"])) { // 更新
                $article = $this::get($data["id"]);
                if(!$article) return false;
                $article->allowField(true)->save($data);
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
     * 获取指定文章
     *
     * @param integer $id
     * @parame integer $status
     * @return mixed
     */
    public static function getArticleById($id, $status = -1)
    {
        $map["id"] = $id;
        if($status == 1) $map["status"] = 1;
        $article = parent::get($map, 'member');
        if($status == 1){ // 实现前一篇 后一篇
            $cid = $article->getData("category_id");
            $map['category_id'] = array('eq', $cid);
            $article->url = url('category/index','mid=0&id='.$cid);
            $map['id'] = array('lt',$id);
            $prev = self::where($map)->order("id desc")->field("id,name")->limit(1)->find();
            if($prev)  $prev->url = url('detail/index','mid=0&id='.$prev->id);
            $map['id'] = array('gt',$id);
            $next = self::where($map)->order("id asc")->field("id,name")->limit(1)->find();
            if($next) $next->url = url('detail/index','mid=0&id='.$next->id);
            $article->prev = $prev;
            $article->next = $next;
        }
        if($article){
            return $article;
        }else{
            return false;
        }
    }

    /**
     * 发布指定文章
     *
     * @param array $data
     * @return bool
     */
    public function releaseArticle($id){

        $article = new ArticleModel();
        $article->where('id', $id)
            ->update(['check_status' => 1]);
        if($article){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 删除指定文章
     *
     * @param array $data
     * @return bool
     */
    public function deleteArticle($id)
    {
        $article = $this::get($id);
        if($article){
            try {
                $article->delete();
                return true;
            } catch (\Exception $e) {
                $this->error = $e->getMessage();
                return false;
            }
        }else{
            $this->error = "该文章不存在";
            return false;
        }
    }

    /**
     * 排序文章
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
     * 搜索
     */
    public function searchArticle($res){
        $uid = session('user_auth')['uid'];
        $user = \app\common\model\Member::where('id',$uid)->find();
        $categories = $user->role->operation->category;
        if($res['check_status'] == 2){
            $temp1  =  'check_status <> 2';
        }else{
            $temp1 = 'check_status = '.$res['check_status'];
        }
        if($res['category_id'] == 0){
            $temp2  =  'category_id <> 0';
        }else{
            $temp2 = 'category_id = '.$res['category_id'];
        }
        $data = ArticleModel::where($temp1)->where($temp2)->order('update_time desc')
            ->where('category_id','in',$categories)
            ->field('content',true)->paginate();
        if($data){
            return $data;
        }else{
            return false;
        }
    }

    public function getArticleByTypeList($res){
        $number = 8;
        if(isset($res['count'])){
            $number = $res['count'];
        }
        $temp = \app\common\model\Category::where('id',$res['category_id'])->select();
        $data = ArticleModel::where('category_id',$res['category_id'])->order('update_time desc')
            ->field('id,name,cover,update_time,desc')
            ->paginate($number);
        $dataTemp['channelId'] = $temp[0]['id'];
        $dataTemp['name'] = $temp[0]['name'];
        $dataTemp['items'] = $data;
        return $dataTemp;
    }

    public function getArticleByKeyword($res){
        if(isset($res['count'])){
            $number = $res['count'];
        }else{
            $number = 10;
        }
        $data = ArticleModel::where('name', 'like', '%' . $res['keyword'] . '%')
            ->order('update_time desc')
            ->field('id,name,update_time,desc')
            ->paginate($number);
        return $data;
    }

    public function getArticleByArticleId($res){
        $articleModel  = new ArticleModel();
        $data = $articleModel->where('id',$res['id'])
            ->field('id,name,update_time,content,view,category_id')
            ->find();
        $time = $data->getData('update_time');

        $data->category->name;
        $data->time = date('Y-m-d H:i:s',$time);
        unset($data['category']);
        return $data;
    }

    public function saveView($res){
        $articleModel  = new ArticleModel();
        $count = $articleModel->where('id',$res['articleId'])->value('view');
        $count = $count + 1;
        $articleModel->save([
            'view'  => $count,
        ],['id' => $res['articleId']]);

    }

}