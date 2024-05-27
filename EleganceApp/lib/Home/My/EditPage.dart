import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/Global/Global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Global/Api.dart'; //api

class EditProfilePage extends StatefulWidget {
  final String username;
  EditProfilePage({required this.username});
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _name = Global.nickname;
  String _sex = Global.sex;
  String _email = Global.email;
  String _phone = Global.phone;
  String _birthday = Global.birthday;
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    print(widget.username);
    DateTime? selectedDate;
  }

//选择图片
  final _picker = ImagePicker();
  XFile? _image;
  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;

        _uploadImage('${widget.username}');
      });
    }
  }

  Future<void> _uploadImage(String username) async {
    if (_image != null) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://${apiVar.serverIp}/FaElegance/public/testyuyin/UploadImage.php'),
        );
        request.fields['username'] = username;
        request.files
            .add(await http.MultipartFile.fromPath('image', _image!.path));

        var response = await request.send();
        var httpResponse = await http.Response.fromStream(response);

        if (httpResponse.statusCode == 200) {
          final dynamic jsonData = json.decode(httpResponse.body);
          setState(() {
            Global.avatar = jsonData['image'];
          });
          print('Image uploaded successfully');
        } else {
          print('Failed to upload image');
        }
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑个人资料'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _getImage,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Expanded(
                  //   child: CircleAvatar(
                  //     radius: 40, // 设置头像半径
                  //     backgroundImage: NetworkImage(
                  //       'http://8.141.86.125/FaElegance/public${Global.avatar}',
                  //
                  //     ),
                  //   ),
                  //   flex: 1,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32), // 设置圆角
                          child: Image.network(
                            'http://${apiVar.serverIp}/FaElegance/public${Global.avatar}',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover, // 设置图片的填充方式
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            _buildProfileItem('昵称', _name, (value) => _name = value),
            Divider(),
            _buildProfileItem('性别', _sex, (value) => _sex = value),
            Divider(),
            InkWell(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  dateFormat: "yyyy年 MM月 dd日",
                  pickerTheme: DateTimePickerTheme(
                    confirm: Text(
                      "确认",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  onConfirm: (DateTime dateTime, List<int> selectedIndex) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(dateTime);
                    setState(() {
                      _birthday = formattedDate;
                    });
                    fetchData(birthday: formattedDate.toString());
                    print("选择的时间是：$formattedDate");
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('生日'),
                    Text(_birthday),
                  ],
                ),
              ),
            ),
            Divider(),
            _buildProfileItem('邮箱', _email, (value) => _email = value),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
      String label, String value, Function(String) onChanged) {
    return InkWell(
      onTap: () {
        _showEditDialog(label, value, onChanged);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(String label, String value, Function(String) onChanged) {
    final _controller = TextEditingController(text: value);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('修改 $label'),
        content: label == '性别'
            ? DropdownButtonFormField<String>(
                value: value,
                items: const [
                  DropdownMenuItem(value: '男', child: Text('男')),
                  DropdownMenuItem(value: '女', child: Text('女')),
                ],
                onChanged: (newValue) {
                  setState(() {
                    _controller.text = newValue!;
                  });
                  onChanged(newValue!);
                },
              )
            : TextField(
                controller: _controller,
                autofocus: true,
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              if (label == '性别') {
                onChanged(_controller.text.trim());
              } else {
                onChanged(_controller.text.trim());
              }

              _saveProfile();
              Navigator.of(context).pop();
            },
            child: Text('保存'),
          ),
        ],
      ),
    );
  }

  void _saveProfile() {
    if (_name != Global.nickname) {
      fetchData(name: _name);
    }
    if (_sex != Global.sex) {
      fetchData(sex: _sex);
    }
    if (_email != Global.email) {
      fetchData(email: _email);
    }
    if (_phone != Global.phone) {
      fetchData(phone: _phone);
    }
  }

  Future<void> fetchData(
      {String? name,
      String? sex,
      String? email,
      String? phone,
      String? birthday}) async {
    final url = Uri.parse(
        'http://${apiVar.serverIp}/EleganceApi/eleganceApp/myPage/my/eaditMy.php');

    Map<String, dynamic> params = {
      'username': '${widget.username}',
    };

    if (name != null) {
      params['name'] = name;
    }
    if (birthday != null) {
      params['birthday'] = birthday;
    }
    if (sex != null) {
      params['sex'] = sex;
    }
    if (email != null) {
      params['email'] = email;
    }
    if (phone != null) {
      params['phone'] = phone;
    }

    try {
      final response = await http.post(url, body: params);

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);

        if (jsonData['success'] == '更新成功') {
          Fluttertoast.showToast(msg: jsonData['success']);
          if (name != null) {
            setState(() {
              Global.nickname = name;
            });
          }
          if (birthday != null) {
            setState(() {
              Global.birthday = birthday;
            });
          }
          if (sex != null) {
            setState(() {
              Global.sex = sex;
            });
          }
          if (email != null) {
            setState(() {
              Global.email = email;
            });
          }
          if (phone != null) {
            setState(() {
              Global.phone = phone;
            });
          }
        }
      } else {
        Fluttertoast.showToast(msg: '请检查网络');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '发生错误: $e');
    }
  }
}
