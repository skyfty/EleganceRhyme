import 'package:flutter/material.dart';
import 'package:untitled/Global/Api.dart'; //api

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildContainer('Container 0', Colors.blue),
            EveryoneListen('Container 1', Colors.black),
            buildContainer('Container 2', Colors.red),
            buildContainer('Container 3', Colors.green),
            buildContainer('Container 4', Colors.yellow),
            buildContainer('Container 5', Colors.orange),
          ],
        ),
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

  //大家都在听
  Widget EveryoneListen(String text, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
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
