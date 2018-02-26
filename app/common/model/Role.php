<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/2/7-0007
 * Time: 12:00
 */
namespace app\common\model;

use think\Model;

class Role extends Model
{
    //操作权限
    public function operation()
    {
        return  $this->hasOne("Operation",'id','operation_id')->field("*");
    }

}