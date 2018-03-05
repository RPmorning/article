<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/3/5-0005
 * Time: 13:33
 */
namespace app\api\controller;

use think\Controller;
use app\common\service\Link as LinkService;
use think\Request;

class Link extends Controller
{
    protected $link;
    public function __construct(LinkService $link)
    {
        parent::__construct();
        $this->link = $link;
    }

    public function getLinks(Request $request){
        $res = $request->param();
        $data = $this->link->getLink($res);
        if($data){
            var_json('200','',$data);
        }else{
            var_json('404','无该类型链接');
        }
    }
}