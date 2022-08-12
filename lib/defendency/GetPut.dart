import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetPut extends StatelessWidget {
  const GetPut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("의존성 주입 사용 페이지.")),
        body: Center(child: Container(child: Text("GetPut Page"),)));
  }
}
