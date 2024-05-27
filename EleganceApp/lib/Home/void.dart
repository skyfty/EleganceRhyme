import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Home/HomePage/PdfView.dart';
import 'package:untitled/Global/Api.dart'; //api

Future<void> fetchBookDatas({
  required BuildContext context,
  required String bookName,
  required String token,
  required String nickname,
  required String username,
}) async {
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
          token: token,
          book_name: bookName,
          nickname: nickname,
          username: username,
        ),
      ),
    );
  } else {
    Map<String, dynamic> responseData = json.decode(response.body);
    Fluttertoast.showToast(msg: '网络错误');
  }
}
