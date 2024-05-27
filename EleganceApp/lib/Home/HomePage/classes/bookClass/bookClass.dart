import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:untitled/Home/HomePage/PdfView.dart';
import 'package:untitled/Global/Api.dart'; //api
import 'package:untitled/Global/themeColors.dart';//颜色
class BookClass extends StatefulWidget {
  final String? token;
  final String? nickname;
  final String username;

  const BookClass({this.token, this.nickname, required this.username});

  @override
  _BookClassState createState() => _BookClassState();
}

class _BookClassState extends State<BookClass> {
  List<dynamic> data = []; // 存储接口返回的数据
  List<String> uniqueClasses = [
    '全部',
    '边塞',
    '豪放',
    '军旅',
    '婉约',

    '山水',
    '田园',
    '客家',
    '江南',
    '北方',
    '南方',
    '未知',
  ]; // 存储唯一的分类值
  String selectedClass = ''; // 选择的分类值

  @override
  void initState() {
    super.initState();
    fetchData();
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
        selectedClass = '全部'; // 默认选择全部
      });
    } else {
      Fluttertoast.showToast(msg: '请检查网络');
    }
  }

  List<dynamic> filterData() {
    if (selectedClass == '全部') {
      return data; // 不过滤数据
    } else {
      return data
          .where((item) => item['classes'] == selectedClass)
          .toList(); // 根据选择的分类值过滤数据
    }
  }

  List<Map<String, dynamic>> Iccons = [
    {
      'icon': Icons.apps,
    },
    {
      'icon': Icons.theater_comedy_outlined,
    },
    {
      'icon': Icons.local_fire_department,
    },
    {
      'icon': Icons.swap_calls,
    },
    {
      'icon': Icons.device_hub_sharp,
    },
    {
      'icon': Icons.ac_unit,
    },
    {
      'icon': Icons.ac_unit,
    },
    {
      'icon': Icons.ac_unit,
    },
    {
      'icon': Icons.ac_unit,
    },
    {
      'icon': Icons.ac_unit,
    },
    {
      'icon': Icons.ac_unit,
    },
    {
      'icon': Icons.ac_unit,
    },
    {
      'icon': Icons.ac_unit,
    },
    {
      'icon': Icons.ac_unit,
    },

  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredData = filterData();

    return Scaffold(
      backgroundColor:  ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
      appBar: AppBar(
        backgroundColor:  ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
        title: Text('分类',style: TextStyle(color:  ThemeManager.themes[colorsID.colors].IndexTitleColor,),),
        iconTheme: IconThemeData(
          color: ThemeManager.themes[colorsID.colors].IndexTitleColor,//返回箭头的颜色
        ),
      ),
      body: Column(
        children: [
          Container(
            color: ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
            height: 60.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: uniqueClasses.length,
              itemBuilder: (context, index) {
                final className = uniqueClasses[index];

                return TextButton(
                  onPressed: () {
                    setState(() {
                      selectedClass = className;
                    });
                  },

                  child: Column(
                    children: [
                      Icon(
                        Iccons[index]['icon'],
                        color: selectedClass == className
                            ? ThemeManager.themes[colorsID.colors].ClassSelectIconColor
                            : ThemeManager.themes[colorsID.colors].ClassIconColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        className,
                        style: TextStyle(
                          color: selectedClass == className
                              ? ThemeManager.themes[colorsID.colors].ClassSelectIconColor
                              : ThemeManager.themes[colorsID.colors].ClassIconColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // wifi_1_bar
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(widget.items.length, (index) {
          //     return Container(
          //       margin: EdgeInsets.symmetric(horizontal: 4.0),
          //       child: Icon(
          //         selectedImageIndex == index ?  Icons.commit : Icons.horizontal_rule ,
          //         size: 16.0,
          //         color: selectedImageIndex == index ? Colors.blue : Colors.grey,
          //       ),
          //     );
          //   }),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(uniqueClasses.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(
                  Icons.circle,
                  size: 12.0,
                  color: selectedClass == uniqueClasses[index] ? ThemeManager.themes[colorsID.colors].ClassSelectIconColor : ThemeManager.themes[colorsID.colors].ClassIconColor,
                ),
              );
            }),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];

                return InkWell(

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFS(
                          token: widget.token,
                          nickname: widget.nickname,
                          path: item['ancientpoetry'],
                          author: item['author'],
                          dynasty: item['dynasty'],
                          sound_file: item['sound_file'],
                          book_name: item['book_name'],
                          username: widget.username,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20,bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Image.network(
                              'http://${apiVar.serverIp}/FaElegance/public${item['book_image']}',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 16.0),
                         Container(
                           width: MediaQuery.of(context).size.width *1.8/ 4,
                           child:  Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               Text(
                                 item['book_name'],
                                 style: TextStyle(
                                   fontSize: 18,
                                   fontWeight: FontWeight.bold,
                                     color: ThemeManager.themes[colorsID.colors].ClassText1Color
                                 ),
                               ),
                               SizedBox(height: MediaQuery.of(context).size.height / 60,),

                               Text(
                                 '作者: ${item['author']}',
                                 style: TextStyle(fontSize: 14,color: ThemeManager.themes[colorsID.colors].ClassText1Color),
                               ),
                               SizedBox(height: MediaQuery.of(context).size.height / 60,),
                               Text('总播放量',style: TextStyle(color: ThemeManager.themes[colorsID.colors].ClassText1Color),),
                               // Text(
                               //   '出版日期: ${item['publish_date']}',
                               //   style: TextStyle(fontSize: 14),
                               // ),
                               SizedBox(height: MediaQuery.of(context).size.height / 20,),
                             ],
                           ),
                         ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.arrow_forward_ios,
                                color: ThemeManager.themes[colorsID.colors].ClassInIconColor,
                                size: 40,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
