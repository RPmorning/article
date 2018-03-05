<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/3/3-0003
 * Time: 11:36
 */

namespace app\api\controller;

use think\Controller;
use app\common\service\ArticleSign as ArticleSignServices;
use think\Request;

class ArticleSign extends Controller
{
    protected $articleSign;
    public function __construct(ArticleSignServices $articleSign)
    {
        parent::__construct();
        $this->articleSign = $articleSign;
    }

    public function index(Request $request){
        $res = $request->param();
        $data = $this->articleSign->getArticleSign($res);
        var_json('200','',$data);
    }

    public function save(Request $request){
        $res = $request->param();
        $data = $this->articleSign->saveArticleSign($res);
        if($data == 1){
            return var_json('200','签收成功！');
        }
    }
}