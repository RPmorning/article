<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/2/9-0009
 * Time: 11:58
 */
namespace app\common\service;

use app\common\model\Department as DepartmentModel;

class Department extends DepartmentModel
{

    public function getDepartment(){
        $department = DepartmentModel::field('id,department_name')->where('level',2)
            ->where('status',1)->select();
        if($department){
            return $department;
        }else{
            $this->error = '部门不存在或被禁用';
            return false;
        }
    }

    //获取所有部门信息
    public function getDepartments(){
        $department = DepartmentModel::paginate();
        if($department){
            return $department;
        }else{
            $this->error = '部门不存在或被禁用';
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

    //获取父级部门名称
//    public function getPDepartment($id){
//
//    }

    public function createDepartment($res){
        if(isset($res['roles'])){
            unset($res['roles']);
        }
        $level = DepartmentModel::where('id',$res['pid'])->value('level');
        $res['level'] = $level+1;

        $data = DepartmentModel::create($res);
        if($data){
            return 1;
        }else{
            return 0;
        }
    }

    public function getThisDepartment($id){
        $department = DepartmentModel::get($id);
        if($department){
            return $department;
        }else{
            return false;
        }
    }

    public function updateDepartment($res){
        if(isset($res['roles'])){
            unset($res['roles']);
        }
        $data = DepartmentModel::update($res);
        if($data){
            return 1;
        }else{
            return 0;
        }
    }

    public function deleteCategory($id){
        $department = $this::get(["pid" => $id]);
        if($department) {
            $this->error = "删除失败，当前栏目拥有子栏目";
            return false;
        }
        $department = $this::get($id);
        if($department){
            try {
                $department->delete();
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
}