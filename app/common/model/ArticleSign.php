<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/3/3-0003
 * Time: 10:04
 */
namespace app\common\model;

use think\Model;

class ArticleSign extends Model
{
    protected function getSignTimeAttr($sign_time){
        return date('Y-m-d H:i:s',$sign_time);
    }
}