import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/controller/CountControllerWithGetX.dart';

class BindingPage extends GetView<CountControllerWithGetX> { // 또다른 방법으로 GetView 를 사용하면 그냥 그자체의 controller 를 이용해서 불러올 수 있다.

//class BindingPage extends StatelessWidget {
  const BindingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BindingPage"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GetBuilder<CountControllerWithGetX>(builder:
            (countControllerWithGetX) {
              return Text("${countControllerWithGetX.count} 값이 증가하였습니다.");
            }
            ),
            ElevatedButton(onPressed: () {
              Get.find<CountControllerWithGetX>().increment();
            }, child: Text("뭘할까?")),
            ElevatedButton(onPressed: () {
              CountControllerWithGetX.to.increment(); // static 을 사용해서 이런식으로 접근할 수도 있다.
            }, child: Text("Static 버턴으로 만든것?")),
            ElevatedButton(onPressed: () {
              controller.increment(); // GetView<CountControllerWithGetX> 를 확장해서 이용하는 방법 간단히 controller 만 사용하면 된다.
            }, child: Text("Static 버턴으로 만든것?")),
          ],
        ),
      ),
    );
  }
}
