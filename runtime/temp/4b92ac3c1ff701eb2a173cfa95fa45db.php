<?php if (!defined('THINK_PATH')) exit(); /*a:6:{s:71:"D:\phpStudy\WWW\keywaysoft\public/../app/admin\view\category\index.html";i:1519605721;s:68:"D:\phpStudy\WWW\keywaysoft\public/../app/admin\view\public\base.html";i:1517982207;s:70:"D:\phpStudy\WWW\keywaysoft\public/../app/admin\view\public\header.html";i:1518139784;s:68:"D:\phpStudy\WWW\keywaysoft\public/../app/admin\view\public\menu.html";i:1517983608;s:72:"D:\phpStudy\WWW\keywaysoft\public/../app/admin\view\category\create.html";i:1497859246;s:70:"D:\phpStudy\WWW\keywaysoft\public/../app/admin\view\public\footer.html";i:1497859246;}*/ ?>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title><?php echo $pageTitle; ?>|<?php echo $siteOption['site_name']; ?></title>
    <link rel="shortcut icon" href="/favicon.ico" />
    <?php $controller = strtolower(\think\Request::instance()->controller()); $action = strtolower(\think\Request::instance()->action()); ?>
    <link rel="stylesheet" type="text/css" href="__LIB__/layui/css/layui.css" /><link rel="stylesheet" type="text/css" href="__COMMON__/reset.css" /><link rel="stylesheet" type="text/css" href="__ADMIN__/common.css" />
    <link rel="stylesheet" href="__LIB__/iconfont/iconfont.css">
    
    <link href="__ADMIN__/<?php echo $controller; ?>.css" rel="stylesheet" type="text/css">
</head>
<body>
    <!-- Page Start -->
    <div id="kr-page">
        <?php if($controller == 'passport'): else: ?>
        <!-- Page Header Start -->
        <div id="kr-header" class="pf w clearfix">
    <a class="logo show f20 tc fl" href="<?php echo url('index'); ?>"><?php echo \think\Config::get('SITE_NAME'); ?></a>
    <div class="header-nav clearfix">
        <div class="nav-menu fl">
            <a class="layui-nav-item" href="<?php echo url('admin/index/index'); ?>" target="">
                站点首页
            </a>

        </div>
        <div class="nav-toolbar fr">
            <ul class="layui-nav">
                <li class="layui-nav-item">
                    <a href="javascript:;"><span style="color: #4CAF50;font-size: large">hello:</span><?php echo \think\Session::get('user_auth.username'); ?></a>
                    <dl class="layui-nav-child"> <!-- 二级菜单 -->
                        <dd><a href="javascript:common.updatePassword();">修改密码</a></dd>
                        <dd><a href="javascript:common.logout();">退出系统</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
</div>


        <!-- Page Header End  -->
        <!-- Page Body Start -->
        
        <div id="kr-body" class="clearfix">
            <!-- Page Aside Start -->
            <div id="kr-aside" class="pf">
                <!-- Aside Menu Start  -->
                <div class="aside-menu layui-bg-blue">
    <!--<div id="aside-sidebar" class="cursor tc"><i class="iconfont icon-sidebar"></i></div>-->
    <ul class="layui-nav layui-nav-tree" lay-filter="test">

        <?php if(is_array($menus) || $menus instanceof \think\Collection || $menus instanceof \think\Paginator): $i = 0; $__LIST__ = $menus;if( count($__LIST__)==0 ) : echo "no data" ;else: foreach($__LIST__ as $key=>$menu): $mod = ($i % 2 );++$i;?>
        <li class="layui-nav-item layui-nav-itemed">
            <?php if(isset($menu['child'])): ?>
            <a href="javascript:;"><?php echo $menu['name']; ?></a>
            <dl class="layui-nav-child">
                <?php if(is_array($menu['child']) || $menu['child'] instanceof \think\Collection || $menu['child'] instanceof \think\Paginator): $i = 0; $__LIST__ = $menu['child'];if( count($__LIST__)==0 ) : echo "no data" ;else: foreach($__LIST__ as $key=>$submenu): $mod = ($i % 2 );++$i;?>
                <dd class="<?php echo (isset($submenu['class']) && ($submenu['class'] !== '')?$submenu['class']:''); ?>"><a href="<?php echo url($submenu['url']); ?>"><i class="iconfont f16 mr5 <?php echo $submenu['icon']; ?>"></i><?php echo $submenu['name']; ?></a></dd>                    <?php endforeach; endif; else: echo "no data" ;endif; ?>
            </dl>
            <?php else: ?>
            <a href="<?php echo url($menu['url']); ?>"><i class="iconfont f16 mr5 <?php echo $submenu['icon']; ?>"></i><?php echo $menu['name']; ?></a>
            <?php endif; ?>
        </li>
        <?php endforeach; endif; else: echo "no data" ;endif; ?>

    </ul>
