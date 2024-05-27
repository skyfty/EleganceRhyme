import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Home/My/View/PdfView.dart';
import 'package:untitled/Global/Api.dart'; //api
import 'package:untitled/Global/themeColors.dart';//颜色
//私密
class PrivatePage extends StatefulWidget {
  final String token;
  final String nickname;
  final String username;
  PrivatePage(
      {required this.nickname, required this.token, required this.username});

  @override
  _PrivatePageState createState() => _PrivatePageState();
}

class _PrivatePageState extends State<PrivatePage> {
  List<dynamic> data = []; // 存储接口返回的数据

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://${apiVar.serverIp}/EleganceApi/eleganceApp/myPage/my/show/limits.php');
    final response =
        await http.post(url, body: {'username': '${widget.username}'});

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData;

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
      backgroundColor:ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 0.6,
        // padding: EdgeInsets.all(8.0),
        children: data.map((item) {
          return InkWell(
            onTap: () {
              // 添加点击事件处理
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Views(
                    token: '${widget.token}',
                    nickname: '${widget.nickname}',
                    path: item['ancientpoetry'],
                    author: item['author'],
                    dynasty: item['dynasty'],
                    sound_file: item['sound_file'],
                    book_name: item['book_name'],
                    username: '${widget.username}',
                    user: '${widget.username}',
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 20),
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
                  child:  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      item['book_name'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        color:  ThemeManager.themes[colorsID.colors].ClassText1Color,
                      ),
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
