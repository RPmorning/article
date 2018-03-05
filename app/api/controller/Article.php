<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/3/5-0005
 * Time: 8:48
 */
namespace app\api\controller;

use think\Controller;
use think\Request;
use app\common\service\Article as ArticleService;

class Article extends Controller
{
    protected $article;
    public function __construct(ArticleService $article)
    {
        parent::__construct();
        $this->article = $article;
    }

    /**
     * @param Request $request
     * 根据栏目id返回文章列表
     * category_id 栏目id
     * count 每页条数
     */
    public function getArticleByTypeList(Request $request){
        $res = $request->param();
        $articleList = $this->article->getArticleByTypeList($res);
        var_json(200, '', $articleList);
    }

    /**
     * @param Request $request
     * keyword 搜索关键字
     * count 每页条数
     */
    public function getArticleByKeyword(Request $request){
        $res = $request->param();
        $articleList = $this->article->getArticleByKeyword($res);
        var_json(200, '', $articleList);
    }

    /**
     * @param Request $request
     * 查看文章详情
     * id  文章id
     */
    public function getArticleById(Request $request){
        $res = $request->param();
        $articleList = $this->article->getArticleByArticleId($res);
        var_json(200, '', $articleList);
    }

    public function saveView(Request $request){
        $res = $request->param();
        $articleList = $this->article->saveView($res);
        var_json('200','浏览次数增加');
    }

}