define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'bookshelf/home/hometop/index' + location.search,
                    add_url: 'bookshelf/home/hometop/add',
                    edit_url: 'bookshelf/home/hometop/edit',
                    del_url: 'bookshelf/home/hometop/del',
                    multi_url: 'bookshelf/home/hometop/multi',
                    import_url: 'bookshelf/home/hometop/import',
                    table: 'home_top',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true}, 
                        {field: 'id', title: __('Id')},
                        {field: 'content', title: __('Content'),operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'bookname', title: __('Bookname'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'book_image', title: __('Book_image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: function (value, row, index) {
 
 
                            var that = $.extend({}, this);
                             
                             
                            var table = $(that.table).clone(true);
                             
                             
                            // $(table).data("operate-edit", null);
                             
                             
                            $(table).data("operate-del", null);
                             
                             
                            that.table = table;
                             
                             
                            return Table.api.formatter.operate.call(that, value, row, index);
                            }}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
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
