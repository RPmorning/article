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

    public function getArticleSign($res){
        $departmrnts = \app\common\model\Article::where('id',$res['articleId'])->value('departments');
        $departmrnt = \app\common\model\Department::field('id,department_name')->where('id','in',$departmrnts)->select();
        $data = ArticleSignModel::where('article_id',$res['articleId'])->select();
        $count = count($data);
        foreach ($departmrnt as $key=>$value){
            $value['status'] = '未签收';
            $value['time'] = '';
            for($i=0; $i<$count; $i++){
                if($value['id'] == $data[$i]['department_id']){
                    $value['status'] = '已签收';
                    $value['time'] = $data[$i]['sign_time'];
                    break;
                }
            }
        }
        return $departmrnt;
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
                    'article_id' =>  $res['articleId'],
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