import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/controller/CountControllerWithGetX.dart';
import 'package:getx2_simple_state/controller/CountControllerWithProvider.dart';
import 'package:getx2_simple_state/controller/CountControllerWithReactiveGetX.dart';
import 'package:getx2_simple_state/screen/Home.dart';
import 'package:getx2_simple_state/state/WithGetX.dart';
import 'package:getx2_simple_state/state/WithProvider.dart';
import 'package:provider/provider.dart';

class ReactiveStateManagePage extends StatelessWidget {
  const ReactiveStateManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CountControllerWithReactiveGetX());
    // 테스트 차원에서 여기다가 GetX 객체를 생성해보자.
    return Scaffold(
      appBar: AppBar(
        title: const Text("반응형 상태 관리"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("GetX Reactive", style: TextStyle(fontSize: 30.0),),
            Obx(() => // 바로 반응할 수 있도록 Obx 로 감싼다. 그럼 이부분만 새로 고쳐진다는 거네.
            Text(
              // 이건 마치 Consumer 처럼 반응하는거네.. GetBuilder 사용이랑 비슷하긴한데.. obx 라고 한다는 거지.
            "${Get.find<CountControllerWithReactiveGetX>().count.value} \n"
                "${Get.find<CountControllerWithReactiveGetX>().getUser.value.name} \n"
                "${Get.find<CountControllerWithReactiveGetX>().getList.value}"
              ,
            style: TextStyle(fontSize: 50.0),),
            ),
/*
            GetX(// 또는 GetX 를 사용해서 Obx 와 똑같이 구현할 수 있다.
                builder: (_) {
                return Text(
                // 이건 마치 Consumer 처럼 반응하는거네.. GetBuilder 사용이랑 비슷하긴한데.. obx 라고 한다는 거지.
                "${Get.find<CountControllerWithReactiveGetX>().count.value}",
                style: TextStyle(fontSize: 50.0));
              },),
*/
        ElevatedButton( // id 를 부여해서 버턴을 다로 연결하는게 가능해진다.
          onPressed: () { // 여기도 여전히 listen : false 기능이 들어가야 되는거 아냐???????
            Get.find<CountControllerWithReactiveGetX>().increment(); //기억나지? 만약에 위에서 바로 Get.put 을 사용하고 변수에 등록하면 find 사용할 필요없다는것.
            //countGetX.increment();
          },
          child: const Text("+", style: TextStyle(fontSize: 30, color: Colors.red),),
        ),
            ElevatedButton( // id 를 부여해서 버턴을 다로 연결하는게 가능해진다.
              child: const Text("5로 변경", style: TextStyle(fontSize: 30, color: Colors.red),),
              onPressed: () { // 여기도 여전히 listen : false 기능이 들어가야 되는거 아냐???????
                Get.find<CountControllerWithReactiveGetX>().putNumber(5); //기억나지? 만약에 위에서 바로 Get.put 을 사용하고 변수에 등록하면 find 사용할 필요없다는것.
                //countGetX.increment();
              },
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
