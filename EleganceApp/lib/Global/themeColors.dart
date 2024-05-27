import 'dart:ui';
class AppTheme {
  //登录页面
  final Color TextColor;
  final Color TextDeadColor;
  final Color smsButton;
  final Color backgroundColor;
  final String loginLogo;
  final Color LoginButtonColor1;
  final Color LoginButtonColor2;
  final Color PrivacyIconColor;
  final Color InputColor;
  final String imagePath;
  //主页
  final Color IndexBackgroundColor;//所有页面背景颜色
  final Color IndexTopColor;//顶部分类、榜单
  final Color IndexTitleColor;
  final Color BottmTextColor;
  //发现
  final Color DiscoverTitleColor;
  //搜索框
  final Color SearchBackgroundColor;
  final Color SearchTextColor;
  final Color SearchIconColor;
  //分类
  final Color ClassIconColor;//顶部Icon
  final Color ClassSelectIconColor;
  final Color ClassText1Color;//文字1
  final Color ClassInIconColor;//进入阅读页面图标
  //我的
  final Color MyTextColor;
  final Color MyEditTextColor;
  final Color MyLogIconColor;
  //pdf
  final Color PdfAppBarColor;
  final Color PdfTextColor;
  final Color PdfBookColor;
  final Color PlayButtonColor;
  final Color PlayChoseButtonColor;
  final Color PlayButtonTextColor;

