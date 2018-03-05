<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/2/27-0027
 * Time: 10:05
 */
namespace app\api\controller;

use think\Controller;
use app\common\service\Category as CategoryService;

class Category extends Controller
{
    protected $category;
    public function __construct(CategoryService $category)
    {
        parent::__construct();
        $this->category = $category;
    }

    public function getCategorys(){
        $data = $this->category->getCategorysForIndex();
        var_json('200','',$data);
    }
}
