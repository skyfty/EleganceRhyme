<?php

namespace app\admin\model\bookshelf\discover;

use think\Model;


class Editpicks extends Model
{

    

    

    // 表名
    protected $name = 'editpicks';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    
  public function aaa()
    {
        return $this->belongsTo('app\admin\model\Admin', 'sound_name', 'username', [], 'LEFT')->setEagerlyType(0);
    }
    
    







}
