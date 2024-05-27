import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Home/discover/view/PdfView.dart';
import 'package:untitled/Global/Api.dart'; //api
import 'package:untitled/Global/themeColors.dart'; //颜色

class LikePage extends StatefulWidget {
  final String token;
  final String nickname;
  final String username; //登录账户
  LikePage(
      {required this.nickname, required this.token, required this.username});
  @override
  _LikePageState createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  List<dynamic> data = []; // 存储接口返回的数据

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://${apiVar.serverIp}/EleganceApi/eleganceApp/myPage/my/show/likeList.php');
    final response =
        await http.post(url, body: {'username': '${widget.username}'});

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData;
      print(data[1]);
      setState(() {
        this.data = data;
      });
    } else {
      Fluttertoast.showToast(msg: '请检查网络');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        children: data.map((item) {
          return InkWell(
            onTap: () {
              // 添加点击事件处理
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiscoverViews(
                    token: '${widget.token}',
                    nickname: '',
                    path: item['ancientpoetry'],
                    author: item['author'],
                    dynasty: item['dynasty'],
                    sound_file: item['sound_file'],
                    book_name: item['book_name'],
                    username: '${item['sounduser']}',
                    user: '${widget.username}',
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Image.network(
                        'http://${apiVar.serverIp}/FaElegance/public${item['book_image']}'),
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    '${item['book_name']}-${item['soundusername']}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color:
                      ThemeManager.themes[colorsID.colors].ClassText1Color,
                    ),
                  ),
                ),

              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
