import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/controller/DefendencyController.dart';

class GetLazyPut extends StatelessWidget {
  const GetLazyPut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("의존성 주입 사용 페이지.")),
        body: Center(
            child: Container(
          child: ElevatedButton(
            child: Text(
              " 의존성 주입 찾자..",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Get.find<DefendencyController>().increase();
              print(Get.find<DefendencyController>().hashCode);

            },
          ),
        )));
  }
}
