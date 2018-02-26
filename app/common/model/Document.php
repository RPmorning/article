<?php

namespace app\common\model;

use think\Model;

class Document extends Model
{
    // 开启自动写入时间戳字段 可以在数据库配置文件中添加全局设置
    protected $autoWriteTimestamp = true;

    // 向模型追加属性
    //protected $append  = ['member_name'];

    // 设置自动完成的属性
    protected $insert = ['status' => 1];

    protected function getUpdateTimeAttr($update_time)
    {
        return date('Y-m-d H:i:s', $update_time);
    }

    //定义关联
    public function member()
    {
        return  $this->belongsTo("Member")->field("id, username");
    }
    public function category()
    {
        return  $this->hasOne("Category",'id','category_id')->field("*");
    }

}