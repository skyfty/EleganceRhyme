<?php

namespace app\admin\model\background\bookbank;

use think\Model;

use think\Db;
class BookList extends Model
{

    

    

    // 表名
    protected $name = 'list_books';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];


    protected static function init()
    {
    		// 监听 book_shelf 表的数据插入操作
    self::afterInsert(function ($data) {
        // 将新插入的记录的 book_name 和 sound_file 字段添加到另一个表
        $anotherTableData = [
            'username' => 'admin',
            'book_name' => $data['book_name'],
            'sound_file' => $data['sound_file'],
        ];
        Db::name('sound')->insert($anotherTableData);
    });
        self::afterUpdate(function ($row) {//更新后
            if ($row['now_status'] == '上架') {
                //插入表book_shelf数据
                $data = [
                    'book_name' => $row['book_name'],
                    'book_image' => $row['book_image'],
                    'book_file' => $row['book_file'],
                    'sound_file' => $row['sound_file'],
                    'time_shelf' => date('Y-m-d H:i:s'),
                 
                ];
                Db::name('book_shelf')->insert($data);

               
               
            }else if($row['now_status'] == '下架'){
                //删除表book_shelf数据
                Db::name('book_shelf')->where('book_name', $row['book_name'])->delete();
            }
        });

    }

    







}
