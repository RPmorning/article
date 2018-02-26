<?php

namespace app\common\service;

use think\Model;

class Config extends Model
{
    /**
     * 获取网站配置
     * @return array 成功返回网站参数配置，失败-返回-false
     */
    public static function getSiteOption()
    {
        // 获取所有配置信息
        $map = [
            "option_name" => "site_options"
        ];
        $config = self::get($map);
        if ($config) {
            return object_array(json_decode($config->option_value));
        } else {
            return false;
        }
    }


    /**
     * 保存登录图片，不含数据库保存
     * @return array 成功返回网站参数配置，失败-返回-false
     */
    public function saveSiteLoginBg($file)
    {
        if(empty($file)) {
            $this->error = '请选择上传文件';
            return false;
        }
        static $upload = null;
        if (!$upload) {
            $upload = new \sckr\Upload();
        }
        $info = $upload->uploadFile($file, "image");
        if($info){
            return $info;
        }else{
            $this->error = $upload->getError();
            return false;
        }
    }



    /**
     * 保存配置信息
     * @param array $data
     * @return bool|验证出错信息
     */
    public function updateSiteOption($data)
    {
        $result = $this->update(['option_value'  => json_encode($data)],['option_name'=>'site_options']);
        if($result) {
            return true;
        }else{
            $this->error = "更新失败";
            return false;
        }
    }
}