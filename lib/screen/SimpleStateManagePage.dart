import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/controller/CountControllerWithGetX.dart';
import 'package:getx2_simple_state/controller/CountControllerWithProvider.dart';
import 'package:getx2_simple_state/screen/Home.dart';
import 'package:getx2_simple_state/state/WithGetX.dart';
import 'package:getx2_simple_state/state/WithProvider.dart';
import 'package:provider/provider.dart';

class SimpleStateManagePage extends StatelessWidget {
  const SimpleStateManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 테스트 차원에서 여기다가 GetX 객체를 생성해보자.
    return Scaffold(
      appBar: AppBar(
        title: const Text("단순 상태 관리"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(child: WithGetX()),
            Container(child: WithProvider()),
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
