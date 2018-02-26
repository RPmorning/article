<?php

namespace app\common\model;

use think\Model;

class Page extends Model
{
    // 设置当前模型对应的完整数据表名称
    //protected $table = 'krcmf_portal_category';

    // 开启自动写入时间戳字段 可以在数据库配置文件中添加全局设置
    protected $autoWriteTimestamp = true;


    //定义关联
    public function member()
    {
        return  $this->belongsTo("Member")->field("id, username");
    }
}