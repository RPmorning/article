<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/3/3-0003
 * Time: 15:18
 */

/**
 * 操作错误跳转的快捷方法
 * @access protected
 * @param mixed $msg 提示信息
 * @param string $url 跳转的URL地址
 * @param mixed $data 返回的数据
 * @param integer $wait 跳转等待时间
 * @param array $header 发送的Header信息
 * @return void
 */
function var_json($code = 10000, $msg = '', $data = array())
{
    $out['status'] = $code ?: 0;
    $out['info'] = $msg;
    $out['data'] = $data ?: array();
    header('Content-Type: application/json; charset=utf-8');
    header('Access-Control-Allow-Origin:*');
    header('Access-Control-Max-Age:10000000'); //生存周期长一点可以减少options请求
    header('Access-Control-Allow-Headers:token,x-requested-with,content-type,x-pingother,origin, accept');
    header("Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE");
    echo json_encode($out, JSON_HEX_TAG);
    exit(0);
}