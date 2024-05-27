import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/Home/publugn/pdfView.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart'; //权限
//录音
import 'package:path_provider/path_provider.dart';
import 'package:untitled/Global/Api.dart'; //api
import 'package:untitled/Global/themeColors.dart'; //颜色

class VoiceRecording {
  //录音
  final String filePath;
  final String recordingUrl;

  VoiceRecording({required this.filePath, required this.recordingUrl});
}

enum PlayerStatus {
  //播放状态
  stopped,
  playing,
  paused,
}

class Audio {
  String name;
  String url;
  bool isLiked; //是否喜欢
  int isLikeNum; //喜欢人数
  int playNum; //播放人数
  int flowerNum; //花的数目

  Audio({
    required this.name,
    required this.url,
    required this.isLiked,
    required this.isLikeNum,
    required this.playNum,
    required this.flowerNum,
  });
}

class PDFS extends StatefulWidget {
  final String? path;
  final String? sound_file;
  final String? token;
  final String? book_name;
  final String? nickname; //不用
  final String? username;

  const PDFS({
    Key? key,
    this.path,
    this.sound_file,
    this.book_name,
    this.token,
    this.nickname,
    required this.username,
  }) : super(key: key);

  @override
  _PDFSState createState() => _PDFSState();
}

class _PDFSState extends State<PDFS> {
// 声明一个变量来控制音频播放状态
  bool isPlaying = false;
  // late AudioPlayer audioPlayer;
  late String sound_path = '';
  Duration currentDuration = Duration.zero;

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  List<VoiceRecording> _recordings = [];
  bool _isRecording = false;
  late String _currentFilePath;
  FlutterSoundRecorder? _recorder;
  //送花
  Future<void> flowerSound({required String soundNickname}) async {
    //
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/HomePage/flower/flowerNum.php',
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

//播放量
  Future<void> PlaySound({required String soundNickname}) async {
    //
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/HomePage/playNum/playNum.php',
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

  //喜欢音频
  Future<void> LikeSound(
      {required String soundNickname, required bool like}) async {
    //
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/HomePage/likeSound/LikeSound.php',
    );
    final response = await http.post(
      url,
      body: {
        'soundNickname': soundNickname,
        'book_name': widget.book_name,
        'nickname': widget.username,
        'like': like.toString(),
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  //不喜欢音频
  Future<void> isLikeSound({required String soundNickname}) async {
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/HomePage/likeSound/isLikeSound.php',
    );
    final response = await http.post(
      url,
      body: {
        'soundNickname': soundNickname,
        'book_name': widget.book_name,
        'nickname': widget.username,
        'like': 'false',
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  //
  Future<void> _startRecording() async {
    //开始录音
    setState(() {
      _isRecording = true;
    });

    final appDir = await getApplicationDocumentsDirectory();
    final audioDir = Directory('${appDir.path}/audio');
    await audioDir.create(recursive: true);

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final filePath = '${audioDir.path}/recording_$currentTime.wav';

    setState(() {
      _currentFilePath = filePath;
    });

    _recorder = FlutterSoundRecorder();

    await _recorder!.openAudioSession(); // 打开音频会话

    await _recorder!.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );
  }

  Future<void> _stopRecording() async {
    //截止录音
    setState(() {
      _isRecording = false;
    });

    if (_recorder != null) {
      await _recorder!.stopRecorder();
      await _recorder!.closeAudioSession();
    }

    final recordingUrl = await _uploadRecording(File(_currentFilePath));

    final newRecording = VoiceRecording(
      filePath: _currentFilePath,
      recordingUrl: recordingUrl,
    );

    setState(() {
      _recordings.add(newRecording);
    });
  }

  Future<String> _uploadRecording(File file) async {
    final url = Uri.parse(
        'http://${apiVar.serverIp}/FaElegance/public/testyuyin/1.php');
    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('file', file.path));
    request.fields['username'] = widget.username!; // 添加token参数
    request.fields['book_name'] = widget.book_name!; // 添加book_name参数
    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final aa = jsonDecode(response.body);
      print(aa);
      print(widget.username);
      return response.body;
    } else {
      throw Exception('Failed to upload recording');
    }
  }

  //
  List<bool> isAudioPlayingList = [];
  @override
  void initState() {
    super.initState();
    sound_path =
        'http://${apiVar.serverIp}/FaElegance/public${widget.sound_file!}';

    fetchData();
    ReadLog();
    openTheRecorder().then((value) {
      setState(() {});
    });
  }

  //阅读记录
  Future<void> ReadLog() async {
    //获取音频列表
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/readLog.php',
    );
    final response = await http.post(
      url,
      body: {
        'book_name': widget.book_name,
        'username': widget.username,
        'timestamp': DateTime.fromMillisecondsSinceEpoch(
                DateTime.now().millisecondsSinceEpoch)
            .toString(),
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
    } else {
      // 处理请求失败的情况
    }
    setState(() {
      // dropdownOptions = options;
    });
  }

  //

//权限
  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
  }
  //权限

//音频列表
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  Audio? selectedAudio; // Selected audio
  late String selectedUrl = '';
  List<Audio> audioList = [];
  Future<void> fetchData() async {
    //获取音频列表
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/hompage/HomePage/showSound.php',
    );
    final response = await http.post(
      url,
      body: {
        'book_name': widget.book_name,
        'soundnickname': widget.username,
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['success']) {
        final system = responseData['system'];
        final dataList = responseData['data'];
        audioList = dataList.map<Audio>((item) {
          return Audio(
            name: '${item['username'].toString()}',
            url:
                'http://${apiVar.serverIp}/FaElegance/public${item['sound_file']}',
            isLiked: item['islike'] == "true",
            isLikeNum: int.parse(item['isLikeNum']),
            playNum: int.parse(item['playNum']),
            flowerNum: int.parse(item['flowerNum']),
          );
        }).toList();

        // audioList.insert(
        //     0,
        //     // Audio(
        //     //   name: '系统预设',
        //     //   url: 'http://${apiVar.serverIp}/FaElegance/public${system}',
        //     //   flowerNum: 123, //int.parse(item['flowerNum']),
        //     //   isLiked: false,
        //     //   isLikeNum: 100,
        //     //   playNum: 4700,
        //     // )
        //     );
      }
    } else {
      // 处理请求失败的情况
    }
    setState(() {
      // dropdownOptions = options;
    });
  }
  //格式化人数

  String formatLikes(int likes) {
    if (likes < 1000) {
      // 如果喜欢人数小于1000，则直接返回原始值
      return likes.toString();
    } else if (likes < 10000) {
      // 如果喜欢人数小于10000，则将喜欢人数除以1000，并保留一位小数
      double likesK = likes / 1000;
      return '${likesK.toStringAsFixed(1)}k';
    } else {
      // 如果喜欢人数大于等于10000，则将喜欢人数除以10000，并保留一位小数
      double likesW = likes / 10000;
      return '${likesW.toStringAsFixed(1)}w';
    }
  }

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

  //下拉选择音频

  String displayedText = '请选择音频'; // 初始显示的文本

  bool isLiked = false;
  Future<void> _showAudioPicker() async {
    if (isAudioPlayingList.isEmpty) {
      isAudioPlayingList = List.generate(audioList.length, (index) => false);
    }

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('选择你喜欢的音频播放', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: audioList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        PlaySound(
                                            soundNickname:
                                                audioList[index].name); //播放量
                                        setState(() {
                                          selectedAudio = audioList[index];
                                          isPlaying = true;
                                          audioList[index].playNum++;
                                        });

                                        if (isPlaying) {
                                          _player.stopPlayer();
                                          _playerStatus = PlayerStatus.stopped;
                                          _playRecording(selectedAudio!.url);
                                        } else {
                                          _player.stopPlayer();
                                          _playerStatus = PlayerStatus.stopped;
                                        }
                                      },
                                      child: Container(
                                        width: 80.0, // 设置容器的宽度为200个逻辑像素
                                        child: Text(audioList[index].name),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Container(
                                      width: 36.0,
                                      height: 36.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.black26, width: 2.0),
                                      ),
                                      child: Center(
                                        child: isAudioPlayingList[index]
                                            ? Icon(Icons.pause_circle_filled,
                                                color: Colors.white)
                                            : Icon(Icons.play_circle_fill,
                                                color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        selectedAudio =
                                            audioList[index]; // 选中音频
                                        isPlaying = !isPlaying; // 切换播放状态
                                        audioList[index].playNum++; // 播放次数加1
                                      });
                                      if (isAudioPlayingList[index]) {
                                        PlaySound(
                                            soundNickname:
                                                audioList[index].name); // 播放音频
                                        _pauseRecording(); //暂停录音
                                      } else {
                                        _player.stopPlayer(); //停止播放
                                        _playerStatus =
                                            PlayerStatus.stopped; //播放状态
                                        _playRecording(
                                            selectedAudio!.url); //播放音频
                                      }
                                      setState(() {
                                        isAudioPlayingList[index] =
                                            !isAudioPlayingList[index];
                                      });
                                    },
                                  ),

                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          audioList[index]
                                              .flowerNum++; // 点击时将花朵数量加 1
                                        });
                                        showCustomToast(context, '送出了一朵花');
                                        flowerSound(
                                            soundNickname:
                                                audioList[index].name);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.brightness_7,
                                            color: Colors.yellow,
                                          ),
                                          SizedBox(
                                            width: 30,
                                            child: Text(
                                              formatLikes(
                                                  audioList[index].flowerNum),
                                              // 将更新后的花朵数量显示在右侧
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (audioList[index].isLiked == false) {
                                          LikeSound(
                                              soundNickname:
                                                  audioList[index].name,
                                              like: !audioList[index].isLiked);
                                        } else {
                                          isLikeSound(
                                              soundNickname:
                                                  audioList[index].name);
                                        }
                                        setState(() {
                                          // 切换喜欢的状态
                                          audioList[index].isLiked =
                                              !audioList[index].isLiked;

                                          // 根据新的喜欢状态更新喜欢人数
                                          if (audioList[index].isLiked) {
                                            // 如果现在是喜欢状态，则喜欢人数加1
                                            audioList[index].isLikeNum += 1;
                                          } else {
                                            // 如果现在是不喜欢状态，并且喜欢人数大于0，则喜欢人数减1
                                            if (audioList[index].isLikeNum >
                                                0) {
                                              audioList[index].isLikeNum -= 1;
                                            }
                                          }
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            // 假设你有一个心形图标可以替换这里的Icons.brightness_7
                                            Icons.favorite,
                                            color: audioList[index].isLiked
                                                ? Colors.red
                                                : Colors.black12,
                                          ),
                                          SizedBox(width: 4.0), // 添加一些间距
                                          SizedBox(
                                            width: 30,
                                            child: Text(
                                              formatLikes(audioList[index]
                                                  .isLikeNum), // 显示喜欢人数
                                              style: TextStyle(
                                                color: Colors.black, // 设置文本颜色
                                                fontSize: 12.0, // 设置文本大小
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.confirmation_num,
                                              size: 14,
                                              color: Colors.red,
                                            ),
                                          ),
                                          TextSpan(
                                            text: formatLikes(
                                                audioList[index].playNum),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.red, // 设置不同的颜色
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Text('花'),
                                  // 音频播放
                                ],
                              ),
                            ),
                            Divider(), // 添加分割线
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      setState(() {
        if (selectedAudio != null) {
          displayedText = '${selectedAudio!.name}';
        } else {
          displayedText = '请选择音频';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "阅读",
          style: TextStyle(
            color: ThemeManager.themes[colorsID.colors].IndexTitleColor,
          ),
        ),
        // backgroundColor: Color.fromARGB(235, 5, 148, 46),
        backgroundColor:
            ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
        iconTheme: IconThemeData(
          color: ThemeManager.themes[colorsID.colors].IndexTitleColor, //返回箭头的颜色
        ),
      ),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height + 220,
                  child: FutureBuilder<Uint8List>(
                    future: _fetchPdf(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Stack(
                          children: [
                            PDFView(
                              pdfData: snapshot.data!,

                              autoSpacing: false, //字体
                              onPageChanged: (int? page, int? total) {
                                if (kDebugMode) {
                                  print('page change: $page/$total');
                                }
                                setState(() {
                                  currentPage = page;
                                });
                              },
                              onViewCreated:
                                  (PDFViewController pdfViewController) {
                                _controller.complete(pdfViewController);
                              },
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Failed to load PDF'));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                color:
                    ThemeManager.themes[colorsID.colors].IndexBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          setState(() async {
                            selectedAudio = audioList[0];
                            isPlaying = true;

                            if (isPlaying) {
                              await _player.stopPlayer();
                              _playerStatus = PlayerStatus.stopped;
                              _playRecording(selectedAudio!.url);
                            } else {
                              await _player.stopPlayer();
                              _playerStatus = PlayerStatus.stopped;
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (audioList.isNotEmpty &&
                                audioList[0]?.name != null) // 使用空值判断运算符
                              Text(
                                audioList[0].name!,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: ThemeManager
                                      .themes[colorsID.colors].IndexTitleColor,
                                ),
                              ),
                            if (audioList.isNotEmpty &&
                                audioList[0]?.name == null)
                              Text(
                                'No Audio Available', // 显示默认文本或占位符
                                style: TextStyle(
                                  fontSize: 20,
                                  color: ThemeManager
                                      .themes[colorsID.colors].IndexTitleColor,
                                ),
                              ),

                            Spacer(), //空白
                            //暂停
                            IconButton(
                              icon: Container(
                                width: 36.0,
                                height: 36.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: ThemeManager
                                          .themes[colorsID.colors]
                                          .IndexTitleColor,
                                      width: 2.0),
                                ),
                                child: Center(
                                  child: isPlaying
                                      ? Icon(Icons.pause_circle_filled,
                                          color: ThemeManager
                                              .themes[colorsID.colors]
                                              .IndexTitleColor)
                                      : Icon(Icons.play_circle_fill,
                                          color: ThemeManager
                                              .themes[colorsID.colors]
                                              .IndexTitleColor),
                                ),
                              ),
                              onPressed: () {
                                if (isPlaying) {
                                  _pauseRecording();
                                } else {
                                  _playRecording(selectedAudio!.url);
                                }
                                setState(() {
                                  isPlaying = !isPlaying;
                                });
                              },
                            ),
                            SizedBox(
                              width: 52,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                    // Divider(), // 添加分割线
                    Row(
                      children: [
                        Text(
                          displayedText,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Container(
                            width: 36.0,
                            height: 36.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: ThemeManager
                                      .themes[colorsID.colors].IndexTitleColor,
                                  width: 2.0),
                            ),
                            child: Center(
                              child: isPlaying
                                  ? Icon(Icons.pause_circle_filled,
                                      color: ThemeManager
                                          .themes[colorsID.colors]
                                          .IndexTitleColor)
                                  : Icon(Icons.play_circle_fill,
                                      color: ThemeManager
                                          .themes[colorsID.colors]
                                          .IndexTitleColor),
                            ),
                          ),
                          onPressed: () {
                            if (isPlaying) {
                              _pauseRecording(); //暂停录音
                            } else {
                              _playRecording(selectedAudio!.url);
                            }
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                        ),
                        IconButton(
                          iconSize: 35,
                          onPressed: _showAudioPicker,
                          icon: const Icon(Icons.menu_open),
                        ),
                      ],
                    ),

                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                    // Divider(), // 添加分割线
                    SizedBox(
                      height: 1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), // 设置圆角的半径
                        color: _isRecording
                            ? ThemeManager
                                .themes[colorsID.colors].PlayChoseButtonColor
                            : ThemeManager
                                .themes[colorsID.colors].PlayButtonColor,
                      ),
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onLongPress: _startRecording,
                            onLongPressUp: _stopRecording,
                            child: Container(
                              margin: EdgeInsets.all(6.0),
                              child: Text(
                                _isRecording ? '松开截止...' : '按住录音',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: ThemeManager.themes[colorsID.colors]
                                      .PlayButtonTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Divider(), // 添加分割线
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<Uint8List> _fetchPdf() async {
    final response = await http.get(Uri.parse(
        'http://${apiVar.serverIp}/FaElegance/public${widget.path!}'));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load PDF');
    }
  }
}

class ScrollingText extends StatefulWidget {
  final String text;

  ScrollingText({required this.text});

  @override
  _ScrollingTextState createState() => _ScrollingTextState();
}

class _ScrollingTextState extends State<ScrollingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 5), // 调整滚动的速度，单位为秒
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Row(
            children: [
              SizedBox(
                width: _animationController.value *
                    (MediaQuery.of(context).size.width - 16), // 调整滚动的范围
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//送花提示
void showCustomToast(BuildContext context, String message) {
  final overlay = Overlay.of(context)?.context.findRenderObject() as RenderBox?;

  if (overlay != null) {
    final overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.4, // 自定义垂直位置
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.center,
            child: ClipPath(
              clipper: FlowerClipper(), // 自定义的路径剪裁器
              child: Container(
                color: Colors.yellow, // 自定义背景颜色
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.black, // 自定义文本颜色
                      fontSize: 16.0, // 自定义文本大小
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context)?.insert(overlayEntry);

    // 设置一定时间后移除 OverlayEntry
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

class FlowerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 4);
    path.lineTo(size.width * 3 / 4, size.height / 2);
    path.lineTo(size.width, size.height * 3 / 4);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width / 4, size.height * 3 / 4);
    path.lineTo(0, size.height / 2);
    path.lineTo(size.width / 4, size.height / 4);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
