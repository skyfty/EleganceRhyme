<?php

namespace app\admin\controller\bookshelf\discover;

use app\common\controller\Backend;
use think\Db;
/**
 * edit_picks
 *
 * @icon fa fa-circle-o
 */
class Editpicks extends Backend
{

    /**
     * Editpicks模型对象
     * @var \app\admin\model\bookshelf\discover\Editpicks
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\bookshelf\discover\Editpicks;

    }



   public function view()
{ 
    
    $list= Db::name('admin')//查询所有值
        ->field('id, username,nickname')
        ->where('id', '>', 0)
        ->select(); // 使用select()方法获取所有结果  
        return json($list);
  
}


public function bookview($nickname)
{ 
    $row= Db::name('admin')//查询所有值
    ->field('id, username,nickname')
    ->where('nickname', 'like', $nickname)
    ->select(); // 使用select()方法获取所有结果  

    //拿到数组中的username值
    $username = $row[0]['username'];
   
    $list= Db::name('sound')//查询所有值
        ->field('id, username,book_name')
        ->where('username', 'like', $username)
        ->select(); // 使用select()方法获取所有结果  
        return json($list);

  
}

     //关联查询显示
   public function index()
   {
       //当前是否为关联查询
       $this->relationSearch = true;
       //设置过滤方法 
       $this->request->filter(['strip_tags', 'trim']);
       if ($this->request->isAjax()) {
           //如果发送的来源是Selectpage，则转发到Selectpage
           if ($this->request->request('keyField')) {
               return $this->selectpage();
           }
           list($where, $sort, $order, $offset, $limit) = $this->buildparams();
           $total = $this->model
           ->with(["aaa"])
           ->where($where)
           ->order($sort, $order)
           ->count();
           $list = $this->model
                   ->with(['aaa'])//关联查询
                   ->where($where)
                   ->order($sort, $order)
                   ->paginate($limit);


           $result = array("total" => $list->total(), "rows" => $list->items());
          
           return json($result);
       }
       return $this->view->fetch();
   }

 public function edit($ids = null)
    {
        $row = $this->model->get($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $adminIds = $this->getDataLimitAdminIds();
        if (is_array($adminIds) && !in_array($row[$this->dataLimitField], $adminIds)) {
            $this->error(__('You have no permission'));
        }
        if (false === $this->request->isPost()) {
            $this->view->assign('row', $row);
            return $this->view->fetch();
        }
        $params = $this->request->post('row/a');
        if (empty($params)) {
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $params = $this->preExcludeFields($params);
        $result = false;
        Db::startTrans();
        try {
            //是否采用模型验证
            if ($this->modelValidate) {
                $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.edit' : $name) : $this->modelValidate;
                $row->validateFailException()->validate($validate);
            }
            $result = $row->allowField(true)->save($params);
            $list= Db::name('admin')//查询所有值
            ->field('id, username,nickname')
            ->where('nickname', 'like', $row->sound_name)
            ->select(); // 使用select()方法获取所有结果  
           

            if($row->sound_name){
                $row->sound_name = $list[0]['username'];
                $row->save();
            }
            Db::commit();
        } catch (ValidateException|PDOException|Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if (false === $result) {
            $this->error(__('No rows were updated'));
        }
        $this->success();
    }


    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


}
