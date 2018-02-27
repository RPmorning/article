<?php

namespace app\common\model;

use think\Model;

class Member extends Model
{
    // 开启自动写入时间戳字段 可以在数据库配置文件中添加全局设置
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = 'reg_time';

    // 设置自动完成的属性
    // 新增
    protected $insert = ['status'=>1, 'reg_ip', 'reg_time'];
    // 更新
    //protected $update = [];

    // 属性修改器
    protected function setPasswordAttr($value, $data)
    {
        if(isset($value) && !empty($value)){
            return krcmf_md5($value, UC_AUTH_KEY) ;
        }
    }
    protected function setGuidAttr($value, $data)
    {
        return guid();
    }
    protected function setRegIpAttr($value, $data)
    {
        return get_client_ip(1);
    }
    protected function setRegTimeAttr($value, $data)
    {
        return time();
    }

    // 读取器
    protected function getRegTimeAttr($RegTime)
    {
        return date('Y-m-d', $RegTime);
    }
    protected function getLastLoginIpAttr($LastLoginIp)
    {
        return $LastLoginIp ? long2ip($LastLoginIp) : '未登录过';
    }
    protected function getLastLoginTimeAttr($LastLoginTime)
    {
        return $LastLoginTime ? date('Y-m-d', $LastLoginTime) : '未登录过';
    }

    public function department()
    {
        return  $this->hasOne("Department",'id','department_id')->field("*");
    }

    public function role()
    {
        return  $this->hasOne("Role",'id','role_id')->field("*");
    }

    public function roles()
    {
        return  $this->hasOne("Role",'id','role_id')->field("*");
    }

}