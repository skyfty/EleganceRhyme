import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:untitled/Global/Api.dart';

class Demo extends StatefulWidget {
  Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  bool recording = false;

  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _mRecorder!.openAudioSession();

    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        return;
      }
    }
  }

  @override
  void initState() {
    _mPlayer!.openAudioSession().then((value) {});

    // await openTheRecorder().then((value) {});
    // TODO: implement initState

    openTheRecorder().then((value) {
      setState(() {});
    });
    super.initState();
  }

  void play() {
    _mPlayer!
        .startPlayer(
            fromURI:
                'http://192.168.33.226:120/public/uploads/20240326/bd1920d6d23f48c9638da733d0aab199.mp3', //_mPath,

            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void record() async {
    _mRecorder!
        .startRecorder(
          toFile: _mPath,
          codec: _codec,
          audioSource: AudioSource.microphone,
        )
        .then((value) {});

    setState(() {
      recording = true;
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        recording = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_sound demo'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 3,
          ),
          ElevatedButton(
              onPressed: () {
                play();
              },
              child: Text('Play')),
          SizedBox(
            width: 20,
          ),
          // 一般播放和录音没啥关系
          ElevatedButton(
              onPressed: () {
                if (recording) {
                  stopRecorder();
                } else {
                  record();
                }
              },
              child: Text(recording ? 'Stop' : 'Record'))
        ],
      ),
    );
  }
}

class VoiceRecording {
  final String filePath;
  final String recordingUrl;

  VoiceRecording({required this.filePath, required this.recordingUrl});
}

class VoiceRecorderPage extends StatefulWidget {
  @override
  _VoiceRecorderPageState createState() => _VoiceRecorderPageState();
}

class _VoiceRecorderPageState extends State<VoiceRecorderPage> {
  List<VoiceRecording> _recordings = [];
  bool _isRecording = false;
  late String _currentFilePath;
  FlutterSoundRecorder? _recorder;

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
    //上传
    final url = Uri.parse('http://${apiVar.serverIp}/testyuyin/1.php');

    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final aa = jsonDecode(response.body);

      return response.body;
    } else {
      throw Exception('Failed to upload recording');
    }
  }

  void _playRecording(String filePath) async {
    final player = FlutterSoundPlayer();

    player.openAudioSession().then((value) {
      player.startPlayer(
        fromURI: filePath,
        codec: Codec.pcm16WAV,
      );
    });

    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (!player.isPlaying) {
        timer.cancel();
        player.closeAudioSession();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('语音测试'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _recordings.length,
              itemBuilder: (context, index) {
                final recording = _recordings[index];
                return ListTile(
                  title: Text(recording.filePath),
                  trailing: IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () => _playRecording(recording.filePath),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: GestureDetector(
              onLongPress: _startRecording,
              onLongPressUp: _stopRecording,
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Text(
                  _isRecording ? '松开截止...' : '按住说话',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
