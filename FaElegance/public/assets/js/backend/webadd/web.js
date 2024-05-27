define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'webadd/index' + location.search,
                    add_url: 'webadd/index',
                    edit_url: 'webadd/index',
                    del_url: 'bookshelf/bookbank/booklist/del',
                    multi_url: 'bookshelf/bookbank/booklist/multi',
                    import_url: 'bookshelf/bookbank/booklist/import',
                    table: 'book_shelf',
                }
            });

            var table = $("#table");

            // 初始化表格
            // table.bootstrapTable({
            //     url: $.fn.bootstrapTable.defaults.extend.index_url,
            //     pk: 'id',
            //     sortName: 'id',
            //     columns: [
            //         [
            //             {checkbox: true},
            //             {field: 'id', title: __('Id')},
            //             {field: 'content', title: __('Content'),operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
            //             {field: 'book_name', title: __('Book_name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
            //             {field: 'classes', title: __('类别'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
            //             {field: 'dynasty', title: __('朝代'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
            //             {field: 'book_image', title: __('Book_image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
            //             {field: 'book_file', title: __('Book_file'), operate: false, formatter: Table.api.formatter.file},
            //             {field: 'time_shelf', title: __('Time_shelf')},
            //             {field: 'sound_file', title: __('Sound_file'), operate: false, formatter: Table.api.formatter.file},
            //             {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
            //         ]
            //     ]
            // });

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
