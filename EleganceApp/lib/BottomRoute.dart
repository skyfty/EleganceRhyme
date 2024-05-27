import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/Home/myPage.dart'; // 我的主页
import 'package:untitled/Home/homePage.dart'; // 主页
import 'package:flutter/material.dart';
import 'package:untitled/Home/bookshelf/index.dart';
import 'package:untitled/Home/discover/index.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Global/Global.dart';
import 'package:untitled/Global/themeColors.dart';
import 'package:untitled/Global/Api.dart';

class BottomRoute extends StatefulWidget {
  final String token;
  final String nickname;
  final String username;

  const BottomRoute(
      {Key? key,
      required this.token,
      required this.nickname,
      required this.username})
      : super(key: key);

  @override
  _BottomRouteState createState() => _BottomRouteState();
}

class _BottomRouteState extends State<BottomRoute> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

    get();
  }

  Future<void> get() async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/Login/get.php',
    );
    final response = await http.post(
      url,
      body: {
        'username': widget.username,
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData[0]['appstatus'] == '游客登录状态') {
        Global.avatar = responseData[0]['avatar'];
        Global.status = responseData[0]['appstatus'];
      } else {
        Global.status = responseData[0]['appstatus'];
        Global.email = responseData[0]['email'];
        Global.phone = responseData[0]['mobile'];
        Global.birthday = responseData[0]['birthday'];
        Global.sex = responseData[0]['sex'];
        Global.vip = responseData[0]['vip'];
        Global.avatar = responseData[0]['avatar'];
      }
    } else {
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  void _changeThemeColor() {
    setState(() {
      if (colorsID.colors == 0) {
        colorsID.colors = 1;
        print('换色成功1');
      } else {
        colorsID.colors = 0;
        print('换色成功2');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(
          token: '${widget.token}',
          nickname: '${widget.nickname}',
          username: '${widget.username}'),
      DiscoverPage(
        username: '${widget.username}',
        token: '${widget.token}',
      ),
      BookShelfPage(
          token: '${widget.token}',
          nickname: '${widget.nickname}',
          username: '${widget.username}'),
      MyPage(
        token: '${widget.token}',
        nickname: '${widget.nickname}',
        username: '${widget.username}',
        changeThemeColor: _changeThemeColor,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: ThemeManager.themes[colorsID.colors].IndexTopColor,
        unselectedItemColor:
            ThemeManager.themes[colorsID.colors].BottmTextColor,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '发现',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '书架',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
