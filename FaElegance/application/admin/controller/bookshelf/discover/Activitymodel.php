<?php

namespace app\admin\controller\bookshelf\discover;

use app\common\controller\Backend;
use think\Db;
/**
 * activity
 *
 * @icon fa fa-circle-o
 */
class Activitymodel extends Backend
{

   /**
     * Activity模型对象
     * @var \app\admin\model\bookshelf\discover\Activitymodel
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\bookshelf\discover\Activitymodel;

    }



    public function index()
    {
        $ids = 1;
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
        $params = $this->preExcludeFields($params);//过滤字段
        $result = false;
        Db::startTrans();//开启事务
        try {
            //是否采用模型验证
            if ($this->modelValidate) { 
                $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.edit' : $name) : $this->modelValidate;
                $row->validateFailException()->validate($validate);
            }//验证
       
            $result = $row->allowField(true)->save($params);
            // echo $row->activityText;
            $row->activityText= json_encode($row->activityText);//json格式化
            Db::commit();//提交
        } catch (ValidateException|PDOException|Exception $e) {
            Db::rollback();//回滚
            $this->error($e->getMessage());
        }
        if (false === $result) {
            $this->error(__('No rows were updated'));
        }
        $this->success();
        // //设置过滤方法
        // $this->request->filter(['strip_tags', 'trim']);
        // if (false === $this->request->isAjax()) {
        //     return $this->view->fetch();
        // }
        // //如果发送的来源是 Selectpage，则转发到 Selectpage
        // if ($this->request->request('keyField')) {
        //     return $this->selectpage();
        // }
        // [$where, $sort, $order, $offset, $limit] = $this->buildparams();
        // $list = $this->model
        //     ->where($where)
        //     ->order($sort, $order)
        //     ->paginate($limit);
        // $result = ['total' => $list->total(), 'rows' => $list->items()];
        // return json($result);
    }
    
    /**
     * 编辑
     *
     * @param $ids
     * @return string
     * @throws DbException
     * @throws \think\Exception
     */
    public function edit($ids = null)
    {
     
        $ids = 1;
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
