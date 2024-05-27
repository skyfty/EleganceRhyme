<?php

namespace app\admin\model\bookshelf\bookbank;

use think\Model;


class Booklist extends Model
{

    

    

    // 表名
    protected $name = 'book_shelf';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    

     public function getStatusList()
    {
        return ['边塞' => __('边塞'),'豪放' => __('豪放'),'婉约' =>__('婉约'),'山水' =>__('山水'),'田园' =>__('田园'),'客家' =>__('客家'),'江南' =>__('江南'),'北方' =>__('北方'),'南方' =>__('南方'),'未知' =>__('未知')];
    }     

    public function getStatusLists()
    {
        return ['先秦'=>__('先秦'),'汉朝'=>__('汉朝'),'三国'=>__('三国'),'隋朝'=>__('隋朝'),'唐朝' => __('唐朝'),'宋朝' => __('宋朝'),'元朝' => __('元朝'),'明朝' => __('明朝'),'清朝' => __('清朝'),'近现代' => __('近现代'),'当代' => __('当代'),'未知' => __('未知')];
    }   







}
