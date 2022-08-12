import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/controller/CountControllerWithGetX.dart';
import 'package:getx2_simple_state/controller/DefendencyController.dart';

class BindingPageImplementsBindings implements Bindings {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dependencies() {
    Get.put(CountControllerWithGetX()); // 이렇게 의존성 주입을 해줄 수 도 있구나.. 그럼 총 3가지로 되는건가? 왜이렇게 많은 방법을 만들어놨지?
  }
}
