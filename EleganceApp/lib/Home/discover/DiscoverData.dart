import 'package:untitled/Global/Api.dart';
class Discover {
  //大家都在听
  static String name = '大家都在听'; //模块标题
  static List<dynamic> rowModuleData = []; // 用于保存大家都在听返回的数据
  static bool isFirstOpen = false; // 标志位，默认为false，大家都在听数据请求
  static int startIndex = 0; // 当前显示的数据起始索引
  static String startImage = 'http://${apiVar.serverIp}/FaElegance/public'; //图片前缀
  static String bookPath = '';

  static String phone = '';
  static String vip = '';
  static String avatar = '';
  static String birthday = '';
  static int flowerNum = 0;
  static int likeNum = 0;
}

class EditPicksVar {
  static String name = '编辑精选'; //模块标题
  static String username = '';
  static String soundname1 = ''; //模块标题
  static String soundname2 = ''; //模块标题
  static String soundname3 = ''; //模块标题

  static String soundimage1 = ''; //模块标题
  static String soundimage2 = ''; //模块标题
  static String soundimage3 = ''; //模块标题
  static String soundNum1 = ''; //模块标题
  static String soundNum2 = ''; //模块标题
  static String soundNum3 = ''; //模块标题
  static String bookname1 = ''; //模块标题
  static String bookname2 = ''; //模块标题
  static String bookname3 = ''; //模块标题
  static int playNum1 = 0; //模块标题
  static int playNum2 = 0; //模块标题
  static int playNum3 = 0; //模块标题
  static String sound_file1 = '';
  static String sound_file2 = '';
  static String sound_file3 = '';
  static String ancientpoetry1 = '';
  static String ancientpoetry2 = '';
  static String ancientpoetry3 = '';
  static String author1 = '';
  static String author2 = '';
  static String author3 = '';
  static String dynasty1 = '';
  static String dynasty2 = '';
  static String dynasty3 = '';
}

class ActivityVar {
  static String TopActivityLogin = ''; //模块标题
  static String name = '编辑精选'; //模块标题
  static String soundname1 = ''; //模块标题
  static String soundname2 = ''; //模块标题
  static String soundname3 = ''; //模块标题

  static String soundimage1 = ''; //模块标题
  static String soundimage2 = ''; //模块标题
  static String soundimage3 = ''; //模块标题
  static String soundNum1 = ''; //模块标题
  static String soundNum2 = ''; //模块标题
  static String soundNum3 = ''; //模块标题
  static String bookname1 = ''; //模块标题
  static String bookname2 = ''; //模块标题
  static String bookname3 = ''; //模块标题
  static int playNum1 = 0; //模块标题
  static int playNum2 = 0; //模块标题
  static int playNum3 = 0; //模块标题

  static String activityText = '';
  static String activityParagraph = '';
  static String activityTitle = '';
  static String soundTitle = '';
  static String activityImage = '';
  static String activityIcon = '';
}
