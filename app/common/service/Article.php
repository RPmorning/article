<?php

namespace app\common\service;

use app\common\model\Article as ArticleModel;
use app\common\model\Category as CategoryModel;
use app\common\model\Department;

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
    public function getArticles($categoryId = null, $checked = null)
    {
//        $uid = session('user_auth')['uid'];
//        $user = \app\common\model\Member::where('id',$uid)->find();
//        $categories = $user->role->operation->category;
//        $map = [];
//        if($categoryId) $map["category_id"] = $categoryId;
//        if($checked != 2) $map["check_status"] = $checked;

        $uid = session('user_auth')['uid'];
        $department_id = session('user_auth')['department_id'];
        $departments = \app\common\model\Member::where('department_id',$department_id)->column('id');
        $departments = implode(",",$departments);
        if($uid != 1){
            $user = \app\common\model\Member::where('id',$uid)->find();
            $categories = $user->role->operation->category;
        }
        $map = [];
        if($categoryId) $map["category_id"] = $categoryId;
        if($checked != 2) $map["check_status"] = $checked;

        if($uid != 1){
            if($categoryId){

                $articles = $this::with("member")->where($map)
                    ->where('member_id','in',$departments)
                    ->field('content',true)->order("update_time desc")->paginate();
            }else{
                $articles = $this::with("member")->where($map)
                ->where('category_id','in',$categories)
                    ->where('member_id','in',$departments)
                    ->field('content',true)->order("update_time desc")->paginate();
            }
        }else{
            $articles = $this::with("member")->where($map)
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
        if($data['is_top'] == 1){
            $dataTemp = ArticleModel::where('category_id',$data['category_id'])->where('is_top',1)->find();
            if($dataTemp){
                ArticleModel::where('category_id',$data['category_id'])->where('is_top',1)->update(['is_top'=>0]);
            }

        }
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

        //保存分数
        $articleInfo = $article->where('id',$id)->field('category_id,member_id')->find();
        $scoreCategory = CategoryModel::where('id',$articleInfo['category_id'])->value('score');
        $departmentId = \app\common\model\Member::where('id',$articleInfo['member_id'])->value('department_id');
        $score = Department::where('id',$departmentId)->value('score');
        $scoreNew = $score + $scoreCategory;
        Department::where('id', $departmentId)->update(['score' => $scoreNew]);

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
        $department_id = session('user_auth')['department_id'];
        $departments = \app\common\model\Member::where('department_id',$department_id)->column('id');
        $departments = implode(",",$departments);

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
        if($uid != 1){
            $data = ArticleModel::where($temp1)->where($temp2)->order('update_time desc')
                ->where('category_id','in',$categories)
                ->where('member_id','in',$departments)
                ->field('content',true)->paginate();
        }else{
            $data = ArticleModel::where($temp1)->where($temp2)->order('update_time desc')
                ->field('content',true)->paginate();
        }
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
        $data = ArticleModel::where('category_id',$res['category_id'])->order('is_top desc,update_time desc')
            ->where('check_status',1)
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
            ->where('check_status',1)
            ->order('update_time desc')
            ->field('id,name,update_time,desc')
            ->paginate($number);
        return $data;
    }

    public function getArticleByArticleId($res){
        $articleModel  = new ArticleModel();
        $data = $articleModel->where('id',$res['id'])
            ->where('check_status',1)
            ->field('id,name,update_time,content,view,category_id,tag,departments')
            ->find();
        $time = $data->getData('update_time');

        $data->categoryName = $data->category['name'];
        $data->documentTitle = $data->library['name'];
        $data->documentContent = $data->library['content'];
        $data->time = date('Y-m-d H:i:s',$time);
        unset($data['category']);
        unset($data['library']);
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

    public function getArticlesTwo($res){
        $number = 8;
        if(isset($res['count'])){
            $number = $res['count'];
        }
        $temp1 = \app\common\model\Category::where('id',$res['category_id_1'])->select();
        $dataTemp1 = ArticleModel::where('category_id',$res['category_id_1'])->order('update_time desc')
            ->where('check_status',1)
            ->field('id,name,cover,update_time,desc')->paginate($number);
        $dataTemp2['channelId'] = $temp1[0]['id'];
        $dataTemp2['name'] = $temp1[0]['name'];
        $dataTemp2['items'] = $dataTemp1;


        $temp2 = \app\common\model\Category::where('id',$res['category_id_2'])->select();
        $dataTemp3 = ArticleModel::where('category_id',$res['category_id_2'])->order('update_time desc')
            ->where('check_status',1)
            ->field('id,name,cover,update_time,desc')->paginate($number);
        $dataTemp4['channelId'] = $temp2[0]['id'];
        $dataTemp4['name'] = $temp2[0]['name'];
        $dataTemp4['items'] = $dataTemp3;
        $data = ['left'=>$dataTemp2,'right'=>$dataTemp4];
        return $data;
    }

    /**
     * 部门分数统计
     */
    public function countScore(){
        $department = Department::where('id','neq',1)->field('id,department_name,score')
            ->order('score desc')->select();
        return $department;
    }

}