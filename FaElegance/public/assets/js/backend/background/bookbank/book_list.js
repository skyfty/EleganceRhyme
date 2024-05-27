define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {

            // Form.api.bindevent($("a[role=test]"));//绑定事件
            // // function editAction() {
            // //     return 'background/bookbank/view';
            // // }
            // $('#printButton').click(function () { 
            //     var url = 'background/bookbank/add';
            //     console.log(url);
            //     window.location.href = url;
            // });
            
         



            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'background/bookbank/book_list/index' + location.search,
                    add_url: 'background/bookbank/book_list/add',
                    edit_url: 'background/bookbank/book_list/edit',
                    del_url: 'background/bookbank/book_list/del',
                    view_url: 'background/bookbank/book_list/view',
                    multi_url: 'background/bookbank/book_list/multi',
                    import_url: 'background/bookbank/book_list/import',
                    table: 'list_books',
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
                        // {field: 'id', title: __('Id')},
                        // {field: 'content', title: __('Content')},

                        {field: 'book_name', title: __('Book_name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'auther', title: __('作者'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                         {field: 'dynasty', title: __('朝代'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'ancientpoetry', title: __('正文'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        
                        {field: 'now_status', title: __('当前状态'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'sound_file', title: __('Sound_file'), operate: false, formatter: Table.api.formatter.file},
                        // {field: 'book_file', title: __('Book_file'), operate: false, formatter: Table.api.formatter.file},
                        {field: 'book_image', title: __('Book_image'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, 
                        // buttons: [
                        //     { 
                        //         name: 'view',
                        //         title: function (row) {//这里的row是当前行的数据
                        //             return row.id;
                        //         },
                        //         classname: 'btn btn-xs  btn-success btn-magic btn-addtabs btn-view',
                        //         icon: 'fa fa-folder-o',
                        //         url: function (row) { // 使用函数动态构建URL    
                                   
                                        
                        //                 return 'background/bookbank/add';
                                    
                        //         }
                        //     }           
                        // ],
                        
                        
                        formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        view: function () {
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
