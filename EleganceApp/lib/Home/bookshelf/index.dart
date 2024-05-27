import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/Home/My/WorkPage.dart';
import 'package:untitled/Home/My/PrivatePage.dart';
import 'package:untitled/Home/My/LikePage.dart';
import 'package:untitled/Home/My/PraisePage.dart';
import 'package:untitled/Global/Api.dart'; //api
import 'package:untitled/Global/themeColors.dart'; //颜色

class BookShelfPage extends StatefulWidget {
  final String token;
  final String nickname;
  final String username;
  BookShelfPage(
      {required this.token, required this.nickname, required this.username});
  @override
  _BookShelfPageState createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  int _currentPageIndex = 0;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 110,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
            Theme(
              data: ThemeData(
                brightness: Brightness.light,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                backgroundColor:
                    ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
                currentIndex: _currentPageIndex,
                onTap: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                elevation: 0,
                type: BottomNavigationBarType.fixed,

                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Colors.green,
                unselectedItemColor:
                    ThemeManager.themes[colorsID.colors].ClassText1Color,
                selectedLabelStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 16.0,
                  // decoration: TextDecoration.underline, // 添加下划线
                  decorationColor: Colors.green,
                  decorationThickness: 2.0,
                ),

                items: [
                  BottomNavigationBarItem(
                    icon: SizedBox.shrink(), // 使用空的 SizedBox 作为图标
                    label: '作品',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox.shrink(),
                    label: '私密',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox.shrink(),
                    // icon: Icon(Icons.favorite),
                    label: '喜欢',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox.shrink(),
                    // icon: Icon(Icons.thumb_up),
                    label: '赞赏',
                  ),
                ],
              ),
            ),
            //
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: [
                  WorkPage(
                    token: widget.token,
                    nickname: widget.nickname,
                    username: widget.username,
                  ), // 作品页面
                  PrivatePage(
                    token: widget.token,
                    nickname: widget.nickname,
                    username: widget.username,
                  ), // 私密页面
                  LikePage(
                    token: widget.token,
                    nickname: widget.nickname,
                    username: widget.username,
                  ), // 喜欢页面
                  PraisePage(
                    token: widget.token,
                    nickname: widget.nickname,
                    username: widget.username,
                  ), // 赞赏页面
                ],
              ),
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
}
