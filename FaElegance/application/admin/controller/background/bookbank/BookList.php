<?php

namespace app\admin\controller\background\bookbank;

use app\common\controller\Backend;

/**
 * ListBooks
 *
 * @icon fa fa-circle-o
 */
class BookList extends Backend
{

    /**
     * BookList模型对象
     * @var \app\admin\model\background\bookbank\BookList
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\background\bookbank\BookList;

    }

    public function view()//企业主体信息
    { 
       echo 'qwwrqnh';
        $row = Db::name('book_shelf')
            ->where('book_name', $name)
            ->find();
            // return json($row);
        // 渲染视图模板并传递数据
        return $this->fetch('business/business/view', ['row' => $row]);
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


}



