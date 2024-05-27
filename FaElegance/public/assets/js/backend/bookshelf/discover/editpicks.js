define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'bookshelf/discover/editpicks/index' + location.search,
                    add_url: 'bookshelf/discover/editpicks/add',
                    edit_url: 'bookshelf/discover/editpicks/edit',
                    del_url: 'bookshelf/discover/editpicks/del',
                    multi_url: 'bookshelf/discover/editpicks/multi',
                    import_url: 'bookshelf/discover/editpicks/import',
                    table: 'editpicks',
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
//                        {field: 'id', title: __('Id')},
//                        {field: 'content', title: __('Content')},
                         { field: 'aaa.nickname', title: __('Sound_name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
                        { field: 'book_name', title: __('Book_name'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content },
                        { field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate }
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
              var nicknames = [];   // 昵称列表
            var booknames = [];   // 书名列表
            $.ajax({
                url: "bookshelf/discover/editpicks/view",
                type: "GET",
                dataType: "json",
                success: function (data) {

                    nicknames = data;
                }
            });
            $(document).ready(function () {


                //音频作者搜索
                $('#c-sound_name').on('input', function () {
                    var query = $(this).val().toLowerCase(); // 获取输入框的值并转为小写以便不区分大小写搜索      
                    var results = $('#search-results');      // 获取搜索结果列表
                    results.empty(); // 清空之前的搜索结果     
                    results.show();

                    if (query.length > 0) { // 当输入字符长度大于0时开始搜索      
                        var filteredNicknames = nicknames.filter(function (item) {
                            return item.nickname.toLowerCase().indexOf(query) !== -1; // 搜索昵称中包含查询字符串的项      
                        });

                        // 遍历过滤后的昵称，并为每个昵称创建一个列表项  
                        $.each(filteredNicknames, function (index, item) {
                            var listItem = $('<li class="list-group-item">' + item.nickname + '</li>');
                            listItem.on('click', function () { // 为每个列表项添加点击事件监听器  
                                // 设置输入框的值为昵称（显示给用户看）  
                                $('#c-sound_name').val(item.nickname);
                          
                                $.ajax({
                                    url: "bookshelf/discover/editpicks/bookview",//
                                    //传参
                                    data: {
                                        nickname: item.nickname
                                    },
                                    type: "GET",
                                    dataType: "json",
                                    success: function (data) {
                                        console.log(data);
                                        booknames = data;

                                    }
                                });


                                // 将用户名存储在输入框的data属性中  

                                results.empty().hide(); // 清空搜索结果并隐藏列表 


                            });
                            results.append(listItem); // 将列表项添加到结果列表中  
                        });
                    } else {
                        results.hide(); // 如果没有输入任何内容，也隐藏列表  
                    }
                });
                // 点击页面其他地方时，隐藏搜索结果
                $(document).on('click', function () {
                    $('#search-results').hide();
                });
            




                //古诗搜索
                $('#c-book_name').on('input', function () {
                    //判断booknames的值是不是空的
                    if (booknames.length == 0) {
                        var sound_name = $('#c-sound_name').val();
                        console.log(sound_name);
                        $.ajax({
                            url: "bookshelf/discover/editpicks/bookview",//
                            //传参
                            data: {
                                nickname: sound_name
                            },
                            type: "GET",
                            dataType: "json",
                            success: function (data) {
                                console.log(data);
                                booknames = data;

                            }
                        });
                    
                    }
                    //获取#c-sound_name的值
                  console.log(booknames);
                  
                  
                    var query = $(this).val().toLowerCase(); // 获取输入框的值并转为小写以便不区分大小写搜索      
                    var results = $('#search-book_name');      // 获取搜索结果列表
                    results.empty(); // 清空之前的搜索结果     
                    results.show();

                    if (query.length > 0) { // 当输入字符长度大于0时开始搜索    
                        console.log(12377777);
                        var filteredBookNames = booknames.filter(function (item) {
                            return item.book_name.toLowerCase().indexOf(query) !== -1; // 搜索昵称中包含查询字符串的项      
                        });
                        console.log(123213);
                        // 遍历过滤后的昵称，并为每个昵称创建一个列表项  
                        if (filteredBookNames.length > 0) {
                            $.each(filteredBookNames, function (index, item) {
                                var listItem = $('<li class="list-group-item">' + item.book_name + '</li>');

                                listItem.on('click', function () { // 为每个列表项添加点击事件监听器  
                                    $('#c-book_name').val(item.book_name); // 设置输入框的值为被点击的书名  
                                    // 这里不需要清空或隐藏结果列表，因为用户已经选择了他们想要的项  
                                    results.empty().hide();
                                });

                                results.append(listItem); // 将列表项添加到结果列表中  
                            });

                            // 如果有搜索结果，显示结果列表  
                            results.show();
                        } else {
                            // 如果没有找到匹配的书名，则显示“没有找到结果”的消息  
                            var noResultItem = $('<li class="list-group-item">该用户没有这个古诗作品</li>');
                            results.append(noResultItem); // 将消息添加到结果列表中  
                            // 由于我们已经添加了消息，所以仍然需要显示结果列表（即使它只包含一条消息）  
                            results.show();
                        }
                    } else {

                        results.hide(); // 如果没有输入任何内容，也隐藏列表  
                    }


                });


                // 点击页面其他地方时，隐藏搜索结果
              
                
//
//                $('#c-book_name').on('blur', function () {
//                    var selectedValue = $(this).val().trim();
//                    var isExist = false;
//                    for (var i = 0; i < booknames.length; i++) {
//                      if (selectedValue == booknames[i].book_name) {
//                        isExist = true;
//                        break;
//                      }
//                    }
//                    if (!isExist) {
//                      $(this).val('');
//                    }
//                    $('#search-book_name').hide();
//                  });


            });


        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});
