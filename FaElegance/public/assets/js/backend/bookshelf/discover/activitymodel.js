define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'bookshelf/discover/activitymodel/index' + location.search,
                    add_url: 'bookshelf/discover/activitymodel/add',
                    edit_url: 'bookshelf/discover/activitymodel/edit',
                    del_url: 'bookshelf/discover/activitymodel/del',
                    multi_url: 'bookshelf/discover/activitymodel/multi',
                    import_url: 'bookshelf/discover/activitymodel/import',
                    table: 'cms_addonactivity',
                }
            });

//            var table = $("#table");
//
//            // 初始化表格
//            table.bootstrapTable({
//                url: $.fn.bootstrapTable.defaults.extend.index_url,
//                pk: 'id',
//                sortName: 'id',
//                columns: [
//                    [
//                        {checkbox: true},
//                        {field: 'id', title: __('Id')},
//                        {field: 'content', title: __('Content')},
//                        {field: 'activityIcon', title: __('Activityicon'), operate: 'LIKE', formatter: Table.api.formatter.icon},
//                        {field: 'activityText', title: __('Activitytext'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
//                        {field: 'activityImage', title: __('Activityimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
//                        {field: 'activityParagraph', title: __('Activityparagraph'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
//                        {field: 'activityTitle', title: __('Activitytitle'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
//                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
//                    ]
//                ]
//            });

            // 为表格绑定事件
             Controller.api.bindevent();
//            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});
