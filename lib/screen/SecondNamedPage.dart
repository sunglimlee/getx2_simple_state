import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/screen/Home.dart';

class SecondNamedPage extends StatelessWidget {
  const SecondNamedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Named Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              //onPressed: () => Navigator.of(context).pop(), // 이게 기존 방식
              onPressed: () => Get.back(), // 정말 무지하게 간단하긴하다. // context 종속이 전혀 없다.
              child: Text("뒤로 이동"),
            ),
            ElevatedButton(
              onPressed: () => Get.offAll(() => const Home()), // 정말 무지하게 간단하긴하다.
              child: Text("홈으로 이동"),
            ),
            ElevatedButton(
              onPressed: () => Get.offAllNamed("/"), // 정말 무지하게 간단하긴하다.
              child: Text("GetX offAllNamed 홈으로 이동"),
            ),
          ],
        ),
      ),
    );
  }
}
