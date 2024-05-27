import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/Home/discover/ActivityPage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Home/discover/DiscoverData.dart';
import 'package:untitled/Home/discover/view/PdfView.dart';
import 'package:untitled/Global/Api.dart'; //api
import 'package:untitled/Global/themeColors.dart'; //颜色

class DiscoverPage extends StatefulWidget {
  final String username;
  final String token;

  DiscoverPage({required this.username, required this.token});

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool isScrolled = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              '发现',
              style: TextStyle(
                fontSize: 20,
                color: ThemeManager.themes[colorsID.colors].ClassText1Color,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [],
        ),
        backgroundColor:
            ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ActivityImage(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  EveryoneListen(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  EditPicks(),

                  // buildContainer('Container 2', Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(String text, Color color) {
    return Container(
      height: 200,
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  //活动
  Widget ActivityImage() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityPage(
              username: widget.username,
            ),
          ),
        );
      },
      child: Container(
        // height: MediaQuery.of(context).size.height / 5,
        // width: MediaQuery.of(context).size.width,
        child: Image.network(
          'http://${apiVar.serverIp}/FaElegance/public${ActivityVar.TopActivityLogin}',
          fit: BoxFit.contain, //图片填充方式
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Picks();
    if (!Discover.isFirstOpen) {
      EveryoneList(); // 第一次打开页面时执行
      Discover.isFirstOpen = true; // 设置标志位为true
    }
  }

//大家都在听

  Future<void> EveryoneList() async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/Discover/EveryoneListen.php',
    );
    final response = await http.post(
      url,
      body: {},
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      setState(() {
        Discover.rowModuleData = json.decode(response.body);

        if (Discover.rowModuleData.length < 3) {
          Discover.rowModuleData
              .addAll(Discover.rowModuleData); // 如果数据不足三个，复制一份数据以确保至少有三个元素
        }
      });
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  Widget EveryoneListen() {
    if (Discover.rowModuleData.isEmpty || Discover.rowModuleData.length == 0) {
      return Container();
    }
    Set<String> displayedBookNames = {}; // 用于存储已显示的book_name值
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      color: ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              left: MediaQuery.of(context).size.width / 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${Discover.name}',
                  style: TextStyle(
                    fontSize: 20,
                    color:
                        ThemeManager.themes[colorsID.colors].DiscoverTitleColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(), //禁止滚动
              itemCount: 3,
              itemBuilder: (context, index) {
                String bookName;
                int dataIndex = (Discover.startIndex + index) %
                    Discover.rowModuleData.length;
                var data = Discover.rowModuleData[dataIndex];
                // 检查当前book_name是否已经在已显示集合中
                while (displayedBookNames.contains(data['book_name'])) {
                  dataIndex = (dataIndex + 1) %
                      Discover.rowModuleData.length; // 获取下一组数据
                  data = Discover.rowModuleData[dataIndex];
                }
                bookName = data['book_name'];
                displayedBookNames.add(bookName); // 将book_name添加到已显示集合中
                return GestureDetector(
                  onTap: () {
                    // 处理点击事件的逻辑
                    // 在这里执行页面跳转操作
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiscoverViews(
                          user: '${widget.username}',
                          sound_file: '${data['sound_file']}',
                          token: '${widget.token}',
                          path: '${data['ancientpoetry']}',
                          author: '${data['author']}',
                          dynasty: '${data['dynasty']}',
                          book_name: '${data['book_name']}',
                          username: '${data['username']}',
                          nickname: '',
                        ),
                      ),
                    );
                  },
                  child: RowModule(
                      context,
                      '${Discover.startImage ?? ''}${data['book_image'] ?? ''}',
                      bookName,
                      data['username'],
                      int.parse(data['playNum']),
                      widget.username,
                      data['sound_file'],
                      data['ancientpoetry'],
                      data['author'],
                      data['dynasty'],
                      widget.token),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (Discover.rowModuleData.length > 0) {
                  Discover.startIndex =
                      (Discover.startIndex + 3) % Discover.rowModuleData.length;
                }
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 水平居中对齐
                children: [
                  // Icon(
                  //   Icons.refresh,
                  //   color: Colors.black.withOpacity(0.2),
                  // ),
                  SizedBox(width: MediaQuery.of(context).size.width / 80),
                  Text(
                    '换一批',
                    style: TextStyle(
                      color: ThemeManager
                          .themes[colorsID.colors].DiscoverTitleColor,
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

  //编辑精选

  Future<void> Picks() async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/Discover/editPicksList.php',
    );
    final response = await http.post(
      url,
      body: {},
    );
    if (response.statusCode == 200) {
      final List<dynamic> soundpick = json.decode(response.body);

      setState(() {
        EditPicksVar.soundname1 = soundpick[0]['sound_name'];
        EditPicksVar.soundname2 = soundpick[1]['sound_name'];
        EditPicksVar.soundname3 = soundpick[2]['sound_name'];

        EditPicksVar.bookname1 = soundpick[0]['book_name'];
        EditPicksVar.bookname2 = soundpick[1]['book_name'];
        EditPicksVar.bookname3 = soundpick[2]['book_name'];
        EditPicksVar.soundimage1 = soundpick[0]['book_image'];
        EditPicksVar.soundimage2 = soundpick[1]['book_image'];
        EditPicksVar.soundimage3 = soundpick[2]['book_image'];
        EditPicksVar.playNum1 = int.parse(soundpick[0]['play_Num']);
        EditPicksVar.playNum2 = int.parse(soundpick[1]['play_Num']);
        EditPicksVar.playNum3 = int.parse(soundpick[2]['play_Num']);
        EditPicksVar.ancientpoetry1 = soundpick[0]['ancientpoetry'];
        EditPicksVar.ancientpoetry2 = soundpick[1]['ancientpoetry'];
        EditPicksVar.ancientpoetry3 = soundpick[2]['ancientpoetry'];
        EditPicksVar.author1 = soundpick[0]['author'];
        EditPicksVar.author2 = soundpick[1]['author'];
        EditPicksVar.author3 = soundpick[2]['author'];
        EditPicksVar.dynasty1 = soundpick[0]['dynasty'];
        EditPicksVar.dynasty2 = soundpick[1]['dynasty'];
        EditPicksVar.dynasty3 = soundpick[2]['dynasty'];
        EditPicksVar.sound_file1 = soundpick[0]['sound_file'];
        EditPicksVar.sound_file2 = soundpick[1]['sound_file'];
        EditPicksVar.sound_file3 = soundpick[2]['sound_file'];
      });
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  Widget EditPicks() {
    return Container(
      height: MediaQuery.of(context).size.height / 1.6,
      color: ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              left: MediaQuery.of(context).size.width / 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${EditPicksVar.name}',
                  style: TextStyle(
                    fontSize: 20,
                    color:
                        ThemeManager.themes[colorsID.colors].DiscoverTitleColor,

                  ),
                ),
              ],
            ),
          ),
          RowModule(
              context,
              'http://${apiVar.serverIp}/FaElegance/public${EditPicksVar.soundimage1}',
              EditPicksVar.bookname1,
              EditPicksVar.soundname1,
              EditPicksVar.playNum1,
              widget.username,
              EditPicksVar.sound_file1,
              EditPicksVar.ancientpoetry1,
              EditPicksVar.author1,
              EditPicksVar.dynasty1,
              widget.token),
          RowModule(
              context,
              'http://${apiVar.serverIp}/FaElegance/public${EditPicksVar.soundimage2}',
              EditPicksVar.bookname2,
              EditPicksVar.soundname2,
              EditPicksVar.playNum2,
              widget.username,
              EditPicksVar.sound_file1,
              EditPicksVar.ancientpoetry2,
              EditPicksVar.author2,
              EditPicksVar.dynasty2,
              widget.token),
          RowModule(
              context,
              'http://${apiVar.serverIp}/FaElegance/public${EditPicksVar.soundimage3}',
              EditPicksVar.bookname3,
              EditPicksVar.soundname3,
              EditPicksVar.playNum3,
              widget.username,
              EditPicksVar.sound_file3,
              EditPicksVar.ancientpoetry3,
              EditPicksVar.author3,
              EditPicksVar.dynasty3,
              widget.token),
        ],
      ),
    );
  }
}

