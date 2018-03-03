<?php
/**
 * Created by PhpStorm.
 * User: renpeng
 * Date: 2018/3/3-0003
 * Time: 11:32
 */

namespace app\common\service;

use app\common\model\ArticleSign as ArticleSignModel;

class ArticleSign extends ArticleSignModel
{

    public function getArticleSign(){

    }

    public function saveArticleSign($res){
        $where['username'] = $res['username'];
        $where['status']   = 1;
        /* 获取用户数据 */
        $user = \app\common\model\Member::where($where)->find();
        if($user && $user['status']){
            /* 验证用户密码 */
            if(krcmf_md5($res['password'],  UC_AUTH_KEY) === $user['password']){
                $articleSign = new ArticleSignModel([
                    'department_id'  =>  $user->department_id,
                    'article_id' =>  $res['article_id'],
                    'sign_time' =>  time()
                ]);
                $articleSign->save();
                return 1;
            } else {
                return var_json('500','密码错误');
            }
        } else {
            return var_json('500','无该用户');
        }
    }

}