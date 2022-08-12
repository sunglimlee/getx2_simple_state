import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/controller/CountControllerWithGetX.dart';
import 'package:getx2_simple_state/controller/GetXServiceTest.dart';

/*
이렇게 Defendency 주입에 대해서 실컷 배웠지만 기존의 방법은 여전히 윗단에다가 Controller 를 만들어놓고 그걸 불러들여서 사용해야지만
계속 앱의 켜져있을 때 값이 유지될 수 있게 할 수 있다.
Get.put(GetXControllerWithGetX(), permanent: true);
그렇지만 Service 를 사용하면 달라진다.


 */
class GetXServiceWidget extends StatelessWidget { // 또다른 방법으로 GetView 를 사용하면 그냥 그자체의 controller 를 이용해서 불러올 수 있다.
  const GetXServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetX Service Page"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => Text("${Get.find<GetXServiceTest>().count.value.toString()}", style: TextStyle(fontSize: 30),)),
            ElevatedButton(onPressed: () {
              Get.find<GetXServiceTest>().increment();
            }, child: Text("값을 증가시키자")),
            ElevatedButton(onPressed: () {
              Get.find<GetXServiceTest>().clear(); // 메모리에서 모든 컨트롤러를 다지워버린다.
            }, child: Text("컨틀롤러 메모리에서 지워줘. GetX.reset()")),
          ],
        ),
      ),
    );
  }
}
