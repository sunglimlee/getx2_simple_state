import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/screen/SecondNamedPage.dart';

class FirstNamedPage extends StatelessWidget {
  const FirstNamedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Named Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed("/SecondNamedPage"), // 정말 무지하게 간단하긴하다.
              child: Text("Get.to SecondPage"),
            ),
          ],
        ),
      ),
    );
  }
}