Widget RowModule(
    context,
    String? ImageUrl,
    String? book_name,
    String? sound_name,
    int? PlayNum,
    String? username,
    String? sound_file,
    String? ancientpoetry,
    String? author,
    String? dynasty,
    String? token) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiscoverViews(
            user: username,
            sound_file: sound_file,
            token: token,
            path: ancientpoetry,
            author: author,
            dynasty: dynasty,
            book_name: book_name,
            username: sound_name,
            nickname: '',
          ),
        ),
      );
    },
    child: Container(
        height: MediaQuery.of(context).size.height / 6.5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 7,
                    child: Image.network(
                      ImageUrl!,
                      fit: BoxFit.contain, //图片填充方式
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 25,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 7,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // 将交叉轴对齐方式设置为起始位置
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${sound_name}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeManager.themes[colorsID.colors]
                                      .DiscoverTitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${book_name}',
                              style: TextStyle(
                                fontSize: 22,
                                color: ThemeManager
                                    .themes[colorsID.colors].DiscoverTitleColor,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height / 18,
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                              size: 27,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '播放量：${PlayNum}',
                              style: TextStyle(
                                fontSize: 14,
                                color: ThemeManager
                                    .themes[colorsID.colors].DiscoverTitleColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            )
          ],
        )),
  );
}
