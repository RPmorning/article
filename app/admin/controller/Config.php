<?php

namespace app\admin\controller;

use app\common\service\Config AS ConfigService;

class Config extends Base
{
    protected $config;

    public function __construct(ConfigService $config)
    {
        parent::__construct();
        $this->config = $config;
    }
    /**
     * 显示资源列表
     *
     * @return html
     */
    /*展示网站设置页面*/
    public function index()
    {
        $this->pageTitle = "网站配置";
        $this->assign("pageTitle",$this->pageTitle);
        return $this->fetch();
    }

    /*网站登录界面图片修改*/
    public function uploadSiteLoginBg()
    {
        $file = $this->request->file("site_login_bg");
        $path = $this->config->saveSiteLoginBg($file);
        if($path){
            $data = ['msg' => '上传成功', 'path' => $path, 'code' => '1'];
        }else{
            $data = ['msg' => $this->config->getError(), 'code' => '0'];
        }
        // 兼容IE浏览器
        return json($data)->contentType("text/plain");
    }


    /**
     * 保存更新的网站配置
     *
     * @param  \think\Request  $request
     * @param  int  $id
     * @return \think\Response
     */
    public function update()
    {
        $data = $this->request->post();
        try{
            $res = $this->config->updateSiteOption($data);
            if($res) {
                return $this->success("保存成功", url("index"));
            }else{
                return $this->error($this->config->getError());
            }
        }catch (Exception $e){
            return $this->error($e->getMessage());
        }
    }

    /**
     * 显示短信配置
     *
     * @return \think\Response
     */
    public function sms()
    {
        $mail_options = Db::name('config')->where('option_name','sms_options')->select();
        $so= json_decode($mail_options[0]['option_value']);
        $so = object_array($so);
        $this->pageTitle = "短信配置";
        $this->assign('pageTitle',$this->pageTitle);
        $this->assign('smsOptions',$so);
        return $this->fetch();
    }

    /**
     * 保存短信配置
     *
     * @return \think\Response
     */
    public function updateSms()
    {

        $res = $this->request->post();
        $cf = Model('config');
        $cf->save(['option_value'  => json_encode($res)],['option_name'=>'sms_options']);
        $result["success"] = true;
        $result["msg"] = lang("保存成功");
        return json($result, 201);
    }

    /**
     * 显示邮箱配置
     *
     * @return \think\Response
     */
    public function mail()
    {
        $mail_options = Db::name('config')->where('option_name','mail_options')->select();
        $mo= json_decode($mail_options[0]['option_value']);
        $mo = object_array($mo);
        $this->pageTitle = "邮箱配置";
        $this->assign('pageTitle',$this->pageTitle);
        $this->assign('mailOptions',$mo);
        return $this->fetch();
    }

    /**
     * 保存邮箱配置
     *
     * @return \think\Response
     */
    public function updateMail(){

        $res = $this->request->post();
        $cf = Model('config');
        $cf->save(['option_value'  => json_encode($res)],['option_name'=>'mail_options']);
        $result["success"] = true;
        $result["msg"] = "保存成功";
        return json($result, 201);
    }

    /**
     * 显示文件存储配置
     *
     * @return \think\Response
     */
    public function file()
    {
        $this->pageTitle = "文件存储";
        $this->assign('pageTitle',$this->pageTitle);
        return $this->fetch();
    }

    /**
     * 保存文件存储配置
     *
     * @return \think\Response
     */
    public function updateFile()
    {
        $res = $this->request->post();
        $cf = Model('config');
        $cf->save(['option_value'  => json_encode($res)],['option_name'=>'file_options']);
        $result["success"] = true;
        $result["msg"] = "保存成功";
        return json($result, 201);
    }
}
