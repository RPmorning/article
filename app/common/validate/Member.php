<?php
 
namespace app\common\validate;
use think\Validate;
/**
*  UC验证模型
*/
class Member extends Validate{
    // 验证规则
    protected $rule = [
        ['username', 'require|unique:Member|length:4,30', '用户名必须|用户已存在|用户名长度4-30'],
        ['mobile_phone', 'number|unique:Member', '手机号格式错误|手机号已存在'],
        ['password', 'require|length:4,30', '密码必须|密码长度4-30'],
        ['newpassword','require|length:4,30','密码必须|密码长度4-30'],
        ['repassword','require|length:4,30|confirm:newpassword','密码必须|密码长度4-30|两次密码不一致'],
    ]; 
    protected $scene = array(
        'create'     => 'username,password',//后台管理员注册场景
        'update' => 'username', //后台管理员更新场景
        'repassword' => 'password,newpassword,repassword' //修改密码场景
    );

}