import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/binding/BindingPageImplementsBindings.dart';
import 'package:getx2_simple_state/controller/CountControllerWithGetX.dart';
import 'package:getx2_simple_state/controller/CountControllerWithProvider.dart';
import 'package:getx2_simple_state/controller/DefendencyController.dart';
import 'package:getx2_simple_state/defendency/GetPut.dart';
import 'package:getx2_simple_state/screen/BindingPage.dart';
import 'package:getx2_simple_state/screen/DifferenceBetweenGetXAndGetService.dart';
import 'package:provider/provider.dart';
import 'defendency/DefendencyManagePage.dart';
import 'screen/FirstNamedPage.dart';
import 'screen/Home.dart';
import 'screen/SecondNamedPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // GetX 도 라우팅을 하게되면 상태가 새롭게 create 하게 되므로 여기 main 에다가 Get.put 을 넣으면 계속 유지가 된다.
    Get.put(CountControllerWithGetX()); // 이게 다야????
    // 라우팅을 하게되면 상태가 새롭게 create 하게 되므로 여기 main 에다가 Provider 를 넣으면 계속 유지가 된다.
    return ChangeNotifierProvider<CountControllerWithProvider>(
      create: (context) => CountControllerWithProvider(),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: Home(), // named route 를 할거기 때문에 더이상 필요가 없다.
        initialRoute: "/", // 이렇게 해주어야지 Getx 에서 named route 사용할 수 있다.
        getPages: [ // 위의 routes 의 기존 named 방법 대신 GetX 가 사용하는 방법, 추가로 애니메이션도 바꿀 수 있다.
          GetPage(name: "/", page: () => Home(),transition: Transition.zoom), // 애니메이션 사용하고 싶으면 위의 기존 routes 없애라. 충돌난다.
          GetPage(name: "/FirstNamedPage", page: () => FirstNamedPage(),),
          GetPage(name: "/SecondNamedPage", page: () => SecondNamedPage()),
          GetPage(name: "/DefendencyManagePage", page: () => DefendencyManagePage()),
          GetPage(name: "/GetPut", page: () => GetPut()),
          GetPage(name: "/BindingPage", page: () => BindingPage(), // named 는 여기에서 처음부터 Binding 을 할 수가 있다.
              binding: BindingsBuilder(() {
                Get.create<CountControllerWithGetX>(() {
                  return CountControllerWithGetX();});})
              ),
          GetPage(name: "/BindingPageImplementsBindings", page: () => BindingPage(), // named 는 여기에서 처음부터 Binding 을 할 수가 있다.
              binding: BindingsBuilder(() {
                Get.create<BindingPageImplementsBindings>(() {
                  return BindingPageImplementsBindings();});})
          ),
          GetPage(name: "/DifferenceBetweenGetXAndGetService", page: () => DifferenceBetweenGetXAndGetService()),
        ],
      ),
    );
  }
}