  AppTheme({
    //
    required this.TextColor,
    required this.TextDeadColor,
    required this.smsButton,
    required this.backgroundColor,
    required this.loginLogo,
    required this.LoginButtonColor1,
    required this.LoginButtonColor2,
    required this.PrivacyIconColor,
    required this.InputColor,
    required this.imagePath,
    //
    required this.IndexBackgroundColor,
    required this.IndexTopColor,
    required this.IndexTitleColor,
    required this.BottmTextColor,
    //
    required this.DiscoverTitleColor,
    //搜索框
    required this.SearchBackgroundColor,
    required this.SearchTextColor,
    required this.SearchIconColor,
    //分类
    required this.ClassIconColor,
    required this.ClassSelectIconColor,
    required this.ClassText1Color,
    required this.ClassInIconColor,
    //我的
    required this.MyTextColor,
    required this.MyEditTextColor,
    required this.MyLogIconColor,
    //PDF
    required this.PdfAppBarColor,
    required this.PdfTextColor,
    required this.PdfBookColor,
    required this.PlayButtonColor,
    required this.PlayChoseButtonColor,
    required this.PlayButtonTextColor,




  });
}
class ThemeManager {
  static List<AppTheme> themes = [
    AppTheme(
//
      TextColor: Color.fromRGBO(30, 30, 30, 1.0),//登录页亮色文字颜色0
      TextDeadColor:Color.fromRGBO(30, 30, 30, 1.0),//登录页暗色文字颜色0
      smsButton: Color.fromRGBO(190, 190, 205, 1.0),//登录页按钮背景颜色0
      backgroundColor: Color.fromRGBO(235, 235, 245, 1.0),//登录页背景底色0
      loginLogo :'assets/logo/Logo_1.png',//登录页logo 0
      LoginButtonColor1: Color.fromRGBO(173, 198,219, 1.0),
      LoginButtonColor2: Color.fromRGBO(50, 145, 240, 1.0),
      PrivacyIconColor: Color.fromRGBO(255, 152, 0, 1.0),
      InputColor: Color.fromRGBO(215, 215, 230, 1.0),
      imagePath: 'assets/images/image1.png',
      //
      IndexBackgroundColor: Color.fromRGBO(235, 235, 245, 1.0),
      IndexTopColor: Color.fromRGBO(50, 145, 240, 1.0),
      IndexTitleColor: Color.fromRGBO(30, 30, 30, 1.0),
      BottmTextColor: Color.fromRGBO(50, 50, 55, 1.0),
      //
      DiscoverTitleColor: Color.fromRGBO(30, 30, 30, 1.0),
      //搜索框
      SearchBackgroundColor: Color.fromRGBO(215, 215, 230, 1.0),
      SearchTextColor: Color.fromRGBO(60, 60, 66, 1.0),
      SearchIconColor:  Color.fromRGBO(60, 60, 66, 1.0),
      //分类
      ClassIconColor:Color.fromRGBO(30, 30, 30, 1.0),
      ClassSelectIconColor:Color.fromRGBO(50, 145, 240, 1.0),
      ClassText1Color: Color.fromRGBO(30, 30, 30, 1.0),
      ClassInIconColor: Color.fromRGBO(50, 145, 240, 1.0),

      //
      MyTextColor:Color.fromRGBO(30, 30, 30, 1.0),
      MyEditTextColor: Color.fromRGBO(50, 50, 55, 1.0),
      MyLogIconColor:Color.fromRGBO(50, 145, 240, 1.0),


      //pdf
      PdfAppBarColor: Color.fromRGBO(65, 70, 75, 1.0),
      PdfTextColor:  Color.fromRGBO(205, 215, 220, 1.0),
      PdfBookColor: Color.fromRGBO(235, 235, 245, 1.0),
      PlayButtonColor:Color.fromRGBO(235, 235, 245, 1.0),
      PlayChoseButtonColor:Color.fromRGBO(50, 145, 240, 1.0),
      PlayButtonTextColor: Color.fromRGBO(30, 30, 30, 1.0),
    ),
    AppTheme(
      TextColor: Color.fromRGBO(205, 215, 220, 1.0),//登录页亮文字颜色1
      TextDeadColor:Color.fromRGBO(60, 60, 66, 1.0),//登录页暗色文字颜色0
      smsButton: Color.fromRGBO(65, 70, 75, 1.0),//登录页按钮背景颜色1
      backgroundColor: Color.fromRGBO(30, 30, 35, 1.0),//登录页背景底色1
      loginLogo :'assets/logo/Logo_2.png',//登录页logo 1
      LoginButtonColor1: Color.fromRGBO(140, 93, 93, 1.0),//未选中状态
      LoginButtonColor2: Color.fromRGBO(152, 42, 42, 1.0),//选中状态
      PrivacyIconColor: Color.fromRGBO(0, 255, 0, 1.0),//隐私图标
      InputColor: Color.fromRGBO(32, 32, 38, 1.0),
      imagePath: 'assets/images/image2.png',
      //
      IndexBackgroundColor: Color.fromRGBO(30, 30, 35, 1.0),
      IndexTopColor: Color.fromRGBO(155, 42, 42, 1.0),
      IndexTitleColor: Color.fromRGBO(205, 215, 220, 1.0),
      BottmTextColor: Color.fromRGBO(50, 50, 55, 1.0),
      //
      DiscoverTitleColor: Color.fromRGBO(205, 215, 220, 1.0),
      //搜索框
      SearchBackgroundColor: Color.fromRGBO(215, 215, 230, 1.0),
      SearchTextColor: Color.fromRGBO(60, 60, 66, 1.0),
      SearchIconColor:  Color.fromRGBO(60, 60, 66, 1.0),

      //分类
      ClassIconColor: Color.fromRGBO(50, 50, 55, 1.0),
      ClassSelectIconColor: Color.fromRGBO(152, 42, 42, 1.0),
      ClassText1Color: Color.fromRGBO(205, 215, 220, 1.0),
      ClassInIconColor: Color.fromRGBO(205, 215, 220, 1.0),
      //
      MyTextColor: Color.fromRGBO(205, 215, 220, 1.0),
      MyEditTextColor: Color.fromRGBO(50, 50, 55, 1.0),
      MyLogIconColor:Color.fromRGBO(155, 42, 42, 1.0),
      //pdf
      PdfAppBarColor: Color.fromRGBO(30, 30, 35, 1.0),
      PdfTextColor:  Color.fromRGBO(205, 215, 220, 1.0),
      PdfBookColor: Color.fromRGBO(235, 235, 245, 1.0),
      PlayButtonColor:Color.fromRGBO(235, 235, 245, 1.0),
      PlayChoseButtonColor:Color.fromRGBO(155, 42, 42, 1.0),
      PlayButtonTextColor: Color.fromRGBO(30, 30, 30, 1.0),
    ),
    // 添加更多主题...
  ];

  // static AppTheme currentTheme = themes[0];
  //
  // static void switchTheme(int index) {
  //   if (index >= 0 && index < themes.length) {
  //     currentTheme = themes[index];
  //   }
  // }
}

class colorsID {//大家都在听
  static int colors = 0;//模块标题

}



// Container(
// color: ThemeManager.currentTheme.backgroundColor,
// child: Image.asset(ThemeManager.currentTheme.imagePath),
// ),