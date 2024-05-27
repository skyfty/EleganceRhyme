import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:untitled/Login/Login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/Global/Api.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isSendingCode = false;
  bool _isCodeSent = false;
  bool _isRegistering = false;
  bool _isRegistered = false;
  int _countdownSeconds = 60;
  Timer? _timer;

  void _startTimer() {
    _countdownSeconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdownSeconds == 0) {
        _timer?.cancel();
        setState(() {
          _isCodeSent = false;
        });
      } else {
        setState(() {
          _countdownSeconds--;
        });
      }
    });
  }

  Future<void> _sendVerificationCode() async {
    String phoneNumber = _phoneController.text;
    setState(() {
      _isSendingCode = true;
    });
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/SMS.php',
    );
    final response = await http.post(
      url,
      body: {
        'phone': phoneNumber,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // 假设接口返回的数据中包含一个名为 'success' 的字段表示发送成功
      print(response.body);
      var data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          _isSendingCode = false;
          _isCodeSent = true;
        });
        _startTimer();
      } else {
        setState(() {
          _isSendingCode = false; // 重置状态为 false
        });
        _showToast('验证码发送失败1');
      }
    } else {
      setState(() {
        _isSendingCode = false; // 重置状态为 false
      });
      _showToast('验证码发送失败2');
    }
  }

  void _registerAccount(String code) async {
    String phoneNumber = _phoneController.text;
    // 发送请求到后端接口进行账号注册
    try {
      setState(() {
        _isRegistering = true;
      });
      var url = Uri.parse('http://${apiVar.serverIp}/EleganceApi/register.php');
      var response =
          await http.post(url, body: {'phone': phoneNumber, 'code': code});

      // 模拟请求接口，1秒后根据返回结果判断是否注册成功
      await Future.delayed(Duration(seconds: 1));

      if (response.statusCode == 200) {
        // 假设接口返回的数据中包含一个名为 'success' 的字段表示注册成功
        var data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _isRegistering = false;
            _isRegistered = true;
          });
          // 注册成功后跳转到登录页面
          if (_isRegistered) {
            _showToast('注册成功');
            Future.delayed(Duration(seconds: 1), () {
              // Navigator.pushReplacementNamed(context, '/login');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            });
          }
        } else {
          setState(() {
            _isRegistering = false; // 重置状态为 false
          });
          if (phoneNumber == '' || code == '') {
            _showToast('请输入手机号或验证码');
          } else {
            _showToast('注册失败');
          }
        }
      } else {
        setState(() {
          _isRegistering = false; // 重置状态为 false
        });

        if (phoneNumber == '' || code == '') {
          _showToast('请输入手机号或验证码');
        } else {
          _showToast('注册失败');
        }
      }
    } catch (e) {
      setState(() {
        _isRegistering = false; // 重置状态为 false
      });
      if (phoneNumber == '' || code == '') {
        _showToast('请输入手机号或验证码');
      } else {
        _showToast('注册失败');
      }
    }
  }

  void _showToast(String message) {
    if (!_isAgreed) {
      Fluttertoast.showToast(
        msg: '请先阅读并同意服务条款和隐私政策',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool _isAgreed = false; //隐私同意框
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '注册雅韵',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.0),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none, // 移除边框
                    hintText: '手机号', // 添加提示文本
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '验证码',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: _isCodeSent
                            ? null
                            : () async {
                                String phoneNumber = _phoneController.text;
                                if (phoneNumber.length != 11) {
                                  _showToast('请输入有效的手机号');
                                  return;
                                }
                                _sendVerificationCode();
                              },
                        child: _isCodeSent
                            ? Text('$_countdownSeconds 秒')
                            : Text(
                                '获取验证码',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    '勾选即表示您同意雅韵的服务条款和隐私政策',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  value: _isAgreed,
                  onChanged: (value) {
                    setState(() {
                      _isAgreed = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading, //设置勾选框在左边
                  activeColor: Colors.blue,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _isRegistering || !_isAgreed
                      ? null
                      : () {
                          String code = _codeController.text;
                          _registerAccount(code);
                        },
                  child:
                      _isRegistering ? CircularProgressIndicator() : Text('注册'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                InkWell(
                  onTap: () {
                    Navigator.pop(context); // 返回上一页面
                  },
                  child: Text(
                    '已有登录页面？返回登录',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
