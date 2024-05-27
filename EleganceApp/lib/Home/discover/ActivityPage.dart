import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Home/discover/DiscoverData.dart';
import 'dart:convert';
import 'package:untitled/Global/Api.dart'; //api

import 'package:webview_flutter/webview_flutter.dart';
class ActivityPage extends StatefulWidget {
  final String username;

  ActivityPage({required this.username});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool isScrolled = false;
  @override
  void initState() {
    super.initState();
    Picks();
    PageStart();
  }

  Future<void> PageStart() async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/Discover/actibityList.php',
    );
    final response = await http.post(
      url,
      body: {},
    );
    if (response.statusCode == 200) {
      final List<dynamic> soundpick = json.decode(response.body);
print(soundpick);
      setState(() {
        ActivityVar.activityTitle = soundpick[0]['activityTitle'];
        ActivityVar.activityIcon = soundpick[0]['activityIcon'];
        ActivityVar.activityText = soundpick[0]['activityText'];
        ActivityVar.soundTitle = soundpick[0]['soundTitle'];
        ActivityVar.activityImage = soundpick[0]['activityImage'];
        ActivityVar.activityParagraph = soundpick[0]['activityParagraph'];
      });
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  String _stripHtmlTags(String htmlString) {
    RegExp htmlRegExp =
        RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(htmlRegExp, '');
  }
  String updateHtmlWithIpAddress(String htmlStr) {
    final regex = RegExp(r'<img src="(?!http)');
    return htmlStr.replaceAll(regex, '<img src="http://$_ipAddress/');
  }

  @override
  Widget build(BuildContext context) {
    String updatedHtml = updateHtmlWithIpAddress(htmlStr);
    return Scaffold(
      appBar: AppBar(
        title: Text('${ActivityVar.activityTitle}'),
      ),
      backgroundColor: Colors.white,
      body:  Column(
        children: [
          Expanded(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                if (updatedHtml.isNotEmpty) {
                  controller.loadHtmlString(updatedHtml);
                }
              },
            ),
          ),
          SizedBox(height: 16.0), // 添加一些间距
          Container(
            color: Colors.grey,
            height: 100, // 设置容器的高度
            child: Center(
              child: Text('这是一个添加在 WebView 下方的容器'),
            ),
          ),
        ],
      ),


    );
  }
  String _ipAddress = 'www.zlgccn.com/FaElegance/public'; // 替换成你的 IP 地址

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
  final String htmlStr = '''
<p style="text-align: center;"><span style="font-size: 36pt;"><strong>春天，万象更新，生机盎然，</strong></span></p>
<p style="text-align: center;"><span style="font-size: 36pt;"><strong> 是 一个属于开始与探索的季节。 </strong></span></p>
<p><span style="color: #2dc26b; font-size: 36pt;"><strong>恰逢世界读书日在这春光明媚之时， 让我们一起从一本高品质入门小书开始， 去开启一个新习惯，或探索一个新领域。</strong></span></p>
<p><span style="color: #2dc26b; font-size: 36pt;"><strong><img src="/uploads/20240517/8f96fc30dbfe89842a4988a0429fe9dd.png" alt="" width="100%" /></strong></span></p>
<h2><span style="color: #2dc26b; font-size: 36pt;"><strong> 小宇宙编辑部邀请饮食、心理、户外等 15 个领域的播客与你分享</strong></span></h2>
<h2><span style="color: #2dc26b; font-size: 36pt;"><strong> 47 本硬核与趣味兼具的入门小书。 没有厚重艰涩，抛开阅读压力，</strong></span></h2>
<h2><span style="color: #2dc26b; font-size: 36pt;"><strong>我们一起在这个春天轻松阅读，愉快焕新。 春天，万象更新，生</strong></span></h2>
<h2><span style="font-size: 36pt;"><span style="color: #2dc26b;"><strong>机</strong></span><span style="color: #2dc26b;"><strong>盎然， 是 一个属于开始与探索的季节。</strong></span></span></h2>
<p><span style="font-size: 36pt;">恰逢世界读书日在这春光明媚之时， 让我们一起从一本高品质入门小书开始， 去开启一个新习惯</span></p>
<p><span style="font-size: 36pt;">，或探索一个新领域。 小宇宙编辑部邀请饮食、心理、户外等 15 个领域的播客与你分享 47 本硬</span></p>
<p><span style="font-size: 36pt;">核与趣味兼具的入门小书。 没有厚重艰涩，抛开阅读压力，我们一起在这个春天轻松阅读，愉快焕新。</span></p>




''';

  Widget ActivityText() {
    String updatedHtml = updateHtmlWithIpAddress(htmlStr);
    String backendHtml = ActivityVar.activityText;
    List<String> paragraphs = backendHtml.split('<p>');
    String backendHtml2 = ActivityVar.activityParagraph;
    List<String> activityParagraph = backendHtml2.split('<p>');
    return Container(
        // height: MediaQuery.of(context).size.height / 1.23,
        color: Colors.white,
        child: Column(
          children: [




            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                if (updatedHtml.isNotEmpty) {
                  controller.loadHtmlString(updatedHtml);
                }
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width, // Set a specific width
              height: MediaQuery.of(context).size.height, // Set a specific height
              child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                if (updatedHtml.isNotEmpty) {
                  controller.loadHtmlString(updatedHtml);
                }
              },
            ),
            ),




            Container(
              width: MediaQuery.of(context).size.width, // Set a specific width
              height: MediaQuery.of(context).size.height, // Set a specific height
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController controller) {
                  if (updatedHtml.isNotEmpty) {
                    controller.loadHtmlString(updatedHtml);
                  }
                },
              ),
            ),

          ],
        ));
  }

  Future<void> Picks() async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/Discover/activityPageList.php',
    );
    final response = await http.post(
      url,
      body: {},
    );
    if (response.statusCode == 200) {
      final List<dynamic> soundpick = json.decode(response.body);
      print(soundpick);
      print(111223);
      print(soundpick[2]['sound_name']);
      setState(() {
        ActivityVar.soundname1 = soundpick[0]['sound_name'];
        ActivityVar.soundname2 = soundpick[1]['sound_name'];
        ActivityVar.soundname3 = soundpick[2]['sound_name'];

        ActivityVar.bookname1 = soundpick[0]['book_name'];
        ActivityVar.bookname2 = soundpick[1]['book_name'];
        ActivityVar.bookname3 = soundpick[2]['book_name'];
        ActivityVar.soundimage1 = soundpick[0]['book_image'];
        ActivityVar.soundimage2 = soundpick[1]['book_image'];
        ActivityVar.soundimage3 = soundpick[2]['book_image'];
        ActivityVar.playNum1 = int.parse(soundpick[0]['play_Num']);
        ActivityVar.playNum2 = int.parse(soundpick[1]['play_Num']);
        ActivityVar.playNum3 = int.parse(soundpick[2]['play_Num']);
      });
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  Widget ActivityPicks() {
    return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      color: Colors.white,
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
                  '${ActivityVar.soundTitle}',
                  style: TextStyle(
                    fontSize: 25,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: <Color>[
                          Colors.lightBlueAccent,
                          Colors.lightGreenAccent,
                        ],
                      ).createShader(
                          Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)), // 调整渐变区域大小
                  ),
                ),
              ],
            ),
          ),
          RowModule(
              context,
              'http://${apiVar.serverIp}/FaElegance/public${ActivityVar.soundimage1}',
              ActivityVar.bookname1,
              ActivityVar.soundname1,
              ActivityVar.playNum1),
          RowModule(
              context,
              'http://${apiVar.serverIp}/FaElegance/public${ActivityVar.soundimage2}',
              ActivityVar.bookname2,
              ActivityVar.soundname2,
              ActivityVar.playNum2),
          RowModule(
              context,
              'http://${apiVar.serverIp}/FaElegance/public${ActivityVar.soundimage2}',
              ActivityVar.bookname3,
              ActivityVar.soundname3,
              ActivityVar.playNum3),
        ],
      ),
    );
  }
}

Widget RowModule(context, String? ImageUrl, String? book_name,
    String? sound_name, int? PlayNum) {
  return Container(
    height: MediaQuery.of(context).size.height / 5.5,
    width: MediaQuery.of(context).size.width,
    child: Card(
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 20,
          top: MediaQuery.of(context).size.height / 100,
          bottom: MediaQuery.of(context).size.height / 100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.width / 4,
              child: Image.network(
                ImageUrl!,
                fit: BoxFit.fill, //图片填充方式
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 25,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 将交叉轴对齐方式设置为起始位置
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
                            color: Colors.black54,
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.play_arrow,
                        size: 18,
                        color: Colors.black26,
                      ),
                      Text(
                        '${PlayNum}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black26,
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
    ),
  );
}

class ArcText extends CustomPainter {
  final String text;
  final double startAngle;
  final double sweepAngle;
  final TextStyle textStyle;

  ArcText(this.text, this.startAngle, this.sweepAngle, this.textStyle);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..color = Colors.black;
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
    textPainter.paint(canvas, Offset(size.width / 2, size.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
