<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------
define('KRCMF_VERSION','1.0' );
define('UC_AUTH_KEY', 'E@~;vbSJh!i4>-`VIF3X$Hmn^)w_"=1gej.uO*[?'); //加密KEY
use think\db;
/**
 * 检测用户是否登录
 * @return integer 0-未登录，大于0-当前登录用户ID
 */
function is_login(){
    $user = session('user_auth');
    if (empty($user)) {
        return 0;
    } else {
        return session('user_auth_sign') == data_auth_sign($user) ? $user['uid'] : 0;
    }
}

/**
 * 系统非常规MD5加密方法
 * @param  string $str 要加密的字符串
 * @return string
 */
function krcmf_md5($str, $key = 'krcmf'){
    return '' === $str ? '' : md5(sha1($str) . $key);
}

/**
 * 检测当前用户是否为管理员
 * @return boolean true-管理员，false-非管理员
 */
function is_administrator($uid = null){
    $uid = is_null($uid) ? is_login() : $uid;
    return $uid && (intval($uid) === config('USER_ADMINISTRATOR'));
}

/**
 * 获取客户端IP地址
 * @param integer $type 返回类型 0 返回IP地址 1 返回IPV4地址数字
 * @param boolean $adv 是否进行高级模式获取（有可能被伪装）
 */
function get_client_ip($type = 0, $adv = false) {
    $type      = $type ? 1 : 0;
    static $ip = NULL;
    if ($ip !== NULL) {
        return $ip[$type];
    }

    if ($adv) {
        if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $arr = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
            $pos = array_search('unknown', $arr);
            if (false !== $pos) {
                unset($arr[$pos]);
            }

            $ip = trim($arr[0]);
        } elseif (isset($_SERVER['HTTP_CLIENT_IP'])) {
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        } elseif (isset($_SERVER['REMOTE_ADDR'])) {
            $ip = $_SERVER['REMOTE_ADDR'];
        }
    } elseif (isset($_SERVER['REMOTE_ADDR'])) {
        $ip = $_SERVER['REMOTE_ADDR'];
    }
    // IP地址合法验证
    $long = sprintf("%u", ip2long($ip));
    $ip   = $long ? array($ip, $long) : array('0.0.0.0', 0);
    return $ip[$type];
}

/**
 * 数据签名认证
 * @param  array  $data 被认证的数据
 * @return string       签名
 */
function data_auth_sign($data) {
    //数据类型检测
    if(!is_array($data)){
        $data = (array)$data;
    }
    ksort($data); //排序
    $code = http_build_query($data); //url编码并生成query字符串
    $sign = sha1($code); //生成签名
    return $sign;
}


/**
 * 系统解密方法
 * @param  string $data 要解密的字符串 （必须是think_encrypt方法加密的字符串）
 * @param  string $key  加密密钥
 * @return string
 * @author wapai
 */
function krcmf_decrypt($data, $key = ''){
    $key    = md5(empty($key) ? config('data_auth_key') : $key);
    $data   = str_replace(array('-','_'),array('+','/'),$data);
    $mod4   = strlen($data) % 4;
    if ($mod4) {
        $data .= substr('====', $mod4);
    }
    $data   = base64_decode($data);
    $expire = substr($data,0,10);
    $data   = substr($data,10);

    if($expire > 0 && $expire < time()) {
        return '';
    }
    $x      = 0;
    $len    = strlen($data);
    $l      = strlen($key);
    $char   = $str = '';

    for ($i = 0; $i < $len; $i++) {
        if ($x == $l) $x = 0;
        $char .= substr($key, $x, 1);
        $x++;
    }

    for ($i = 0; $i < $len; $i++) {
        if (ord(substr($data, $i, 1))<ord(substr($char, $i, 1))) {
            $str .= chr((ord(substr($data, $i, 1)) + 256) - ord(substr($char, $i, 1)));
        }else{
            $str .= chr(ord(substr($data, $i, 1)) - ord(substr($char, $i, 1)));
        }
    }
    return base64_decode($str);
}

/**
 * 数据集生成数据树
 * @param array $list 要转换的数据集
 * @param string $id ID Key
 * @param string $pid 父ID Key
 * @param string $child 定义子数据Key
 * @return array
 */
