import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/Home/HomePage/HomePage.dart'; //轮播图
import 'package:flutter/services.dart';

import 'package:untitled/Home/Classify.dart';
import 'package:untitled/Global/Global.dart';
import 'package:untitled/Home/var/HomeHot.dart'; //热门推荐变量
import 'package:untitled/Home/var/HomeLike.dart'; //猜你喜欢变量
import 'package:untitled/Global/Api.dart'; //api
import 'package:untitled/Global/themeColors.dart';
import 'package:untitled/Home/discover/DiscoverData.dart';
class HomePage extends StatefulWidget {
  String token = '';
  String nickname = '';
  String username = '';
  HomePage(
      {required this.token, required this.nickname, required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> data = []; // 存储接口返回的数据
  List<dynamic> filteredData = []; // 存储符合搜索条件的数据
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchData();
    Start();
    TopActivityLogin();
    hot();
    Like();
    initializeData();
  }

  Future<void> Start() async {
    //需要
    final url = Uri.parse(
        'http://${apiVar.serverIp}/EleganceApi/eleganceApp/myPage/my/Num.php');
    final response = await http.post(url, body: {'username': widget.username});

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);

      setState(() {
        Global.flowerNum = jsonData[0]['flowerNum'];
        Global.likeNum = jsonData[0]['isLikeNum'];
      });
    } else {
      Fluttertoast.showToast(msg: '请检查网络');
    }
  }

  Future<void> initializeData() async {
    await hometop();

    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://${apiVar.serverIp}/EleganceApi/eleganceApp/hompage/showList.php');

    final response = await http.post(url, body: {});
    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData;

      setState(() {
        this.data = data;
        filteredData = data;
      });
    } else {
      Fluttertoast.showToast(msg: '请检查网络');
    }
  }
  Future<void> TopActivityLogin() async {
    final url = Uri.parse(
        'http://${apiVar.serverIp}/EleganceApi/eleganceApp/Discover/TopActivityLogin.php');

    final response = await http.post(url, body: {});
    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);


      setState(() {
        ActivityVar.TopActivityLogin =jsonData[0]['loginImage'];
      });
    } else {
      Fluttertoast.showToast(msg: '请检查网络');
    }
  }

  void filterData(String query) {
    setState(() {
      filteredData = data
          .where((item) => item['book_name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

//hometop
  late String hometop1 = '';
  late String topname1 = '';
  late String hometop2 = '';
  late String topname2 = '';
  late String hometop3 = '';
  late String topname3 = '';
  late String hometop4 = '';
  late String topname4 = '';
  late String hometop5 = '';
  late String topname5 = '';

  Future<void> hometop() async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/hometop.php',
    );
    final response = await http.post(
      url,
      body: {},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      setState(() {
        hometop1 = responseData['data'][0]['book_image'];
        topname1 = responseData['data'][0]['bookname'];
        hometop2 = responseData['data'][1]['book_image'];
        topname2 = responseData['data'][1]['bookname'];
        hometop3 = responseData['data'][0]['book_image'];
        topname3 = responseData['data'][1]['bookname'];
        hometop4 = responseData['data'][0]['book_image'];
        topname4 = responseData['data'][1]['bookname'];
      });
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  //热门推荐
  Future<void> hot() async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/hot.php',
    );
    final response = await http.post(
      url,
      body: {},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      setState(() {
        HotVar.book_name1 = responseData[0]['book_name'];
        HotVar.book_name2 = responseData[1]['book_name'];
        HotVar.book_name3 = responseData[2]['book_name'];
        HotVar.book_name4 = responseData[3]['book_name'];
        HotVar.book_image1 = responseData[0]['book_image'];
        HotVar.book_image2 = responseData[1]['book_image'];
        HotVar.book_image3 = responseData[2]['book_image'];
        HotVar.book_image4 = responseData[3]['book_image'];
      });
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  //猜你喜欢
  Future<void> Like() async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/readlike.php',
    );
    final response = await http.post(
      url,
      body: {},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      setState(() {
        LikeVar.book_name1 = responseData[0]['book_name'];
        LikeVar.book_name2 = responseData[1]['book_name'];
        LikeVar.book_name3 = responseData[2]['book_name'];
        LikeVar.book_name4 = responseData[3]['book_name'];
        LikeVar.book_image1 = responseData[0]['book_image'];
        LikeVar.book_image2 = responseData[1]['book_image'];
        LikeVar.book_image3 = responseData[2]['book_image'];
        LikeVar.book_image4 = responseData[3]['book_image'];
      });
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
        backgroundColor:
            ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height * 1.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: inventorCustomSearchBox(
                          controller: searchController,
                          onChanged: (value) {
                            filterData(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  if (searchController.text.isEmpty) //全局搜索之前的首页

                    SingleChildScrollView(
                        child: Builder(builder: (BuildContext context) {
                      return Column(
                        children: <Widget>[
                          Classify(
                            token: '${widget.token}',
                            nickname: '${widget.nickname}',
                            username: widget.username,
                          ),
                          if (isLoading)
                            Routed(
                              token: '${widget.token}',
                              items: [
                                'http://${apiVar.serverIp}/FaElegance/public${hometop1}',
                                'http://${apiVar.serverIp}/FaElegance/public${hometop2}',
                                'http://${apiVar.serverIp}/FaElegance/public${hometop3}',
                                'http://${apiVar.serverIp}/FaElegance/public${hometop4}',
                                'http://${apiVar.serverIp}/FaElegance/public${hometop4}',
                              ],
                              book_name: [
                                '${topname1}',
                                '${topname2}',
                                '${topname3}',
                                '${topname4}',
                                '${topname4}',
                              ],
                              nickname: '${widget.nickname}',
                              username: widget.username,
                            ),
                          Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: GoodsCardFlip(
                              token: widget.token,
                              nickname: widget.nickname,
                              username: widget.username,
                            ),
                          ),
                          if (isLoading)
                            Container(
                              // color: Colors.grey[200],
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 5.0, top: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '热门推荐',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeManager
                                                .themes[colorsID.colors]
                                                .IndexTitleColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 0),
                                    child: CarouselSlider(
                                      book_name: [
                                        CarouselItem(
                                            image: Image.network(
                                                'http://${apiVar.serverIp}/FaElegance/public${HotVar.book_image1}'),
                                            book_name: '${HotVar.book_name1}',
                                            title: '${HotVar.book_name1}'),
                                        CarouselItem(
                                            image: Image.network(
                                                'http://${apiVar.serverIp}/FaElegance/public${HotVar.book_image2}'),
                                            book_name: '${HotVar.book_name2}',
                                            title: '${HotVar.book_name2}'),
                                        CarouselItem(
                                            image: Image.network(
                                                'http://${apiVar.serverIp}/FaElegance/public${HotVar.book_image3}'),
                                            book_name: '${HotVar.book_name3}',
                                            title: '${HotVar.book_name3}'),
                                        CarouselItem(
                                            image: Image.network(
                                                'http://${apiVar.serverIp}/FaElegance/public${HotVar.book_image4}'),
                                            book_name: '${HotVar.book_name4}',
                                            title: '${HotVar.book_name4}'),

                                        // Add more items as needed
                                      ],
                                      color: Colors.white,
                                      nickname: '${widget.nickname}',
                                      token:
                                          '${widget.token}', // 设置每个图片小部件的缩放比例
                                      username: widget.username,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (isLoading)
                            Container(
                              color: ThemeManager
                                  .themes[colorsID.colors].IndexBackgroundColor,
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 5.0, top: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '猜你喜欢',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeManager
                                                .themes[colorsID.colors]
                                                .IndexTitleColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 0),
                                    child: CarouselSlider(
                                      book_name: [
                                        CarouselItem(
                                            image: Image.network(
                                                'http://${apiVar.serverIp}/FaElegance/public${LikeVar.book_image1}'),
                                            book_name: '${LikeVar.book_name1}',
                                            title: '${LikeVar.book_name1}'),
                                        CarouselItem(
                                            image: Image.network(
                                                'http://${apiVar.serverIp}/FaElegance/public${LikeVar.book_image2}'),
                                            book_name: '${LikeVar.book_name2}',
                                            title: '${LikeVar.book_name2}'),
                                        CarouselItem(
                                            image: Image.network(
                                                'http://${apiVar.serverIp}/FaElegance/public${LikeVar.book_image3}'),
                                            book_name: '${LikeVar.book_name3}',
                                            title: '${LikeVar.book_name3}'),
                                        CarouselItem(
                                            image: Image.network(
                                                'http://${apiVar.serverIp}/FaElegance/public${LikeVar.book_image4}'),
                                            book_name: '${LikeVar.book_name4}',
                                            title: '${LikeVar.book_name4}'),

                                        // Add more items as needed
                                      ],

                                      // 设置轮播图的高度

                                      nickname: '${widget.nickname}',
                                      token: '${widget.token}',
                                      color: Colors.black12, // 设置每个图片小部件的缩放比例
                                      username: widget.username,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      );
                    })),
                  if (searchController.text.isNotEmpty &&
                      filteredData.isEmpty) //搜索不到结果
                    Text('暂无搜索内容'),
                  if (searchController.text.isNotEmpty) // 全局搜索
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/bookShow',
                                arguments: {
                                  'token': widget.token,
                                  'book_name': filteredData[index]['book_name'],
                                  'nickname': widget.nickname,
                                  'username': widget.username
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                elevation: 4,
                                color: Colors.blueGrey[100],
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.blueAccent,
                                        Colors.greenAccent
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          filteredData[index]['book_name'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [

                                            Text(
                                              '作者: ${filteredData[index]['author']}',
                                              // Replace 'status' with the correct field
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              )),
        ),
      ),
    );
  }

  Widget MoreItem() {
    return GestureDetector(
      onTap: () {
        // 在这里添加 "查看更多" 的点击事件处理逻辑
      },
      child: Container(
        // 这里设置 "查看更多" 的外观样式，例如背景颜色、边框等
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Center(
          child: Text(
            '查看更多',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

//搜索框
class inventorCustomSearchBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const inventorCustomSearchBox({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0), //设置搜索框的位置
      child: Container(
        decoration: BoxDecoration(
          color: ThemeManager.themes[colorsID.colors].SearchBackgroundColor,
          borderRadius: BorderRadius.circular(10.0), //设置搜索框的圆角
          boxShadow: [
            BoxShadow(
              // color: Colors.grey.withOpacity(0.3), //设置搜索框的阴影
              color: ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
              spreadRadius: 2, //设置阴影的扩散程度
              blurRadius: 5, //设置阴影的模糊程度
              offset: Offset(0, 3), //设置阴影的偏移量
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: '输入要搜索的古诗名',
            hintStyle: TextStyle(
              color: ThemeManager.themes[colorsID.colors].SearchIconColor,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 14.0), //设置搜索框的内边距
            prefixIcon: Icon(
              Icons.search,
              color: ThemeManager.themes[colorsID.colors].SearchIconColor,
            ),
          ),
        ),
      ),
    );
  }
}
