<?php

namespace app\common\model;

use think\Model;

class Menu extends Model
{
    // 设置自动完成的属性
    protected $insert = ['status' => 1];

    // 设置返回数据集的对象名
    //protected $resultSetTyp = "collection";

    protected function getStatusAttr($status)
    {
        $statustype = [0 => '禁用', 1 => '启用', 2 => '待审核'];
        return $statustype[$status];
    }

    /**
     * 获取所有菜单对应的权限。
     */
    public function authRule()
    {
        return $this->hasOne('Role', 'url', 'url');
    }

}