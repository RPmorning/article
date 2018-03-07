<?php

namespace app\common\service;

use app\common\model\Category as CategoryModel;

class Category extends CategoryModel
{
    /**
     * 获取栏目列表
     * @return tree
     */
    public function getCategorys()
    {
        // models未在service定义，所以预载入需要用父类
        $categorys = CategoryModel::all();
        $categorys = collection($categorys)->toArray();
        return tree_select(list_to_tree($categorys));

    }

    /**
     * 获取指定类型的栏目列表
     * @param int $type 栏目类型 0内部栏目|1单网页|2外部链接
     * @param int $mid 栏目模型  0文章模型|1作品模型|2文档模型|3电子期刊|4专题模型
     * @return tree
     */
    public function getCategorysByType($type = -1, $mid = -1)
    {
        $map["status"] = 1;
        $map["type"] = $type;
        $map["model_id"] = $mid;
        $categorys = CategoryModel::all($map);
        $categorys = collection($categorys)->toArray();
        return $categorys;
    }

    /**
     * 获取指定类型的栏目列表
     * @return tree
     */
    public function getCategorysByUser(){
        $uid = session('user_auth')['uid'];
        $user = \app\common\model\Member::where('id',$uid)->find();
        $categories = $user->role->operation->category;
        $category = CategoryModel::where('status',1)->where('id','in',$categories)->select();
        return $category;
    }

    /**
     * 获取指定栏目类型的文章
     *
     * @param integer $id
     * @return mixed
     */
    public function getArticleByCategoryType($type = -1)
    {
        $map["status"] = 1;
        if($type >= 0) $map["type"] = $type;
        $categorys = CategoryModel::field("id,name,pid,type,model_id")->where($map)->select();
        foreach ($categorys as $key => $category){
            $articles = $category->article()->where(["status"=>1])->order('id desc')->limit(11)->select();
            $works = $category->works()->where(["status"=>1])->order('id desc')->limit(4)->select();
            $topics = $category->topic()->where(["status"=>1])->order('id desc')->limit(6)->select();
            $librarys = $category->library()->where(["status"=>1])->order('id desc')->limit(3)->select();
            $categorys[$key]["articles"] = $articles;
            $categorys[$key]["works"] = $works;
            $categorys[$key]["topics"] = $topics;
            $categorys[$key]["librarys"] = $librarys;
        }
        return $categorys;
    }
    /**
     * 获取前台主菜单
     * @param int $type 栏目类型 0内部栏目|1单网页|2外部链接
     * @return tree
     */
    public static function getNav()
    {
        $map = [
            'status' => 1,
            'is_nav' => 1
        ];
        $categorys = CategoryModel::all($map);
        $categorys = collection($categorys)->toArray();
        return list_to_tree($categorys);
    }

    /**
     * 获取同模型菜单
     * @param int $mid 模型类型
     * @return tree
     */
    public static function getNavByModelId($mid)
    {
        $map = [
            'status' => 1,
            'model_id' => $mid
        ];
        $categorys = CategoryModel::all($map);
        $categorys = collection($categorys)->toArray();
        return list_to_tree($categorys);
    }

    /**
     * 保存栏目
     * @param array $data
     */
    public function saveCategory($data)
    {
        // 表单验证
        $data["level"] = $data["level"];
        try {
            if(isset($data["id"])) { // 更新
                $this::update($data);
            }else{ // 新增
                $this::create($data);
            }
            return true;
        } catch (\Exception $e) {
            $this->error = $e->getMessage();
            return false;
        }
    }

    /**
     * 获取指定栏目含文章
     *
     * @param integer $id
     * @return mixed
     */
    public function getCategoryById($id)
    {
        $category = $this::get($id, "article");
        //$category = $category->article()->paginate();
        if($category){
            return $category;
        }else{
            $this->error = "该栏目不存在";
            return false;
        }
    }

    /**
     * 删除指定栏目
     *
     * @param array $data
     * @return bool
     */
    public function deleteCategory($id)
    {
        $category = $this::get(["pid" => $id]);
        if($category) {
            $this->error = "删除失败，当前栏目拥有子栏目";
            return false;
        }
        $category = $this::get($id);
        if($category){
            try {
                $category->delete();
                return true;
            } catch (\Exception $e) {
                $this->error = $e->getMessage();
                return false;
            }
        }else{
            $this->error = "该栏目不存在";
            return false;
        }
    }

    /**
     * 排序栏目
     *
     * @param array $data
     * @return bool
     */
    public function updataCategorySort($data)
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
     * 更新指定资源菜单
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function updateNav($id, $nav)
    {
        $res = $this->where('id', $id)->update(['is_nav' => $nav]);
        if($res){
            return true;
        }else{
            $this->error = "更新失败";
            return false;
        }
    }

    public function getCategorysForRole(){
        $category = CategoryModel::field('id,name')->where('type',0)->select();
        if($category){
            return $category;
        }else{
            return false;
        }
    }

    public function getCategorysForDocument(){
        $id = session('user_auth')['uid'];

        if($id == config('USER_ADMINISTRATOR')){
            $category = CategoryModel::field('id,name')->select();
        }else{
            $role = \app\common\model\Member::where('id',$id)->value('role_id');
            $categorys = \app\common\model\Role::where('id',$role)->value('rules');
            $category = CategoryModel::field('id,name')->where('id','in',$categorys)->select();
        }
        if($category){
            return $category;
        }else{
            return false;
        }
    }

    public function getCategorysForIndex(){
        $data = CategoryModel::field('id,name,type,model_id')->select();
        return $data;
    }
}