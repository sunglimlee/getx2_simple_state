import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/controller/DefendencyController.dart';
import 'package:getx2_simple_state/defendency/GetCreate.dart';
import 'package:getx2_simple_state/defendency/GetLazyPut.dart';
import 'package:getx2_simple_state/defendency/GetPut.dart';

import 'GetPutAsync.dart';

class DefendencyManagePage extends StatelessWidget {
  const DefendencyManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("의존성 주입: Get.to 에서 BindingBuilder 로 의존성 넘기기"),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(child: Text("Getput"),onPressed: (){
            Get.to(() => GetPut(), binding: BindingsBuilder(() { Get.put(DefendencyController()); }),); // 이게 의존성 주입이라는거네..
            // 실제로 사용할 페이지로 갈때 컨트롤로를 같이 바인딩 해줌으로써 의존성 주입을 한다는거다.
          },),
          ElevatedButton(child: Text("의존성 주입: Get.lazyPut"),onPressed: (){
            // 이렇게 하면 컨트롤러를 직접사용할 그때에 메모리에 올라가게 된다.
            Get.to(() => GetLazyPut(), binding: BindingsBuilder(() {Get.lazyPut<DefendencyController>(() => DefendencyController());}), );
          },),
          ElevatedButton(child: Text("의존성 주입 : Get.putAsync"),onPressed: (){
            // 이렇게 하면 비동기화 작업을 하면서 의존성 주입을 할 때 사용한다.
            Get.to(() => GetPutAsync(), binding: BindingsBuilder(() {
              Get.putAsync<DefendencyController>(() async {
                await Future.delayed(Duration(seconds: 5));
                return DefendencyController();});}),);
          },),
          ElevatedButton(child: Text("의존성 주입: Get.create"),onPressed: (){
            // 이렇게 하면 여러개가 계속 생성된다. 즉 Singleton 방식이 아니라 멀티로 생성된다는 뜻. um... 계속 만들어지는구나.
            Get.to(() => GetCreate(), binding: BindingsBuilder(() {
              Get.create<DefendencyController>(() {
                return DefendencyController();});}),);

          },),
        ],
      ),
      ),
    );
  }
}
