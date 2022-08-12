import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CountControllerWithProvider extends ChangeNotifier {
  int _count = 0; // 초기화를 안해주었구나. 항상 초기화를 해주도록 하자. 되도록이면 초기화 해주면 null 에 대한 문제가 없잖아.
  int get count => _count;
  increment() {
    _count++;
    notifyListeners();
  }
}