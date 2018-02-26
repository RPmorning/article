<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: sckr <keywaysoft.com>
// +----------------------------------------------------------------------
// | 修改者: roam (本权限类在原3.2.3的基础上修改过来的)
// +----------------------------------------------------------------------

namespace sckr;

use think\Config;
use app\common\model\Asset as AssetModel;
use think\Request;

class Upload
{
    /**
     * @var object 对象实例
     */
    protected static $instance;
    /**
     * 当前请求实例
     * @var Request
     */
    protected $request;

    //默认配置
    protected $config = [
        "size"         => 521000, // 上传文件最大字节大小 integer
        "image_ext"   => "jpg,png,gif", // 允许图片上传的文件后缀 字符串
        "video_ext"   => "mp4,avi,3gp,rmvb", // 允许图片上传的文件后缀 字符串
        "type"         => "image", // 允许上传的文件类型 字符串
        "path"         => ROOT_PATH .'public'. DS .'upload'
    ];

    /**
     * @var mixed 文件对象或数组
     */
    protected $file;

    /**
     * @var string 文件类型
     */
    protected $type;

    /**
     * @var string 错误信息
     */
    protected $error;

    /**
     * 类架构函数
     * Upload constructor.
     *
     */
    public function __construct()
    {
        $configPath = Config::get('upload')["path"];
        //可设置配置项 upload, 此配置项为数组。
        if ($configPath) {
            $upload["path"] = ROOT_PATH . 'public/' . $configPath;
            $this->config = array_merge($this->config, $upload);
        }
        // 初始化request
        $this->request = Request::instance();
    }

    /**
     * 获取错误信息
     * @param $files 文件对象
     * @return mixed
     *
     */
    public function  getError()
    {
        return $this->error;
    }

    /**
     * 初始化
     * @access public
     * @param array $options 参数
     * @return \think\Request
     */
    public static function instance($options = [])
    {
        if (is_null(self::$instance)) {
            self::$instance = new static($options);
        }
        return self::$instance;
    }


    /**
     * 单文件上传
     *
     * @param $file 文件对象
     * @param $type 文件类型
     * @return mixed
     *
     */
    public function uploadFile($file, $type)
    {
        if(empty($file) || empty($type)){
            $this->error = "请先设置文件类型";
            return false;
        }
        $this->file = $file;
        $this->type = $type;

        // 验证文件类型
        $result = $this->fileType();
        if(true != $result) {
            $this->error = $result;
            return false;
        }

        if(is_array($this->file)){ // 多文件上传
            $item = [];
            $flag = true;
            foreach ($this->file as $f) {
                $info =  $f->move($this->config["path"]);
                if($info){
                    $item[] = $info->getSaveName();
                }else{
                    $flag = false;
                }
            }
            return $flag ? $item : $flag;
        }else{ // 单文件上传
            // 移动到框架应用根目录/public/uploads/ 目录下
            $info =  $this->file->move($this->config["path"]);
            if($info){
                $fileInfo = $this->saveAsset($file, $info); // 保存资源文件
                $path = $info->getSaveName();
                if($type == "file"){
                    return array("path" =>  $fileInfo["file_path"],  "id" => $fileInfo["id"], "name" => $fileInfo["filename"]);
                }else{
                    return $path;
                }
            }else{
                $this->error = "上传文件失败";
                return false;
            }
        }

    }

    public function saveAsset($file, $info)
    {
        $arrInfo = [];
        if (empty($file)) {
            $this->error = $file->getError();
            return false;
        } else {
            $arrInfo["user_id"]     = UID;
            $arrInfo["file_size"]   = $file->getSize();
            $arrInfo["create_time"] = time();
            $arrInfo["file_md5"]    =  $file->md5();
            $arrInfo["file_sha1"]   = $file->sha1();
            $arrInfo["file_key"]    = $arrInfo["file_md5"] . md5($arrInfo["file_sha1"]);
            $arrInfo["filename"]    = $file->getInfo()['name'];
            $arrInfo["file_path"]   = $info->getSaveName();
            $arrInfo["suffix"]      = $info->getExtension();
        }

        //检查文件是否已经存在
        $assetModel = new AssetModel();
        $objAsset   = $assetModel->where(["user_id" => UID, "file_key" => $arrInfo["file_key"]])->find();
        if ($objAsset) {
            $arrAsset = $objAsset->toArray();
            //$arrInfo["url"] = $this->request->domain() . $arrAsset["file_path"];
            $arrInfo["file_path"] = $arrAsset["file_path"];
            $assetId = $arrAsset["id"];
            @unlink(ROOT_PATH .'/public/upload/' . $file->getSaveName()); // 删除已经上传的文件
        } else {
            $assetModel->data($arrInfo)->allowField(true)->save();
            $assetId = $assetModel->id;
        }
        $arrInfo["id"] = $assetId;
        return $arrInfo;
    }

    /**
     * 验证文件类型
     *
     * @param $type 文件类型
     * @return mixed
     *
     */
    protected function fileType()
    {
        if($this->type == "image"){ // 图片上传
            $rule = [
                "fileExt" => "in:".$this->config["image_ext"],
                "fileSize" => $this->config["size"]
            ];
            $msg = [
                //"file.require" => "请选择上传文件",
                "fileExt" => "非法图像文件",
                "fileSize" => "图片超出服务器的大小限制",
            ];
            $result = $this->file->validate(['file' => $this->file], $rule, $msg);
        }elseif($this->type == "video"){ // 视频上传
            $rule = [
                "fileExt" => "in:".$this->config["video_ext"],
                "fileSize" => $this->config["size"]
            ];
            $msg = [
                //"file.require" => "请选择上传文件",
                "fileExt" => "非法视频文件",
                "fileSize" => "视频超出服务器的大小限制",
            ];
            $result = true;
        }elseif($this->type == "file"){
            $result = true;
        }else{
            $result = false;
        }
        return $result;
    }
}
