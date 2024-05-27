import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Global/Global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Global/Api.dart';
import 'package:untitled/Global/themeColors.dart';

const int kLoginExpirationDays = 700; // 定义登录有效期为7天

class HomePageArguments {
  final String token;
  HomePageArguments(this.token);
}

late SharedPreferences prefs;

//登录
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController PhoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void checkLoginStatus() {
    if (prefs == null) {
      return; // 如果prefs尚未初始化，则退出方法
    }
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? username = prefs.getString('username');
    int? lastLoginTimestamp = prefs.getInt('lastLoginTimestamp');
    if (isLoggedIn && username != null && lastLoginTimestamp != null) {
      int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

      int expirationTimestamp =
          lastLoginTimestamp + (kLoginExpirationDays * 24 * 60 * 60 * 1000);

      if (currentTimestamp < expirationTimestamp) {
        String? token = prefs.getString('token');
        String? nickname = prefs.getString('nickname');
        String? username = prefs.getString('username');
        Global.token = token ?? '';
        Global.nickname = nickname ?? '';
        Global.username = username ?? '';

        Navigator.pushNamed(
          context,
          '/bottomRoute',
          arguments: {
            'token': prefs.getString('token'),
            'nickname': prefs.getString('nickname'),
            'username': prefs.getString('username'),
          },
        );

        return;
      }
    }
    // 登录状态过期或未登录时，清除登录信息
    clearLoginStatus();
  }

  Future<void> saveLoginStatus(
    bool isLoggedIn,
    String token,
    String nickname,
    String username,
  ) async {
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('token', token);
    await prefs.setString('nickname', nickname);
    await prefs.setString('username', username);

    await prefs.setInt(
        'lastLoginTimestamp', DateTime.now().millisecondsSinceEpoch);
  }

  void clearLoginStatus() async {
    await prefs.setBool('isLoggedIn', false);
    await prefs.setString('username', '');
    await prefs.setInt('lastLoginTimestamp', 0);
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    checkLoginStatus();
  }

  Future<void> login(phonetext) async {
    String phone = phonetext;
    var url = Uri.http(
      '${apiVar.serverIp}',
      '/EleganceApi/eleganceApp/Login/login.php',
    );
    final response = await http.post(
      url,
      body: {
        'phone': phone,
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData[0]['success'] == '登录成功') {
        Fluttertoast.showToast(msg: responseData[0]['success']);
        Navigator.pushNamed(
          context,
          '/bottomRoute',
          arguments: {
            'token': responseData[0]['token'],
            'nickname': responseData[0]['nickname'],
            'username': responseData[0]['username'],
          },
        );
        await saveLoginStatus(
          true,
          responseData[0]['token'],
          responseData[0]['nickname'],
          responseData[0]['username'],
        );
        //存储变量
        Global.token = responseData[0]['token'];
        Global.nickname = responseData[0]['nickname'];
        Global.username = responseData[0]['username'];
        Global.email = responseData[0]['email'];
        Global.phone = responseData[0]['mobile'];
        Global.birthday = responseData[0]['birthday'];
        Global.sex = responseData[0]['sex'];
        Global.vip = responseData[0]['vip'];
        Global.avatar = responseData[0]['avatar'];
      } else {
        Fluttertoast.showToast(msg: responseData[0]['success']);
      }
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
    }
  }

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isSendingCode = false;
  bool _isCodeSent = false;
  bool _isRegistering = false;
  bool _isRegistered = false;
  int _countdownSeconds = 60;
  Timer? _timer;
  bool _isAgreed = false; //隐私同意框
  //获取验证码函数
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

//倒计时60秒
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

