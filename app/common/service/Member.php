<?php

namespace app\common\service;

use app\common\model\Member as MemberModel;

class Member extends MemberModel
{
    /**
     * 注册一个新用户
     * @param  array $data 用户注册信息
     * @return integer|bool  注册成功返回主键，注册失败-返回false
     */
    public function register($data = [])
    {
        $result = $this->allowField(true)->save($data);
        if ($result) {
            return $this->getData('id');
        } else {
            return false;
        }
    }

    /**
     * 用户登录认证
     * @param  string  $username 用户名
     * @param  string  $password 用户密码
     * @return integer 登录成功-用户ID，登录失败-返回0或-1
     */
    public function login($username, $password)
    {
        $where['username'] = $username;
        $where['status']   = 1;
        /* 获取用户数据 */
        $user = $this->where($where)->find();
        if($user && $user['status']){
            /* 验证用户密码 */
            if(krcmf_md5($password, UC_AUTH_KEY) === $user['password']){
                $this->updateLogin($user); //更新用户登录信息
                return $user['id']; //登录成功，返回用户ID
            } else {
                return -2; //密码错误
            }
        } else {
            return -1; //用户不存在或被禁用
        }
    }
    /**
     * 更新用户登录信息
     * @param  array $user
     */
    protected function updateLogin($user){
        $data = array(
            'last_login_time' => time(),
            'last_login_ip'   => get_client_ip(1),
        );
        $this->where(array('id'=>$user['id']))->update($data);
        /* 记录登录SESSION和COOKIES */
        $auth = array(
            "uid"             => $user["id"],
            "username"        => $user["realname"],
            "last_login_time" => $user["last_login_time"],
        );

        session('user_auth', $auth);
        session('user_auth_sign', data_auth_sign($auth));
    }
    /**
     * 注销当前用户
     * @return void
     */
    public function logout(){
        session('user_auth', null);
        session('user_auth_sign', null);
    }

    /**
     * 获取指定用户信息
     * @param  integer  $uid 用户主键
     * @return array|integer 成功返回数组，失败-返回-1
     */
    public function getMemberInfo($id)
    {
        // 获取密码字段之外的指定用户信息
        $user = $this->where('id', $id)->field('password',true)->find();
        if ($user) {
            // 返回用户数据
            return $user->toArray();
        } else {
            $this->error = '用户不存在';
            return -1;
        }
    }
    /**
     * 删除指定用户
     * @param  integer  $uid 用户主键
     * @return array|integer 成功返回数组，失败-返回-1
     */
    public function delMember($id)
    {
        if($id == config('USER_ADMINISTRATOR'))
        {
            $this->error = '超级管理员不能删除';
            return false;

        } else {
            if (MemberModel::destroy($id)) {
                return true;
            } else {
                $this->error = '用户不存在';
                return false;
            }
        }

    }
    /**
     * 获取所有用户信息
     * @return model 成功返回用户模型，失败-返回-1
     */
    public function getMembers()
    {
        // 获取密码字段之外的所有用户信息
        $members = $this->field('password',true)->paginate();
        if ($members) {
            // 返回用户数据
            return $members;
        } else {
            $this->error = '用户不存在或被禁用';
            return -1;
        }
    }
    /**
     * 获取用户角色
     * @return integer 返回角色信息或者返回-1
     */
    public function role()
    {
        $uid = $this->getData('id');
        if ($uid) {
            $role = $this->getUserRole($uid);
            if ($role) {
                return $role;
            } else {
                $this->error = '用户未授权';
                return 0;
            }
        } else {
            $this->error = '请先登录';
            return -1;
        }
    }

    protected function getUserRole($uid)
    {
        return $this->table('role')->where('uid', $uid)->find();
    }



    public function group()
    {
        return $this->belongsToMany('role','kfrcmf_auth_group','role_id','id')->field('id as rid,title,describe');
    }

    /**
     * 保存用户信息
     * @param array $data
     */
    public function saveInfo($data)
    {
        // 过滤post数组中的非数据表字段数据
        $member = $this->allowField(true)->create($data);
        if($member){
            return true;
        }else{
            $this->error = "添加失败";;
            return false;
        }
    }
    /**
     * 更新用户信息
     * @param array $data
     */
    public function updateInfo($data)
    {
        $result = $this->where("id", $data['id'])->field('password',true)->update($data);
        if($result) {
            return true;
        } else {
            $this->error = '更新失败';
            return false;
        }
    }

    /**
     * 更新用户状态
     *
     * @param  array $data
     * @return \think\Response
     */
    public function updateStatus($data)
    {
        if($data['id'] == 1)
        {
            $this->error = '超级管理员不能停用';
            return false;
        } else {
            if($this->update($data)){
                return true;
            }else{
                $this->error = '状态变更失败';
                return false;
            }
        }

    }
    /**
     * 更新用户密码
     *
     * @param  array $data
     * @return \think\Response
     */
    public function updatePassword($data)
    {
        $member = $this::get(UID);
        /* 验证用户密码 */
        if(krcmf_md5($data["password"], UC_AUTH_KEY) === $member['password'])
        {//更新用户密码
            $member->password = $data["newpassword"];
            if($member->save()){
                return true;
            }else{
                $this->error = "更新失败，不能和原密码相同";
                return false;
            }
        }else{
            $this->error = "更新失败，原密码错误";
            return false;
        }
    }
}