function list_to_tree($list, $id = 'id', $pid = 'pid', $child = 'child') {
    $tree = $map = array();
    foreach ($list as $item) {
        $map[$item[$id]] = $item;
        if(isset($item['url'])){
            $item['url'] = strtolower($item['url']);

            if((MODULE_NAME.'/'.CONTROLLER_NAME.'/'.ACTION_NAME)  == $item['url']){
                $map[$item['id']]['class'] = 'layui-this';
            }
        }

    }
    foreach ($list as $item) {
        if (isset($item[$pid]) && isset($map[$item[$pid]])) {
            $map[$item[$pid]]['leaf'] = 1;
            $map[$item[$pid]][$child][] = &$map[$item[$id]];
        } else {
            $tree[] = &$map[$item[$id]];
        }
    }
    unset($map);
    return $tree;
}
/**
 * 返回提示信息
 * @param $status  代表是操作是否成功
 * @param  $type 代表操作类型
 *两个参数均为int类型
 */
function return_type($status,$type){
    $status == 1 ?($type==1?$result["msg"] = lang("save success"):$result["msg"] = lang("delete success")):
        ($type==1?$result["msg"] = lang("save failed"):$result["msg"] = lang("delete failed"));
    $result["success"] = true;
    return json($result, 201);
}
/**
 * 将list_to_tree的树还原成列表
 * @param  array $tree  原来的树
 * @param  string $child 孩子节点的键
 * @param  string $order 排序显示的键，一般是主键 升序排列
 * @param  array  $list  过渡用的中间数组，
 * @return array        返回排过序的列表数组
 * @author wapai   邮箱:wapai@foxmail.com
 */
function tree_to_list($tree, $child = 'child', $order='id', &$list = array()){
    if(is_array($tree)) {
        foreach ($tree as $key => $value) {
            $reffer = $value;
            if(isset($reffer[$child])){
                unset($reffer[$child]);
                tree_to_list($value[$child], $child, $order, $list);
            }
            $list[] = $reffer;
        }
        $list = list_sort_by($list, $order, $sortby='asc');
    }
    return $list;
}

/**
 * @param arrary $array 源树
 * 遍历获得树的深度
 */
function array_depth($tree) {
    $max_depth = 1;

    foreach ($tree as $value) {
        if (!empty($value['child'])) {
            $depth = array_depth($value['child']) + 1;

            if ($depth > $max_depth) {
                $max_depth = $depth;
            }
        }
    }
    return $max_depth;
}


/**
 * @param arrary $tree 源树
 * @param int $depth 树的深度
 * 遍历获得树的深度
 */
function tree_select($tree,$i=0)
{
    if(empty($tree)){
        return array();
    }
    foreach ($tree as $k=>$v){
        if(empty($v['child'])){
            $result[$i++] = $v;
        }
        else{
            $temp = $v;
            array_pop($temp);
            $result[$i++] = $temp;
            foreach( tree_select($v['child'],$i) as $key=>$val){
                $result[$i++] = $val;
            }
        }
    }
    return $result;
}

/**
 * @param $array json_decode转换来的数组
 * 不是标准的array转为标准数组
 */
function object_array($array)
{
    if(is_object($array))
    {
        $array = (array)$array;
    }
    if(is_array($array))
    {
        foreach($array as $key=>$value)
        {
            $array[$key] = object_array($value);
        }
    }
    return $array;
}

/**
 * @param $f int数字
 * 阿拉伯数字转为罗马数字
 */
function dec2roman($f)
{
    // Return false if either $f is not a real number,
    //$f is bigger than 3999 or $f is lower or equal to 0:
    if(!is_numeric($f) || $f > 3999 || $f <= 0) return false;
    // Define the roman figures:
    $roman = array(
        'M' => 1000,
        'D' => 500,
        'C' => 100,
        'L' => 50,
        'X' => 10,
        'V' => 5,
        'I' => 1
    );
    // Calculate the needed roman figures:
    foreach($roman as $k => $v)
        if(($amount[$k] = floor($f / $v)) > 0)
            $f -= $amount[$k] * $v;
    // Build the string:
    $return = '';
    foreach($amount as $k => $v)
    {
        $return .= $v <= 3 ? str_repeat($k, $v) : $k . $old_k;
        $old_k = $k;
    }
    // Replace some spacial cases and return the string:
    return str_replace(array('VIV','LXL','DCD'),array('IX','XC','CM'),$return);
}

// 应用公共文件

