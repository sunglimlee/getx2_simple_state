import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 이걸 사용하면 계속 영구 유지가 된다고???? 좋네..
class GetXServiceTest extends GetxService {
  RxInt _count = 0.obs; // 이게 값을 공유하는 것 까지 되네.. 만약 새로운 변수를 만들면 내가 따로 쓸 수 있겠네..
  void increment() {
    _count++;
  }
  RxInt get count => _count;
  void clear() {Get.reset();}
}