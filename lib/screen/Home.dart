import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/screen/FirstNamedPage.dart';
import 'package:getx2_simple_state/screen/SimpleStateManagePage.dart';
import 'package:getx2_simple_state/screen/ReactiveStateManagePage.dart';
import 'package:getx2_simple_state/binding/BindingPageImplementsBindings.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("라우트 관리 홈"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text("Get.to 단순상태관리페이로 이동"),
              onPressed: () => Get.to(() => SimpleStateManagePage()), // 정말 무지하게 간단하긴하다.
            ),
            ElevatedButton(
              child: Text("Get.to 반응형 상태관리페이로 이동"),
              onPressed: () => Get.to(() => ReactiveStateManagePage()), // 정말 무지하게 간단하긴하다.
            ),
            ElevatedButton(
              child: Text("의존성 관리 4가지 싸가지 공부"),
              onPressed: () => Get.toNamed("/DefendencyManagePage"), // 정말 무지하게 간단하긴하다.
            ),
            ElevatedButton(
              child: Text("의존성 관리 Binding 공부"),
              onPressed: () => Get.toNamed("/BindingPage"), // 정말 무지하게 간단하긴하다.
            ),
            ElevatedButton(
              child: Text("의존성 관리 Binding implements Bindings"),
              onPressed: () => Get.toNamed("/BindingPageImplementsBindings",), // 정말 무지하게 간단하긴하다.

            ),
            ElevatedButton(
              child: Text("Difference Between GetX and GetService"),
              onPressed: () => Get.toNamed("/DifferenceBetweenGetXAndGetService",), // 정말 무지하게 간단하긴하다.

            ),
            ElevatedButton(
              child: Text("Get.to 라우트"),
              onPressed: () => Get.to(() => FirstNamedPage()), // 정말 무지하게 간단하긴하다.
            ),
            ElevatedButton(
              child: Text("Get.toNamed 라우트"),
              onPressed: () => Get.toNamed("/FirstNamedPage"), // 정말 무지하게 간단하긴하다.
            ),
          ],
        ),
      ),
    );
  }
}