//注册
  void _registerAccount(String code) async {
    String phoneNumber = _phoneController.text;
    // 发送请求到后端接口进行账号注册
    try {
      setState(() {
        _isRegistering = true;
      });
      var url = Uri.parse('http://${apiVar.serverIp}/EleganceApi/register.php');
      var response = await http.post(url,
          body: {'phone': phoneNumber, 'code': code, 'anid': Global.AndID});

      // 模拟请求接口，1秒后根据返回结果判断是否注册成功
      await Future.delayed(Duration(seconds: 1));

      if (response.statusCode == 200) {
        // 假设接口返回的数据中包含一个名为 'success' 的字段表示注册成功
        var data = json.decode(response.body);
        print(data);
        print(0909);
        if (data['success'] == 'true') {
          // clearLogin();
          setState(() {
            _isRegistering = false;
            _isRegistered = true;
          });
          // 注册成功后跳转到登录页面
          if (_isRegistered) {
            // _showToast('注册成功');
            Future.delayed(Duration(seconds: 1), () {
              login(phoneNumber);
            });
          }
        } else {
          setState(() {
            _isRegistering = false; // 重置状态为 false
          });
          if (phoneNumber == '' || code == '') {
            _showToast('请输入手机号或验证码');
          } else {
            _showToast('注册失败1');
          }
        }
      } else {
        setState(() {
          _isRegistering = false; // 重置状态为 false
        });

        if (phoneNumber == '' || code == '') {
          _showToast('请输入手机号或验证码');
        } else {
          _showToast('注册失败2');
        }
      }
    } catch (e) {
      setState(() {
        _isRegistering = false; // 重置状态为 false
      });
      if (phoneNumber == '' || code == '') {
        _showToast('请输入手机号或验证码');
      } else {
        print(code);
        print(121334);
        _showToast('注册失败3');
      }
    }
  }

  //提示信息
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('返回'),
      ),
      backgroundColor: ThemeManager.themes[colorsID.colors].backgroundColor,
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Colors.blue, Colors.white],
        //   ),
        // ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width / 5 * 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 5,
                      child: Image.asset(
                          '${ThemeManager.themes[colorsID.colors].loginLogo}'),
                    ),

                    SizedBox(height: 100),
                    InputPhone(), //手机输入框
                    SizedBox(height: 16.0),
                    InputSms(),

                    SizedBox(height: 16.0),
                    LoginButton(context),

                    SizedBox(height: 16.0),
                    Privacy(context), //隐私政策
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget InputPhone() {
    return Container(
      height: MediaQuery.of(context).size.height / 18,
      decoration: BoxDecoration(
        color: ThemeManager.themes[colorsID.colors].InputColor,
        borderRadius: BorderRadius.circular(5.0), // 设置圆角半径
      ),
      // color: Color.fromRGBO(215, 215, 230, 1.0),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '手机号',
                  hintStyle: TextStyle(
                    color: ThemeManager.themes[colorsID.colors].TextColor,
                  ),
                ),
                style: TextStyle(
                  color: ThemeManager.themes[colorsID.colors].TextColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_back,
              size: 20.0,
              color: ThemeManager.themes[colorsID.colors].TextColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget InputSms() {
    return Container(
      height: MediaQuery.of(context).size.height / 18,
      decoration: BoxDecoration(
        color: ThemeManager.themes[colorsID.colors].InputColor,
        borderRadius: BorderRadius.circular(5.0), // 设置圆角半径
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '输入验证码',
                  hintStyle: TextStyle(
                      color: ThemeManager
                          .themes[colorsID.colors].TextDeadColor), // 修改提示文本的颜色
                  // prefixIcon: Icon(Icons.lock),
                ),
                style: TextStyle(
                    color: ThemeManager
                        .themes[colorsID.colors].TextDeadColor), // 修改输入文本的颜色
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Container(
                height: MediaQuery.of(context).size.height / 25,
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
                      ? Text(
                          '$_countdownSeconds 秒',
                          style: TextStyle(
                              color: ThemeManager
                                  .themes[colorsID.colors].TextColor),
                        )
                      : Text(
                          '获取验证码',
                          style: TextStyle(
                              fontSize: 12,
                              color: ThemeManager
                                  .themes[colorsID.colors].TextColor),
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        ThemeManager.themes[colorsID.colors].smsButton,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget LoginButton(context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: _isAgreed
            ? ThemeManager.themes[colorsID.colors].LoginButtonColor2
            : ThemeManager.themes[colorsID.colors].LoginButtonColor1,
        borderRadius: BorderRadius.circular(25.0), // 设置圆角半径
      ),
      child: TextButton(
        onPressed: _isRegistering || !_isAgreed
            ? null
            : () {
                String code = _codeController.text;
                _registerAccount(code);
              },
        child: Text(
          '登录',
          style:
              TextStyle(color: ThemeManager.themes[colorsID.colors].TextColor),
        ),
      ),
    );
  }

  Widget Privacy(context) {
    return Container(
      child: Row(
        children: [
          Container(
              width: 24.0, // 设置固定宽度
              child: IconButton(
                icon: Icon(
                  _isAgreed
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: _isAgreed
                      ? ThemeManager.themes[colorsID.colors].LoginButtonColor2
                      : ThemeManager.themes[colorsID.colors].LoginButtonColor1,
                ),
                onPressed: () {
                  setState(() {
                    _isAgreed = !_isAgreed;
                    print(_isAgreed);
                  });
                },
              )),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              // setState(() {
              //   _isAgreed = !_isAgreed;
              // });
            },
            child: Text(
              '勾选即表示您同意雅韵的',
              style: TextStyle(
                  fontSize: 11.0,
                  color: ThemeManager.themes[colorsID.colors].TextColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => termsServicePage()),
              );
              // setState(() {
              //   _isAgreed = !_isAgreed;
              // });
            },
            child: Text(
              '《服务条款》',
              style: TextStyle(fontSize: 11.0, color: Colors.blue),
            ),
          ),
          GestureDetector(
            onTap: () {
              // setState(() {
              //   _isAgreed = !_isAgreed;
              // });
            },
            child: Text(
              '和',
              style: TextStyle(
                  fontSize: 11.0,
                  color: ThemeManager.themes[colorsID.colors].TextColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => termsServicePage()),
              );
              // setState(() {
              //   _isAgreed = !_isAgreed;
              // });
            },
            child: Text(
              '《隐私政策》',
              style: TextStyle(fontSize: 11.0, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> clearLogin() async {
  await prefs.setBool('isLoggedIn', false);
  await prefs.setString('username', '');
  await prefs.setInt('lastLoginTimestamp', 0);
}

class termsServicePage extends StatefulWidget {
  @override
  _termsServicePageState createState() => _termsServicePageState();
}

class _termsServicePageState extends State<termsServicePage> {
  final String papap =
      '    尊敬的IUCRM用户：我们对《IUCRM隐私政策》进行了更新。此版本《IUCRM隐私政策》的更新主要集中在：IUCRM需要收集的个人信息及其使用用途。【特别提示】本政策仅适用于北京恩佑运达网络科技有限公司（以下或称“我们”或“IUCRM”）提供的产品和服务及其延伸的功能，包括IUCRM APP、网站以及随技术发展出现的新形态向您提供的各项产品和服务（以下或称“本应用”）。如我们提供的某款产品有单独的隐私政策或相应的用户服务协议当中存在特殊约定，则该产品的隐私政策将优先适用；该款产品隐私政策和用户服务协议未涵盖的内容，以本政策内容为准。请仔细阅读《IUCRM隐私政策》（尤其是粗体内容）并确定了解我们对您个人信息的处理规则。阅读过程中，如您有任何疑问，可通过《IUCRM隐私政策》中的联系方式咨询我们。如您有任何疑问、意见或建议，您可通过以下联系方式与我们联系：联系邮箱：676860426 qq.com开发者：北京恩佑运达网络科技有限公司注册地址：北京市大兴区金星西路5号及5号院4号楼4层3单元505';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('服务条款'),
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '雅韵APP 服务条款',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text('     ${papap}'),
              )
            ],
          ),
        ));
  }
}
