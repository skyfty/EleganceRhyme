import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:http/http.dart' as http;
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

//图标
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:untitled/Global/Api.dart'; //api
import 'package:untitled/Global/themeColors.dart'; //颜色
class Views extends StatefulWidget {
  final String? path; //古诗文件地址
  final String? dynasty;//朝代
  final String? author;//作者
  final String? sound_file; //音频文件地址
  final String? token;
  final String? book_name; //古诗名
  final String? nickname;
  final String? username;
final String? user;
  const Views(
      {Key? key,
      this.path,
        this.dynasty,
        this.author,
      this.sound_file,
      this.book_name,
      this.token,
      this.nickname,
      this.username,required this.user})
      : super(key: key);
  @override
  _ViewsState createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  Duration currentDuration = Duration.zero;

  int? currentPage = 0;
  //喜欢
  bool isLiked = false; //是否点赞
  int likeCount = 0; //爱心数量
  String likes = ''; //爱心数量
  int flowerCount = 0; //花的数量
  String peopleImage = ''; //用户头像
  String limits = '';
  String soundusername = ''; //录音
  String sound_file = '';
  @override
  void initState() {
    super.initState();

    PageStart();

    openTheRecorder().then((value) {
      //播放权限
      setState(() {});
    });
  }

  //初始页面获取
  Future<void> PageStart() async {
    final url = Uri.parse(
        'http://${apiVar.serverIp}/EleganceApi/eleganceApp/myPage/my/view/showList.php');
    final response = await http.post(url, body: {
      'username': '${widget.username}',
      'book_name': '${widget.book_name}',
      'user': '${widget.user}',
    });

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
print(jsonData);
      setState(() {
        // soundusername = jsonData['username'];
        isLiked = jsonData['likess'] == 'true' ? true : false;
        likeCount = int.parse(jsonData['isLikeNum']);
        likes = formatLikes(likeCount);
        flowerCount = int.parse(jsonData['flowerNum']);
        peopleImage = jsonData['peopleimage'];
        limits = jsonData['limits'];

        sound_file = jsonData['sound_file'];
      });
    } else {
      Fluttertoast.showToast(msg: '请检查网络');
    }
  }

  Future<void> toggleLike() async {
    if (isLiked) {
      likeCount--;
      likes = formatLikes(likeCount);
      var url = Uri.http(
        '${apiVar.serverIp}',
        '/EleganceApi/eleganceApp/hompage/HomePage/likeSound/isLikeSound.php',
      );
      final response = await http.post(
        url,
        body: {
          'soundNickname': widget.username,
          'book_name': widget.book_name,
          'nickname': widget.username,
          'like': (!isLiked).toString(),
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
      } else {
        Map<String, dynamic> responseData = json.decode(response.body);
        Fluttertoast.showToast(msg: '网络错误');
      }
    } else {
      likeCount++;
      likes = formatLikes(likeCount);
      var url = Uri.http(
        '${apiVar.serverIp}',
        '/EleganceApi/eleganceApp/hompage/HomePage/likeSound/LikeSound.php',
      );
      final response = await http.post(
        url,
        body: {
          'soundNickname': widget.username,
          'book_name': widget.book_name,
          'nickname': widget.username,
          'like': (!isLiked).toString(),
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
      } else {
        Map<String, dynamic> responseData = json.decode(response.body);
        Fluttertoast.showToast(msg: '网络错误');
      }
    }

    setState(() {
      isLiked = !isLiked;
    });
  }
  //花

  void togFlower() {
    setState(() {
      flowerCount++;
    });
  }

//权限
  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
  }

  //不喜欢音频
  Future<void> isLikeSound({required String soundNickname}) async {
    //
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/HomePage/likeSound/isLikeSound.php',
    );
    final response = await http.post(
      url,
      body: {
        'soundNickname': soundNickname,
        'book_name': widget.book_name,
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  //格式化人数
  String formatLikes(int likes) {
    if (likes < 10000) {
      // 如果喜欢人数小于1000，则直接返回原始值
      return likes.toString();
    } else if (likes < 99999999) {
      // 如果喜欢人数大于等于10000，则将喜欢人数除以10000，并保留一位小数
      double likesW = likes / 10000;
      return '${likesW.toStringAsFixed(1)}万';
    } else {
      return '9999+万';
    }
  }
  //测试

  String _stripHtmlTags(String htmlString) {
    RegExp htmlRegExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(htmlRegExp, '').replaceAll('&nbsp;', ' ');
  }
  @override
  Widget build(BuildContext context) {
    // 测试
    String backendHtml = '${widget.path}';
    List<String> paragraphs = backendHtml.split('<p>');

    // 测试
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,//标题文字居中
        title: Text(
          "阅读",
          style: TextStyle(
            color: ThemeManager.themes[colorsID.colors].PdfTextColor,
          ),
        ),
        backgroundColor: ThemeManager.themes[colorsID.colors].PdfAppBarColor,
        iconTheme: IconThemeData(
          color: ThemeManager.themes[colorsID.colors].PdfTextColor, //返回箭头的颜色
        ),
      ),
      body: Stack(
        children: <Widget>[

          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 1.45,
              color: ThemeManager.themes[colorsID.colors].PdfBookColor,
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.book_name}',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      '作者【${widget.author}】  朝代【${widget.dynasty}】',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15),
                  Column(
                    children: paragraphs.map((paragraph) {
                      if (paragraph.trim().isEmpty) {
                        return SizedBox.shrink();
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              _stripHtmlTags(paragraph),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      }
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),


          Stack(
            children: <Widget>[
              //
              Positioned(
                top: MediaQuery.of(context).size.height / 2.7,
                left: MediaQuery.of(context).size.width / 1.3,
                child: Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: MediaQuery.of(context).size.width / 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(
                        'http://${apiVar.serverIp}/FaElegance/public${peopleImage}'), // 替换为你的头像图片的URL
                  ),
                ),
              ),
              //爱心
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                left: MediaQuery.of(context).size.width / 1.25,
                child: GestureDetector(
                  onTap: toggleLike,
                  child: Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: MediaQuery.of(context).size.width / 8,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 +
                    MediaQuery.of(context).size.width / 8,
                left: MediaQuery.of(context).size.width / 1.25,
                child: Container(
                  width: MediaQuery.of(context).size.width / 6,
                  alignment: Alignment.center,
                  child: Text(
                    likes,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //花
              Positioned(
                top: MediaQuery.of(context).size.height / 1.7,
                left: MediaQuery.of(context).size.width / 1.25,
                child: GestureDetector(
                  onTap: togFlower,
                  child: Icon(
                    MaterialCommunityIcons.flower_tulip_outline,
                    color: isLiked ? Colors.yellow : Colors.yellow,
                    size: MediaQuery.of(context).size.width / 8,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 1.7 +
                    MediaQuery.of(context).size.width / 8,
                left: MediaQuery.of(context).size.width / 1.25,
                child: Container(
                  width: MediaQuery.of(context).size.width / 8,
                  alignment: Alignment.center,
                  child: Text(
                    flowerCount.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //音频作品设置
              Positioned(
                top: MediaQuery.of(context).size.height / 1.6 +
                    MediaQuery.of(context).size.width / 8,
                left: MediaQuery.of(context).size.width / 1.25,
                child: Container(
                  width: MediaQuery.of(context).size.width / 8,
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      MaterialIcons.more_horiz, // 使用三个点图标
                    ),
                    onPressed: () {
                      _showSettings(
                        context,
                      );
                    },
                  ),
                ),
              ),
              //音频播放
              Positioned(
                top: MediaQuery.of(context).size.height / 1.45 +
                    MediaQuery.of(context).size.width / 8,
                left: MediaQuery.of(context).size.width / 1.32,
                child: GestureDetector(
                  child: Container(
                    width: 80.0, // 设置容器的宽度为200个逻辑像素
                    child: IconButton(
                      icon: Container(
                        width: 36.0,
                        height: 36.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black26, width: 2.0),
                        ),
                        child: Center(
                          child: isPlaying
                              ? Icon(Icons.pause_circle_filled,
                                  color: Colors.black)
                              : Icon(Icons.play_circle_fill,
                                  color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          _pauseRecording();
                        } else {
                          _playRecording(
                              'http://${apiVar.serverIp}/FaElegance/public${sound_file}');
                        }

                        setState(() {
                          isPlaying = !isPlaying;
                        });
                        setState(() {
                          aasff = !aasff;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final FlutterSoundPlayer _player = FlutterSoundPlayer();
// 声明一个变量来控制音频播放状态
  bool isPlaying = false;
  bool aasff = false;
  late String sound_path = ''; //音频路径
  //播放
  PlayerStatus _playerStatus = PlayerStatus.stopped;
  void _playRecording(String filePath) async {
    await _player.openAudioSession();

    if (_playerStatus == PlayerStatus.stopped) {
      await _player.startPlayer(
        fromURI: filePath,
        codec: Codec.pcm16WAV,
      );
    } else if (_playerStatus == PlayerStatus.paused) {
      await _player.resumePlayer();
    }

    setState(() {
      _playerStatus = PlayerStatus.playing;
    });
  }

  //暂停
  void _pauseRecording() async {
    if (_playerStatus == PlayerStatus.playing) {
      await _player.pausePlayer();
    }

    setState(() {
      _playerStatus = PlayerStatus.paused;
    });
  }

  //作品设置弹窗
  void _showSettings(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                // crossAxisAlignment: CrossAxisMapping.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '作品设置',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {},
                          ),
                          Text('转发'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {},
                          ),
                          Text('下载'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {},
                          ),
                          Text('删除'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _showSettingsBottomSheet(
                                  context, limits, '${widget.book_name}');
                            },
                          ),
                          Text('公开/私密'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<Uint8List> _fetchPdf() async {
    final response = await http
        .get(Uri.parse('http://${apiVar.serverIp}/FaElegance/public${widget.path!}'));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load PDF');
    }
  }

  //半屏弹窗
  void _showSettingsBottomSheet(
      BuildContext context, String limits, String book_name) {
    String _selectedOption = limits; // 0 for public, 1 for private
    String _book_name = book_name;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                // crossAxisAlignment: CrossAxisMapping.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '作品设置',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView(
                      children: [
                        RadioListTile(
                          value: '公开',
                          groupValue: _selectedOption,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedOption = value!;
                              if (_selectedOption == '公开') {
                                fetchDsd(_book_name);
                                Navigator.of(context).pop();
                              }
                            });
                          },
                          title: Text('公开 * 所有人可见'),
                          secondary: _selectedOption == '公开'
                              ? Icon(Icons.check)
                              : null,
                        ),
                        RadioListTile(
                          value: '私密',
                          groupValue: _selectedOption,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedOption = value!;
                              if (_selectedOption == '私密') {
                                // 执行 fetchData() 函数
                                fetchDatass(_book_name);
                                // 关闭弹窗
                                Navigator.of(context).pop();
                              }
                            });
                          },
                          title: Text('私密 * 仅自己可见'),
                          secondary: _selectedOption == '私密'
                              ? Icon(Icons.check)
                              : null,
                        ),
                        // Add more settings options as needed
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> fetchDatass(String book_name) async {
    // 执行获取数据的逻辑
    String _book_name = book_name;

    final url = Uri.parse(
        'http://${apiVar.serverIp}/EleganceApi/eleganceApp/myPage/my/eadit/eaditAvatar.php');
    final response = await http.post(url, body: {
      'username': '${widget.username}',
      'book_name': '${_book_name}',
      'limits': '私密',
    });

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
    } else {
      Fluttertoast.showToast(msg: '请检查网络');
    }
  }

  Future<void> fetchDsd(String book_name) async {
    // 执行获取数据的逻辑
    String _book_name = book_name;

    final url = Uri.parse(
        'http://${apiVar.serverIp}/EleganceApi/eleganceApp/myPage/my/eadit/eaditAvatar.php');
    final response = await http.post(url, body: {
      'username': '${widget.username}',
      'book_name': '${_book_name}',
      'limits': '公开',
    });

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
    } else {
      Fluttertoast.showToast(msg: '请检查网络');
    }
  }
}

enum PlayerStatus {
  //播放状态
  stopped,
  playing,
  paused,
}
