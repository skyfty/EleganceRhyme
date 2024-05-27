import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:untitled/Home/HomePage/PdfView.dart';
import 'package:untitled/Home/void.dart';
import 'package:untitled/Global/Api.dart'; //APi

import 'package:untitled/Global/themeColors.dart'; //颜色

class Routed extends StatefulWidget {
  final String token;
  final String nickname;
  final List<String> items;
  final List<String> book_name;
  final double viewportFraction;
  final String username;

  Routed({
    required this.token,
    required this.nickname,
    required this.items,
    required this.book_name,
    this.viewportFraction = 0.8,
    required this.username,
  });

  @override
  _RoutedState createState() => _RoutedState();
}

class _RoutedState extends State<Routed> {
  int selectedImageIndex = 0;

  Future<void> fetchBookData(String bookName) async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/HomePage/eleganceBook.php',
    );
    final response = await http.post(
      url,
      body: {
        'book_name': bookName,
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
            book_name: bookName,
            nickname: widget.nickname,
            username: widget.username,
          ),
        ),
      );
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      color: ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                fetchBookData(widget.book_name[selectedImageIndex]);
              },
              child: PageView.builder(
                itemCount: widget.items.length,
                onPageChanged: (index) {
                  setState(() {
                    selectedImageIndex = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder<void>(
                    future: _precacheImage(
                      NetworkImage(widget.items[index] as String),
                      context,
                    ),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Container();
                      } else {
                        try {
                          return Container(
                            child: Image.network(
                              widget.items[index] as String,

                              fit: BoxFit.contain, // 调整图片以覆盖整个容器
                            ),
                          );
                        } catch (e) {
                          return Container();
                        }
                      }
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.items.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(
                  selectedImageIndex == index
                      ? Icons.commit
                      : Icons.horizontal_rule,
                  size: 16.0,
                  color:
                      selectedImageIndex == index ? Colors.blue : Colors.grey,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _precacheImage(
      ImageProvider provider, BuildContext context) async {
    try {
      await precacheImage(provider, context);
    } catch (e) {
      print('图片预缓存异常: $e');
    }
  }
}

//推荐
class CarouselItem {
  final Widget image;
  final String book_name;
  final String title;

  CarouselItem(
      {required this.image, required this.book_name, required this.title});
}

class CarouselSlider extends StatefulWidget {
  final Color color;
  final List<CarouselItem> book_name;
  final String token;
  final String nickname;

  final String username;

  CarouselSlider(
      {required this.color,
      required this.nickname,
      required this.token,
      required this.book_name,
      required this.username});

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: widget.book_name.length,
        itemBuilder: (context, index) {
          final item = widget.book_name[index];
          return GestureDetector(
            onTap: () {
              fetchBookDatas(
                context: context,
                bookName: item.book_name,
                token: widget.token,
                nickname: widget.nickname,
                username: widget.username,
              );
            },
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.height / 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // AnimatedContainer(
                      //   duration: Duration(milliseconds: 300),
                      //
                      //   width: MediaQuery.of(context).size.width / 4,
                      //
                      //   child: item.image,
                      // ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width / 4,
                        child: AspectRatio(
                          aspectRatio: 468 / 600,
                          child: ClipRect(
                            child: item.image,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
