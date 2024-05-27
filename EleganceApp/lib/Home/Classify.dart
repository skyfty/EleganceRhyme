import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/Home/HomePage/EleganceBook.dart';
import 'package:untitled/Home/HomePage/classes/bookClass/bookClass.dart';
import 'package:untitled/Home/HomePage/PdfView.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Global/Api.dart'; //API接口
import 'package:untitled/Global/Global.dart';

import 'package:untitled/Global/themeColors.dart';

class Classify extends StatelessWidget {
  final String token;
  final String nickname;
  final String username;

  Classify({
    required this.token,
    required this.nickname,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> buttons = [
      {
        'icon': Icons.window,
        'text': '分类',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookClass(
                token: token,
                nickname: nickname,
                username: username,
              ),
            ),
          );
        },
      },
      {
        'icon': Icons.format_list_numbered,
        'text': '榜单',
        'onPressed': () {
          Fluttertoast.showToast(msg: '该功能雅韵系统暂未开放');
        },
      },
      {
        'icon': Icons.badge,
        'text': '会员',
        'onPressed': () {
          Fluttertoast.showToast(msg: '该功能雅韵系统暂未开放');
        },
      },
      {
        'icon': Icons.bookmarks_outlined,
        'text': '收藏',
        'onPressed': () {
          Fluttertoast.showToast(msg: '该功能雅韵系统暂未开放');
        },
      },
      {
        'icon': Icons.new_releases,
        'text': '新书',
        'onPressed': () {
          Fluttertoast.showToast(msg: '该功能雅韵系统暂未开放');
        },
      },
      {
        'icon': Icons.category,
        'text': '书单',
        'onPressed': () {
          Fluttertoast.showToast(msg: '该功能雅韵系统暂未开放');
        },
      },
    ];

    return Container(
      color: ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
      height: MediaQuery.of(context).size.height / 17,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: buttons.map((button) {
                      return GestureDetector(
                        onTap: button['onPressed'],
                        child: Container(
                          width: MediaQuery.of(context).size.width /6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                button['icon'],
                                color: ThemeManager.themes[colorsID.colors].IndexTopColor,
                                size: 18,
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height / 200,),
                              Text(
                                button['text'],
                                style: TextStyle(
                                  color:ThemeManager.themes[colorsID.colors].IndexTopColor,
                                  fontSize: 14
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // ... 继续添加其他行的代码
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class GoodsCardFlip extends StatefulWidget {
  const GoodsCardFlip(
      {super.key,

      required this.token,
      required this.nickname,
      required this.username});
  final String token;
  final String nickname;

  final String username;

  @override
  State<GoodsCardFlip> createState() => _GoodsCardFlipState();
}

class _GoodsCardFlipState extends State<GoodsCardFlip>
    with TickerProviderStateMixin {


  Future<void> ChangeStart() async {
    //需要
    final url = Uri.parse(
        'http://${apiVar.serverIp}/EleganceApi/eleganceApp/hompage/HomeChange.php');
    final response = await http.post(url, body: {});

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      setState(() {
        HomeChange.book_name1 = jsonData[0]['book_name'];
        HomeChange.book_image1 = jsonData[0]['book_image'];
        HomeChange.introduce1 = jsonData[0]['introduce'];
        HomeChange.book_name2 = jsonData[1]['book_name'];
        HomeChange.book_image2 = jsonData[1]['book_image'];
        HomeChange.introduce2 = jsonData[1]['introduce'];
      });

    } else {
      Fluttertoast.showToast(msg: '请检查网络');
    }
  }


  late AnimationController _animationController;

  // 翻转动画
  late Animation<double> _rotateAnimation;

  late AnimationStatus _lastStatus = AnimationStatus.dismissed;

  Timer? _globalFlipTimer;

  // 定义一个翻转从左往右，为false，如果为true，则从右往左开始翻转
  bool _flipReversal = false;
  int _flipDelay = 0; // 从左向右延迟翻转时间
  int _flipReversalDelay = 0; // 从右向左延迟翻转时间
  bool _isSetFlipDelay = false;

  bool _isDisposed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChangeStart();
    _isDisposed = false;

    _flipReversal = false;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    //使用弹性曲线
    _rotateAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _rotateAnimation = Tween(begin: 0.0, end: pi).animate(_rotateAnimation);

    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _animationController.addStatusListener((status) {
      if (status == _lastStatus) return;
      _lastStatus = status;
    });

    // 横屏的全部翻转到价值的控制定时器
    _globalFlipTimer = new Timer.periodic(new Duration(seconds: 15), (timer) {
      // 整体翻转动画
      flipCards();
    });
  }

  void timerDispose() {
    _globalFlipTimer?.cancel();
    _globalFlipTimer = null;
  }

  void animationDispose() {
    _animationController.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationDispose();
    timerDispose();
    super.dispose();
    _isDisposed = true;
  }

  void switchCard() {}

  @override
  Widget build(BuildContext context) {
    return buildGlobal();
  }

  Matrix4 _buildTransform() {
    final matrix = Matrix4.identity()..rotateY(_rotateAnimation.value);
    return matrix;
  }

  Widget buildGlobal() {
    return Column(
      children: [
Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Container(
      child: Padding(
        padding:
        EdgeInsets.only(left: 5.0, ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '每日书单',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ThemeManager.themes[colorsID.colors].IndexTitleColor,
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: Container(),
    ),
    Padding(
      padding: EdgeInsets.only(right: 24),
      child: InkWell(
        onTap: () {
          cardFlip(_flipReversal);
        },
        child: Container(

          width: 100,
          height: 30,
          decoration: BoxDecoration(
          // color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
          child: Center(
            child: Text(
              '换一批',
              style: TextStyle(color: ThemeManager.themes[colorsID.colors].IndexTitleColor, fontSize: 14),
            ),
          ),
        ),
      ),
    ),

  ],
),

       Padding(
         padding: EdgeInsets.only(left: 15),
       child:  Container(

         height: MediaQuery.of(context).size.height/5,
         alignment: Alignment.center,

         child: ClipRRect(
           borderRadius: BorderRadius.all(Radius.circular(13.0)),
           child: Transform(
             transform: _buildTransform(),
             alignment: Alignment.center,
             child: IndexedStack(
               alignment: Alignment.center,
               children: <Widget>[
                 buildFront(),
                 buildBack(),
               ],
               index: _rotateAnimation.value < pi / 2.0 ? 0 : 1,
             ),
           ),
         ),
       ),
       ),

      ],
    );
  }

  Widget buildFront() {
    return GoodsImageCard(

      token: widget.token,
      nickname: widget.nickname,
      username: widget.username,
    );
  }

  Widget buildBack() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: GoodsPriceCard(

        token: widget.token,
        nickname: widget.nickname,
        username: widget.username,
      ),
    );
  }

// 处理定时器
  void flipCards() {
    int delay = 0;
    if (_isSetFlipDelay == false) {
      // 如果从右向左，翻转时，则卡片在右侧的delay小于卡片在左侧的delay
      // 每次间隔的翻转延迟时间，100毫秒
      double perDelay = 100000.0;
      _flipDelay = delay;
      // 如果从右向左，翻转时，则卡片在右侧的delay小于卡片在左侧的delay
      int reversalDelay = 100;
      _flipReversalDelay = reversalDelay;
    } else {
      if (_flipReversal) {
        // 如果从右向左，翻转时，则卡片在右侧的delay小于卡片在左侧的delay
        delay = _flipReversalDelay;
      } else {
        delay = _flipDelay;
      }
    }

    _isSetFlipDelay = true;

    Future.delayed(Duration(milliseconds: delay), () {
      // cardFlip(_flipReversal);
    });
  }

  // 翻转动画
  void cardFlip(bool reverse) {
    if (_isDisposed == true) {
      return;
    }

    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    _flipReversal = !_flipReversal;

    if (_flipReversal == true) {
      Future.delayed(Duration(seconds: 5), () {
        flipCards();
      });
    }
  }
}

class GoodsImageCard extends StatefulWidget {
  const GoodsImageCard(
      {super.key,

      required this.token,
      required this.nickname,
      required this.username});

  final String token;
  final String nickname;
  final String username;
  @override
  _GoodsImageCardState createState() => _GoodsImageCardState();
}

class _GoodsImageCardState extends State<GoodsImageCard> {
  Future<void> fetchBookData(book_name) async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/HomePage/eleganceBook.php',
    );
    final response = await http.post(
      url,
      body: {
        'book_name': book_name,
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFS(
            path: responseData[0]['ancientpoetry'],
            dynasty:responseData[0]['dynasty'],
            author:responseData[0]['author'],
            sound_file: responseData[0]['sound_file'],
            token: widget.token,
            book_name: book_name,
            nickname: widget.nickname,
            username: widget.username,
          ), // 替换为您要跳转的页面
        ),
      );
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fetchBookData('${HomeChange.book_name1}');
      },
      child: Container(

        width: MediaQuery.of(context).size.width,
height: MediaQuery.of(context).size.height/5,
        child: Column(
          children: [

            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3.2,
                  child: AspectRatio(
                    aspectRatio: 468 / 600,
                    child: ClipRect(
                      child: Image.network(
                        'http://${apiVar.serverIp}/FaElegance/public${HomeChange.book_image1}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '《${HomeChange.book_name1}》',
                            style: TextStyle(fontSize: 16,color: ThemeManager.themes[colorsID.colors].IndexTitleColor,),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '李白',
                            style: TextStyle(fontSize: 16,color: ThemeManager.themes[colorsID.colors].IndexTitleColor,),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${HomeChange.introduce1.substring(0, 70)}...',
                            style: TextStyle(
                              fontSize: 14,
                              color: ThemeManager.themes[colorsID.colors].IndexTitleColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GoodsPriceCard extends StatefulWidget {
  const GoodsPriceCard(
      {super.key,

      required this.token,
      required this.nickname,
      required this.username});

  final String token;
  final String nickname;
  final String username;
  @override
  _GoodsPriceCardState createState() => _GoodsPriceCardState();
}

class _GoodsPriceCardState extends State<GoodsPriceCard> {
  Future<void> fetchBookData(book_name) async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/HomePage/eleganceBook.php',
    );
    final response = await http.post(
      url,
      body: {
        'book_name': book_name,
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFS(
            path: responseData[0]['ancientpoetry'],
            dynasty:responseData[0]['dynasty'],
            author:responseData[0]['author'],
            sound_file: responseData[0]['sound_file'],
            token: widget.token,
            book_name: book_name,
            nickname: widget.nickname,
            username: widget.username,
          ), // 替换为您要跳转的页面
        ),
      );
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fetchBookData('${HomeChange.book_name2}');
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [

                Container(
                  width:  MediaQuery.of(context).size.width/3.2,
                  // height: 100,
                  child: Image.network(
                      'http://${apiVar.serverIp}/FaElegance/public${HomeChange.book_image2}',
                    fit: BoxFit.fill,
                  ),
                ),

                SizedBox(width: 10,), // 可以调整图片和文字之间的间距
           Expanded(child:      Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     '《${HomeChange.book_name2}》',
                     style: TextStyle(fontSize: 16,
                     color: ThemeManager.themes[colorsID.colors].IndexTitleColor,
                     ),
                   ),
                 ],
               ),

               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     '    白居易  ',
                     style: TextStyle(fontSize: 16,
                     color: ThemeManager.themes[colorsID.colors].IndexTitleColor,
                     ),
                   ),
                 ],
               ),

               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     '   ${HomeChange.introduce2.substring(0, 70)}',

                     style: TextStyle(fontSize: 14,color: ThemeManager.themes[colorsID.colors].IndexTitleColor,),
                     maxLines: null,
                   ),
                 ],
               ),
             ],
           ),),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
