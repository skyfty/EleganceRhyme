define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            Controller.api.bindevent();
           



            Form.api.bindevent($("form[role=test]"));//绑定事件

           

            var content = '';
            $('.editor').on('input', function () {
                 content = $(this).val(); // 获取富文本内容
                console.log(content); // 输出内容到控制台
                
            });
            $('#printButton').click(function () {  
      
                // 假设content是您想要传递的数据  
                console.log(content);
                // var content = ""; 
                console.log('webadd/test/upload?htmlContent=' + content + '&name=语文&username=15110055954');
                return 'webadd/test/upload?htmlContent=' + content + '&name=语文&username=15110055954';
             
                // upload(content, '语文', '15110055954'); 
                  
                // $.ajax({  
                //     url: 'http://192.168.33.226:140/admin/controller/webadd/test/upload',
                //     // url: 'http://192.168.33.226:150/admin/controller/webadd/test/upload',  
                //     // url: '../../../../../../application/admin/controller/webadd/test/upload',  
                //     // url: 'http://192.168.33.226:140/web/test.php',  
                //     type: 'POST',  
                //     data: {  
                //         'htmlContent': content,  
                //         'name': '语文',  
                //         'username': '15110055954'  
                //     },  
                //     success: function(response) {  
                //         // 将JSON字符串转换为JavaScript对象  
                //         // var jsonResponse = $.parseJSON(response);  
                //         console.log(response);
                //         // 处理JSON响应  
                //         // console.log(jsonResponse); 
                //         // console.log(jsonResponse.code);
                //         // console.log(jsonResponse['success']);
                //         // console.log(jsonResponse['error']); 
                //         // 在这里可以对jsonResponse进行进一步的处理，例如访问其属性或执行其他操作  
                          
                //     },  
                //     error: function(error) {  
                //         console.log(error);  
                //     }  
                // });  
            }); 
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'webadd/test/index' + location.search,
                    add_url: 'webadd/test/add',
                    edit_url: 'webadd/test/edit',
                    del_url: 'webadd/test/del',
                    multi_url: 'webadd/test/multi',
                    import_url: 'webadd/test/import',
                    table: 'testforma',
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
                        {field: 'content', title: __('Content')},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
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
