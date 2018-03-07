<?php

namespace app\common\model;

use think\Model;

class Article extends Model
{
    // 开启自动写入时间戳字段 可以在数据库配置文件中添加全局设置
    protected $autoWriteTimestamp = true;

    // 向模型追加属性
    //protected $append  = ['member_name'];

    // 设置自动完成的属性
    protected $insert = ['status' => 1];

    protected function getUpdateTimeAttr($update_time){
        /*$dateYM = date('Y-m',$update_time);
        $dateD= date('d',$update_time);
        return $dateYM.$dateD;*/
        return date('Y-m-d',$update_time);
    }

//    protected function getCoverAttr($cover){
//        //return 'http://192.168.13.72/upload/'.$cover;
//        $request = request();
//        return $request->domain().'/upload/'.$cover;
//    }


    //定义关联
    public function member()
    {
        return  $this->belongsTo("Member")->field("id, username");
    }

    public function category()
    {
        return  $this->belongsTo("Category",'category_id','id')->field("*");
    }
}