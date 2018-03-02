<?php
/**
 * Created by PhpStorm.
 * User: hujj
 * Date: 2017/2/23
 * Time: 9:23
 */
namespace app\admin\controller;

use app\common\service\Config;
use think\Cache;
use think\Db;

class Index extends Base
{
    /**
     * 后台首页
     * @author wapai   邮箱:wapai@foxmail.com
     */
    public function index()
    {
        $this->assign('page_title','绵阳公安信息网') ;
        $this->assign('system', config('system'));
        $mysql = Db::query('SELECT VERSION() as mysql_version');
        $mysql_ver = $mysql[0]['mysql_version'];//MYSQL版本号

        /*$res = array(
            '当前主机名' => $_SERVER['SERVER_NAME'], //当前主机名
            '操作系统' => php_uname(), //获取系统类型及版本号
            '服务器域名'=>$_SERVER['SERVER_NAME'].' [ '.gethostbyname($_SERVER['SERVER_NAME']).' ]',//服务器域名IP
            '服务器语言' => $_SERVER['HTTP_ACCEPT_LANGUAGE'], //获取服务器语言
            '服务器时间' => date("Y-m-d H:i:s", time()), //获取服务器时间
            'Apache版本' => $_SERVER["SERVER_SOFTWARE"], //运行环境
            'PHP版本' => PHP_VERSION, //获取PHP服务器版本
            'Mysql版本'=>$mysql[0]['mysql_version'],//MYSQL版本号
            'ThinkPhp版本'=>THINK_VERSION, //TP版本号
            'PHP运行方式' => php_sapi_name(),//php运行方式
            '剩余空间'=>round((disk_free_space(".")/(1024*1024*1024)),2).'G',//获取剩余空间
            '上传附件限制' => ini_get("file_uploads") ? ini_get("upload_max_filesize") : "Disabled", //最大上传
            '执行时间限制' => ini_get("max_execution_time") . "秒", //脚本最大执行时间
        );*/
        $this->assign('mysql_ver', $mysql_ver);
        $this->pageTitle = "后台首页";
        $this->assign('pageTitle',$this->pageTitle);
        return $this->fetch();
    }

//    public function console(){
//        $this->assign('page_title', '绵阳公安信息网');
//        return $this->fetch();
//    }



    /* 清除缓存 */
    public function clearCache()
    {
        /* $path  = ROOT_PATH . '/runtime';
       print_r($path);
       $files = get_files($path);
       if (!is_array($files)) {
           $msg = $files;
       } elseif (empty($files)) {
           $msg = '删除失败,目录下没有文件或目录';
       } else {
           foreach ($files as $item => $file) {
               if (is_dir($file)) {
                   rmdir($file);
               } elseif (is_file($file)) {
                   unlink($file);
               }
           }
           Cache::clear();
           $msg = '删除成功';
           return $this->success($msg, url('index'));
       }*/
        if(Cache::clear()){
            return $this->success("缓存清除成功");
        }else{
            return $this->success("缓存清除失败");
        }
        return json($data);
    }

}