</div>

                <!-- Aside Menu End  -->
            </div>
            <!-- Page Aside End -->
            <!-- Page Main Start  -->
            <div id="kr-main" class="pr">
                <!-- Main Blockquote Start  -->
                <div id="kr-blockquote" class="clearfix">
                    <div class="blockquote-breadcrumb fl">
                        <span class="layui-breadcrumb">
                            <a class="line pl5"><cite>您当前操作</cite></a>
                            <a><cite><?php echo $pageTitle; ?></cite></a>
                        </span>
                    </div>
                    <div class="blockquote-menu fr">
                        
                    </div>
                </div>
                <!-- Main Blockquote End  -->
                <!-- Main container Start  -->
                <div id="kr-container" class="main-container clearfix" data-url="{__URL__}">
                    
                    
<article class="main-menu">
    <div class="layui-tab">
        <ul class="layui-tab-title">
            <li class="layui-this">栏目列表</li>
            <li>添加栏目</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <table class="layui-table"  id="category-table">
                    <thead>
                        <tr>
                            <!--<td>排序</td>-->
                            <td>ID</td>
                            <td>栏目名称</td>
                            <td>栏目类型</td>
                            <td>所属模型</td>
                            <td>主导航</td>
                            <td>操作</td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if(is_array($categorys) || $categorys instanceof \think\Collection || $categorys instanceof \think\Paginator): $i = 0; $__LIST__ = $categorys;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$category): $mod = ($i % 2 );++$i;?>
                        <tr data-tt-id="<?php echo $category['id']; ?>" class="category-tr"

                            <?php if($category['level'] == '1'): ?> data-hier="1"
                            <?php else: ?> data-tt-parent-id="<?php echo $category['pid']; ?>" class="hidden"
                            <?php endif; ?>
                        >
                            <!--<td><input type="text" class="layui-input menu-sort" value="<?php echo $category['sort']; ?>"></td>-->
                            <td><?php echo $category['id']; ?></td>
                            <td><?php echo $category['name']; ?></td>
                            <td><?php echo $category['type_text']; ?></td>
                            <td><?php echo $category['model_text']; ?></td>
                            <td class="layui-form">
                                <input type="checkbox" lay-skin="switch" lay-filter="nav" lay-text="ON|OFF" data-id="<?php echo $category['id']; ?>" value="1"  <?php if($category['is_nav'] == '1'): ?> checked<?php endif; ?>>
                            </td>
                            <td class="operation">
                                <!--<a href="javascript:category.createSub('<?php echo $category['id']; ?>');" class="layui-btn layui-btn-small btn-success">-->
                                    <!--添加子栏目-->
                                <!--</a>-->
                                <a href="javascript:category.edit('<?php echo $category['id']; ?>');" class="layui-btn layui-btn-small btn-success">
                                    编辑
                                </a>
                            </td>
                        </tr>
                        <?php endforeach; endif; else: echo "" ;endif; ?>
                    </tbody>
                </table>
                <!--<div class="fl mt20">-->
                    <!--<a href="javascript:category.sort();" class="sortBtn layui-btn btn-success layui-btn-small">排序</a>-->
                <!--</div>-->
            </div>
            <div class="layui-tab-item">
                <form class="layui-form mt20">
    <div class="layui-form-item">
        <label class="layui-form-label">上级</label>
        <div class="layui-input-inline">
            <select name="pid" lay-filter="pid">
                <option value="0|0">作为一级栏目</option>
                <?php if(is_array($categorys) || $categorys instanceof \think\Collection || $categorys instanceof \think\Paginator): $i = 0; $__LIST__ = $categorys;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$category): $mod = ($i % 2 );++$i;?>
                <option value="<?php echo $category['id']; ?>|<?php echo $category['level']; ?>"<?php if($category['id'] == $pid): ?> selected<?php endif; ?>><?php echo str_repeat("&nbsp;&nbsp;",$category['level']).dec2roman($category['level']); ?>—<?php echo $category['name']; ?></option>
                <?php endforeach; endif; else: echo "" ;endif; ?>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">栏目类型</label>
        <div class="layui-input-inline">
            <select name="type" lay-filter="type">
                <?php if(is_array(\think\Config::get('category.type')) || \think\Config::get('category.type') instanceof \think\Collection || \think\Config::get('category.type') instanceof \think\Paginator): $i = 0; $__LIST__ = \think\Config::get('category.type');if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$type): $mod = ($i % 2 );++$i;?>
                <option value="<?php echo $key; ?>"><?php echo $type; ?></option>
                <?php endforeach; endif; else: echo "" ;endif; ?>
            </select>
        </div>
    </div>
    <div class="layui-form-item" id="model">
        <label class="layui-form-label">所属模型</label>
        <div class="layui-input-inline">
            <select name="model_id" lay-filter="model">
                <?php if(is_array(\think\Config::get('category.model')) || \think\Config::get('category.model') instanceof \think\Collection || \think\Config::get('category.model') instanceof \think\Paginator): $i = 0; $__LIST__ = \think\Config::get('category.model');if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$model): $mod = ($i % 2 );++$i;?>
                <option value="<?php echo $key; ?>"><?php echo $model; ?></option>
                <?php endforeach; endif; else: echo "" ;endif; ?>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">栏目标题</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" lay-verify="required" name="name">
        </div>
    </div>

    <div class="layui-form-item hidden" id="url">
        <label class="layui-form-label">链接地址</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" name="url" placeholder="请输入外部链接地址">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">栏目排序</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" name="sort"   placeholder="20">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label nomal-padding">主导航</label>
        <div class="layui-input-inline">
            <input type="checkbox" name="is_nav" lay-skin="switch" lay-text="ON|OFF" checked value="1">
        </div>
    </div>
    <div class="layui-input-block">
        <a class="layui-btn save-btn layui-btn-normal" lay-filter="save" lay-submit>保存</a>
        <input type="reset" class="layui-btn layui-btn-primary goback" value="重置">
    </div>
</form>
            </div>
        </div>
    </div>
</article>

                </div>
                <!-- Main container End  -->
                <!-- Page Footer Start-->
                <div id="kr-footer" class="tc f14 lh40">
    <a href="http://www.keywaysoft.com" target="_ablank"><?php echo $siteOption['site_name']; ?></a>
     &copy; 2017-<?php echo date('Y'); ?>
</div>
                <!-- Page Footer End -->
            </div>
            <!-- Page Main End  -->
        </div>
        
        <!-- Page Body End -->
        <?php endif; ?>
    </div>
    <!-- Page End -->
    <!-- Common JS Start -->
    <script type="text/javascript" src="__LIB__/jquery/jquery.min.js"></script><script type="text/javascript" src=" __LIB__/layui/layui.js"></script><script type="text/javascript" src=" __ADMIN__/common.js"></script>
    <!-- Common JS End -->
    <!-- Page JS Start -->
    
<script type="text/javascript" src="__LIB__/jquery/jquery.treetable.js"></script>

    <script src="__ADMIN__/<?php echo $controller; ?>.js"></script>
    <!-- Page JS End -->
</body>
</html>
