import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/Home/My/EditPage.dart';

import 'package:untitled/Global/Global.dart';
import '../Login/Login.dart';

import 'package:untitled/Global/Api.dart'; //api
import 'package:untitled/Global/themeColors.dart'; //颜色

class MyPage extends StatefulWidget {
  final String token;
  final String nickname;
  final String username;
  final Function changeThemeColor;
  MyPage(
      {required this.token,
      required this.nickname,
      required this.username,
      required this.changeThemeColor});
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool isSettingVisible = false;
  void initState() {
    super.initState();
  }

  void closeSettingPage() {
    setState(() {
      isSettingVisible = false;
    });
  }

  late BuildContext dialogContext;

  @override
  Widget build(BuildContext context) {
    void aa() {
      setState(() {
        widget.changeThemeColor();
      });
    }

    return WillPopScope(
      onWillPop: () async {
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
        backgroundColor:
            ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
        body: Column(
          children: [
            // Divider(),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 10, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: '该功能雅韵系统暂未开放');
                      // 跳转
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ThemeManager
                                .themes[colorsID.colors].MyTextColor,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 5, top: 5, right: 5, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                '我的花园 >',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeManager
                                      .themes[colorsID.colors].MyTextColor,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          dialogContext = context; // 存储弹窗的BuildContext
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Align(
                              alignment: Alignment.centerRight,
                              child: FractionallySizedBox(
                                widthFactor: 0.5, // 设置弹窗宽度为屏幕宽度的一半
                                child: Container(
                                  color: ThemeManager.themes[colorsID.colors]
                                      .IndexBackgroundColor,
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // moneyRow(),

                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 23),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '切换主题色',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: ThemeManager
                                                    .themes[colorsID.colors]
                                                    .MyTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 23),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {}); // 通知弹窗重新构建
                                            aa(); // widget.changeThemeColor();
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                '兰花白',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: ThemeManager
                                                      .themes[colorsID.colors]
                                                      .MyEditTextColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    6,
                                              ),
                                              Icon(
                                                colorsID.colors == 0
                                                    ? Icons.toggle_on_outlined
                                                    : Icons.toggle_off_outlined,
                                                color: colorsID.colors == 0
                                                    ? ThemeManager
                                                        .themes[colorsID.colors]
                                                        .MyLogIconColor
                                                    : ThemeManager
                                                        .themes[colorsID.colors]
                                                        .MyEditTextColor,
                                                size: 24,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 23),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {}); // 通知弹窗重新构建
                                            aa(); // widget.changeThemeColor();
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                '锅底黑',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: ThemeManager
                                                      .themes[colorsID.colors]
                                                      .MyEditTextColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    6,
                                              ),
                                              Icon(
                                                colorsID.colors == 1
                                                    ? Icons.toggle_on_outlined
                                                    : Icons.toggle_off_outlined,
                                                color: colorsID.colors == 1
                                                    ? ThemeManager
                                                        .themes[colorsID.colors]
                                                        .MyLogIconColor
                                                    : ThemeManager
                                                        .themes[colorsID.colors]
                                                        .MyEditTextColor,
                                                size: 24,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SetRow(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      );
                    },
                    child: Icon(
                      Icons.menu_open,
                      color: ThemeManager.themes[colorsID.colors].MyTextColor,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, left: 0, right: 0),
              child: SizedBox(
                height: 90, // 设置整个组件的高度
                child: GestureDetector(
                  onTap: () {
                    // 跳转到编辑个人资料页面
                    if (Global.status == '正常登录') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(username: widget.username)),
                      );
                    } else if (Global.status == '游客登录状态') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 设置主轴的对齐方式
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(32), // 设置圆角
                            child: Image.network(
                              'http://${apiVar.serverIp}/FaElegance/public${Global.avatar ?? "/uploads/6638a67c629e8.jpg"}',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover, // 设置图片的填充方式
                            ),
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                    ],
                  ),
                ),

              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 130,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // 跳转到编辑个人资料页面
                      if (Global.status == '正常登录') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditProfilePage(username: widget.username)),
                        );
                      } else if (Global.status == '游客登录状态') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          '${widget.nickname}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: ThemeManager
                                .themes[colorsID.colors].MyTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   '${widget.nickname}',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w500,
                  //     color: ThemeManager.themes[colorsID.colors].MyTextColor,
                  //   ),
                  // ),
                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                  Container(
                    color: Colors.yellow,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: GestureDetector(
                      onTap: () {
                        // 跳转到编辑个人资料页面
                        Fluttertoast.showToast(msg: '该功能雅韵系统暂未开放');
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           VipPage(username: widget.username)),
                        // );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.stars, // 使用 Material 图标库
                            color: Global.vip == '是'
                                ? Colors.amber
                                : Colors.grey, // 根据 widget.vip 设置图标颜色
                            size: 20,
                          ),
                          Text(
                            '尊贵会员',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 110,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 设置主轴的对齐方式
                children: [
                  GestureDetector(
                    onTap: () {
                      print(Global.status);
                      // 跳转到编辑个人资料页面
                      if (Global.status == '正常登录') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditProfilePage(username: widget.username)),
                        );
                      } else if (Global.status == '游客登录状态') {
                        clearLogin();
                        // Fluttertoast.showToast(msg: '请先退出登录进行手机验证登录');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          '编辑个人资料',
                          style: TextStyle(
                            fontSize: 14,
                            color: ThemeManager
                                .themes[colorsID.colors].MyEditTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 设置主轴的对齐方式
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            '收到花束 ',
                            style: TextStyle(
                              fontSize: 20,
                              color: ThemeManager
                                  .themes[colorsID.colors].MyTextColor,
                            ),
                          ),
                          Text(
                            _formatLikeNum(Global.flowerNum),
                            //'${Global.flowerNum}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 9),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            '收到的心 ',
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeManager
                                  .themes[colorsID.colors].MyTextColor,
                            ),
                          ),
                          Text(
                            _formatLikeNum(Global.likeNum),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
          ],
        ),
      ),
    );
  }

//计算数量
  String _formatLikeNum(int num) {
    if (num < 10000) {
      return num.toString();
    } else if (num < 100000000) {
      return '${(num / 10000).toStringAsFixed(1)}万';
    } else {
      return '9999+万';
    }
  }

//皮肤
  Widget SkinColor(void Function() changeThemeColor) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                changeThemeColor();
              },
              child: Row(
                children: [
                  Text('兰花白'),
                  Icon(
                    colorsID.colors == 0
                        ? Icons.toggle_on_outlined
                        : Icons.toggle_off_outlined,
                    color:
                        colorsID.colors == 0 ? Colors.lightBlue : Colors.black,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                changeThemeColor();
              },
              child: Row(
                children: [
                  Text('锅底黑'),
                  Icon(
                    colorsID.colors == 1
                        ? Icons.toggle_on_outlined
                        : Icons.toggle_off_outlined,
                    color:
                        colorsID.colors == 1 ? Colors.lightBlue : Colors.black,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//余额
  Widget moneyRow() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: Colors.black,
            ),
            SizedBox(width: 8.0),
            Text(
              '余额',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget SetRow() {
    return GestureDetector(
      onTap: () {
        clearLogin();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: ThemeManager.themes[colorsID.colors].backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            SizedBox(width: 8.0),
            Text(
              '退出登录',
              style: TextStyle(
                color: ThemeManager.themes[colorsID.colors].MyTextColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
