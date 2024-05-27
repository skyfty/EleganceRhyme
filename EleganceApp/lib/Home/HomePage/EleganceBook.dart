import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/Home/HomePage/PdfView.dart';
import 'package:untitled/Global/Api.dart';
import 'package:untitled/Global/Api.dart'; //api

class BookShow extends StatefulWidget {
  final String token;
  final String book_name;
  final String nickname;
  final String username;

  BookShow(
      {required this.nickname,
      required this.token,
      required this.book_name,
      required this.username});

  @override
  _BookShowState createState() => _BookShowState();
}

class _BookShowState extends State<BookShow> {
  late String book_image = '';
  late String content = '';
  late String book_path = '';
  late String sound_file = '';
  late String? dynasty = '';//朝代
  late String? author = '';//作者

  bool isDataLoaded = false; // 添加一个数据加载状态的变量

  @override
  void initState() {
    super.initState();
    fetchBookData(); // 在页面初始化时获取数据
  }

  Future<void> fetchBookData() async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/HomePage/eleganceBook.php',
    );
    final response = await http.post(
      url,
      body: {
        'book_name': widget.book_name,
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      setState(() {
        book_image = responseData[0]['book_image'];
        content = responseData[0]['content'];
        dynasty:responseData[0]['dynasty'];
        author:responseData[0]['author'];
        book_path = responseData[0]['ancientpoetry'];
        sound_file = responseData[0]['sound_file'];
        isDataLoaded = true; // 标记数据已加载完成
      });
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book_name}'),
      ),
      body: isDataLoaded
          ? buildContent()
          : buildLoadingIndicator(), // 根据数据加载状态显示不同的内容
    );
  }

  Widget buildContent() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 30, top: 20),
                  child: Image.network(
                    'http://${apiVar.serverIp}/FaElegance/public${book_image}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 0, top: 180),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFS(
                            path: book_path,
                            dynasty:dynasty,
                            author:author,
                            sound_file: sound_file,
                            token: widget.token,
                            book_name: widget.book_name,
                            nickname: widget.nickname,
                            username: widget.username,
                          ), // 替换为您要跳转的页面
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        '开始阅读', // 右侧显示书名
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 40, right: 15),
            child: RichText(
              text: TextSpan(
                text: '      简介：',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.red, // 设置"简介"字体颜色为红色
                  height: 1.5, // 设置行高为原始高度的1.5倍
                ),
                children: [
                  TextSpan(
                    text: content,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      height: 1.8, // 设置行高为原始高度的1.5倍
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(), // 显示加载指示器
    );
  }
}
