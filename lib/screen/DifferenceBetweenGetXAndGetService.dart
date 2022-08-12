import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/controller/CountControllerWithGetX.dart';
import 'package:getx2_simple_state/controller/GetXServiceTest.dart';
import 'package:getx2_simple_state/screen/GetXControllerWidget.dart';
import 'package:getx2_simple_state/screen/GetXServiceWidget.dart';

class DifferenceBetweenGetXAndGetService extends StatelessWidget {
  const DifferenceBetweenGetXAndGetService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: () {
            Get.to(GetXControllerWidget(), binding: BindingsBuilder(() {Get.lazyPut<CountControllerWithGetX>(() => CountControllerWithGetX());}));
          }, child: Text("Get X Controller")),
          ElevatedButton(onPressed: () { // 앱이 처음부터 끝까지 유지되어야 하는 상황에서는 어떻게 해야 되나?????
            Get.to(GetXServiceWidget(), binding: BindingsBuilder(() {Get.lazyPut<GetXServiceTest>(() => GetXServiceTest());}));

          }, child: Text("Get X Service")),

        ],
      ),
    );
  }
}
