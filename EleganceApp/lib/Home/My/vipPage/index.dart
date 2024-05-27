import 'package:flutter/material.dart';
import 'package:untitled/Global/Api.dart'; //api

class VipPage extends StatefulWidget {
  final String username;
  VipPage({required this.username});
  @override
  _VipPageState createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildContainer('Container 2', Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
}
