<?php

namespace app\admin\model\cms;

use think\Model;

class Order extends Model
{
    // 表名
    protected $name = 'cms_order';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    // 追加属性
    protected $append = [
        'paytime_text',
        'status_text'
    ];

    public function getStatusList()
    {
        return ['created' => __('Created'), 'paid' => __('Paid'), 'expired' => __('Expired')];
    }

    public function getPaytimeTextAttr($value, $data)
    {
        $value = $value ?: ($data['paytime'] ?? '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    public function getStatusTextAttr($value, $data)
    {
        $value = $value ?: ($data['status'] ?? '');
        $list = $this->getStatusList();
        return $list[$value] ?? '';
    }

    protected function setPaytimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    public function user()
    {
        return $this->belongsTo("\app\common\model\User", 'user_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }

    public function archives()
    {
        return $this->belongsTo("Archives", 'archives_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }
}
