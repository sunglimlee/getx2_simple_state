import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/controller/CountControllerWithGetX.dart';

class WithGetX extends StatelessWidget {
  const WithGetX({Key? key}) : super(key: key);
  //var countGetX = Get.put(CountControllerWithGetX()); // 이게 다야????

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text("GetX",  style: TextStyle(fontSize: 20, color: Colors.red),),
        // 그래서 이것도 여전히 Consumer 처럼 여기만 다시 빌드가 되는건가? Provider 와 거의 똑같은데???
        GetBuilder<CountControllerWithGetX>(id: "first", builder: (controller) { // 이게 마치 Consumer 를 사용한 것 같은 느낌.
          return Text(controller.count.toString(),  style: TextStyle(fontSize: 20, color: Colors.red),);
        }),
        GetBuilder<CountControllerWithGetX>(id: "second", builder: (controller) { // 이게 마치 Consumer 를 사용한 것 같은 느낌.
          return Text(controller.count.toString(),  style: TextStyle(fontSize: 20, color: Colors.red),);
        }),
        ElevatedButton( // id 를 부여해서 버턴을 다로 연결하는게 가능해진다.
          onPressed: () { // 여기도 여전히 listen : false 기능이 들어가야 되는거 아냐???????
            Get.find<CountControllerWithGetX>().increment(whichOne: "first"); //기억나지? 만약에 위에서 바로 Get.put 을 사용하고 변수에 등록하면 find 사용할 필요없다는것.
            //countGetX.increment();
          },
          child: const Text("+ for first", style: TextStyle(fontSize: 20, color: Colors.red),),
        ),
        ElevatedButton(
          onPressed: () { // 여기도 여전히 listen : false 기능이 들어가야 되는거 아냐???????
            Get.find<CountControllerWithGetX>().increment(whichOne:  "second"); //기억나지? 만약에 위에서 바로 Get.put 을 사용하고 변수에 등록하면 find 사용할 필요없다는것.
            //countGetX.increment();
          },
          child: const Text("+ for second", style: TextStyle(fontSize: 20, color: Colors.red),),
        ),
      ],)
    );
  }
}
