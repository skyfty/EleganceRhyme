// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:untitled/Global/Api.dart'; //api
//
// class BookClass extends StatefulWidget {
//   @override
//   _BookClassState createState() => _BookClassState();
// }
//
// class _BookClassState extends State<BookClass> {
//   List<dynamic> data = []; // 存储接口返回的数据
//   List<String> uniqueClasses = []; // 存储唯一的分类值
//   String selectedClass = ''; // 选择的分类值
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     final url = Uri.parse(
//         'http://${apiVar.serverIp}/EleganceApi/eleganceApp/hompage/showList.php');
//
//     final response = await http.post(url, body: {});
//
//     if (response.statusCode == 200) {
//       final dynamic jsonData = json.decode(response.body);
//       final List<dynamic> data = jsonData;
//
//       List<String> classes =
//           data.map((item) => item['classes'].toString()).toList();
//       uniqueClasses = classes.toSet().toList();
//
//       setState(() {
//         this.data = data;
//         selectedClass = '全部'; // 默认选择全部
//       });
//     } else {
//       Fluttertoast.showToast(msg: '请检查网络');
//     }
//   }
//
//   List<dynamic> filterData() {
//     if (selectedClass == '全部') {
//       return data; // 不过滤数据
//     } else {
//       return data
//           .where((item) => item['classes'] == selectedClass)
//           .toList(); // 根据选择的分类值过滤数据
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<dynamic> filteredData = filterData();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('分类'),
//       ),
//       backgroundColor: Colors.grey[200],
//       body: Column(
//         children: [
//           Container(
//             color: Colors.white,
//             height: 50.0,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: uniqueClasses.length + 1, // 加上全部选项
//               itemBuilder: (context, index) {
//                 if (index == 0) {
//                   // 全部选项
//                   return TextButton(
//                     onPressed: () {
//                       setState(() {
//                         selectedClass = '全部';
//                       });
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                         selectedClass == '全部' ? Colors.blue : Colors.white,
//                       ),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0.0),
//                         ),
//                       ),
//                     ),
//                     child: Text(
//                       '全部',
//                       style: TextStyle(
//                         color:
//                             selectedClass == '全部' ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   );
//                 }
//                 final className = uniqueClasses[index - 1];
//
//                 return TextButton(
//                   onPressed: () {
//                     setState(() {
//                       selectedClass = className;
//                     });
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(
//                       selectedClass == className ? Colors.blue : Colors.white,
//                     ),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(0.0),
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     className,
//                     style: TextStyle(
//                       color: selectedClass == className
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 2, // 每行显示两个项目
//               childAspectRatio: 0.7, // 调整项目宽高比
//               padding: EdgeInsets.all(8.0),
//               children: filteredData.map((item) {
//                 return Card(
//                   color: Colors.white,
//                   child: GridTile(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 20),
//                           child: SizedBox(
//                             width: MediaQuery.of(context).size.width / 2.8,
//                             child: Image.network(
//                                 'http://192.168.33.226:100${item['book_image']}'),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             item['book_name'],
//                             textAlign: TextAlign.left, // 将文本内容靠左对齐显示
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
