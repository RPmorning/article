<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/2/12-0012
 * Time: 10:41
 */

namespace app\common\model;

use think\Model;

class Operation extends Model
{
    public function role()
    {
        return  $this->belongsTo("Role",'operation_id','id')->field("*");
    }
}