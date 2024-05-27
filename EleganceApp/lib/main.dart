import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/Home/HomePage/PdfView.dart'; //PDFVIEW
import 'package:untitled/Login/Login.dart'; //登录
import 'package:untitled/BottomRoute.dart'; //底部路由
import 'package:untitled/Home/HomePage/EleganceBook.dart'; //古诗介绍页面
import 'package:untitled/Home/homePage.dart';

import 'package:shared_preferences/shared_preferences.dart'; //记录状态
import 'package:untitled/Global/Global.dart';
import 'package:untitled/Global/Api.dart';

const int kLoginExpirationDays = 700; // 定义登录有效期为7天
late SharedPreferences prefs;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Android ID Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      locale: const Locale('zh', 'CN'),
      initialRoute: '/',
      routes: {
        // '/': (context) => LoginScreen(),
        '/homepage': (context) => Builder(
              builder: (context) => HomePage(
                token: (ModalRoute.of(context)!.settings.arguments
                    as Map)['token'],
                nickname: (ModalRoute.of(context)!.settings.arguments
                    as Map)['nickname'],
                username: (ModalRoute.of(context)!.settings.arguments
                    as Map)['username'],
              ),
            ),
        '/bottomRoute': (context) => Builder(
              builder: (context) => BottomRoute(
                token: (ModalRoute.of(context)!.settings.arguments
                    as Map)['token'],
                nickname: (ModalRoute.of(context)!.settings.arguments
                    as Map)['nickname'],
                username: (ModalRoute.of(context)!.settings.arguments
                    as Map)['username'],
              ),
            ), //底部路由导航
        '/bookShow': (context) => Builder(
              builder: (context) => BookShow(
                token: (ModalRoute.of(context)!.settings.arguments
                    as Map)['token'],
                book_name: (ModalRoute.of(context)!.settings.arguments
                    as Map)['book_name'],
                nickname: (ModalRoute.of(context)!.settings.arguments
                    as Map)['nickname'],
                username: (ModalRoute.of(context)!.settings.arguments
                    as Map)['username'],
              ),
            ),
        '/PdfView': (context) => Builder(
              builder: (context) => PDFS(
                path:
                    (ModalRoute.of(context)!.settings.arguments as Map)['path'],
                username: (ModalRoute.of(context)!.settings.arguments
                    as Map)['username'],
              ),
            ),
      },
      home: FutureBuilder(
        future: requestPermissions(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MyPage();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> requestPermissions() async {
    final PermissionStatus status = await Permission.phone.request();
    if (status.isGranted) {
      Fluttertoast.showToast(msg: '设备信息权限获取成功');
      // 权限已授予，执行相应操作
      // 请在此处添加您的代码
    } else if (status.isPermanentlyDenied) {
      // 权限被永久拒绝，需要引导用户手动授予权限
      Fluttertoast.showToast(msg: '请打开获取设备信息权限');
      openAppSettings();
    } else {
      Fluttertoast.showToast(msg: '请打开获取设备信息权限');
      // 权限被拒绝，可以根据需求进行相应处理
      // 比如显示一个提示框告知用户权限的重要性，并提供重新请求权限的按钮
    }
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String? androidIds;
  bool isLoading = false;

  // 创建与原生代码通信的平台通道
  final platform = MethodChannel('com.example.android_id');

  // 获取Android设备的ID
  Future<String?> getAndroidId() async {
    try {
      final String androidId = await platform.invokeMethod('getAndroidId');
      hometop(androidId);
      setState(() {
        androidIds = androidId;
        Global.AndID = androidId;
      });
      return androidId;
    } catch (e) {
      print('Error getting Android ID: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getAndroidId();
  }

  Future<void> hometop(androidid) async {
    setState(() {
      isLoading = true;
    });

    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/first.php',
    );
    final response = await http.post(
      url,
      body: {'androidID': androidid},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // print(responseData);
      if (responseData['aa'] == '未进行手机号注册') {
        Future.delayed(Duration(seconds: 3), () {
          Mobile.apps = '游客登录';
          // 页面跳转至主页面（MyPage）
          Navigator.pushNamed(
            context,
            '/bottomRoute',
            arguments: {
              'token': responseData['token'],
              'nickname': responseData['nickname'],
              'username': responseData['username'],
            },
          );
        });
      } else if (responseData['aa'] == '已进行手机号注册') {
        Mobile.apps = '正常登录';
        Future.delayed(Duration(seconds: 3), () {
          // 页面跳转至主页面（MyPage）
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        });
      }
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('网络错误'),
            content: Text('无法连接到服务器，请检查网络连接。'),
            actions: [
              TextButton(
                child: Text('重试'),
                onPressed: () {
                  Navigator.of(context).pop(); // 关闭弹窗
                  hometop(androidid); // 重新加载
                },
              ),
            ],
          );
        },
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/ICON87.png', // 替换为你的图标文件名
              width: 100, // 你可以根据需要设置宽度和高度
              height: 100,
            ),
            if (isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
