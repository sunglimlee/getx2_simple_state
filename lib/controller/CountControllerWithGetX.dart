import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountControllerWithGetX extends GetxController {
  
  static CountControllerWithGetX get to => Get.find();// Get.find 사용이 귀찮고 거의 대부분 싱글톤으로 사용되기 때문에 이렇게 사용하고
  int _count = 0; // 이게 값을 공유하는 것 까지 되네.. 만약 새로운 변수를 만들면 내가 따로 쓸 수 있겠네..
  void increment({whichOne = null}) {
    _count++;
    if (whichOne == null) {
      update();
    } else {
      update([whichOne]);
    }
  }
  int get count => _count;
}