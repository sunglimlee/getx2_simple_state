import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum NUM {first, second}

class User{
  String name;
  User(this.name);
}

// reactive GetX 는 GetxController 에서 상속받지 않아도 되고 하나하나를 스트림을 이용해서 옵져버를 만들 수 있다.
// 그렇지만 상속 받을 수 있네.
class CountControllerWithReactiveGetX extends GetxController { // 이 클래스 스스로가 반응형 상태관리가 되는거다.
  RxInt _count = 0.obs; // obs 옵져버블로 등록하고 대신 RxInt 로 등록해준다. 끝.
  RxDouble _double = 0.0.obs;
  RxString _string = "".obs;
  Rx<NUM> _num = NUM.first.obs;
  Rx<User> _user = User("steve").obs;
  RxList<String> _list = <String>[].obs; // 이게 이렇게 할 수 있구나.


  void increment() {
    _count++;
    _user.update((user) { user!.name = "스티브";} ); // 이렇게 객체를 생성해서 리액티브 상태관리를 할 수 있구나.
    _list.addAll(["aa", "bb", "cc"]);
    _list.add("애드를 스트링 리스트에 추가");
    _list.addIf(_user.value.name == "스티브", "스티브를 스트링 리스트에 추가");

  } // update 도 안쓰네.
  RxInt get count => _count;
  Rx<User> get getUser => _user;
  RxList<String> get getList => _list;

  void putNumber(int value) {
    _count(value); // 이게 무슨뜻이지? 5로 바꾸라고 했는데... // 숫자 5로 바뀔때 한번만 호출하고 그다음부터는 호출하지 않는다.
  }

  @override
  void onInit() { // 여기보다시피 GetxController 를 상속받아서 ever 함수를 이용해서 RxInt 값을 listening 하고 있다가 변경될 때 마다 호출한다.
    ever(_count, (callback) => print("매번호출"));
    once(_count, (callback) => print("한번만 호출"));
    // debounce 는 사용자의 입력이 끝났을 때 같은 경우 바로 검색에 들어가도록 해주는 함수이다. 아주 괜찮네..
    // 키를 계속 입력하고 있는 상태에서는 debounce 가 일어나지 않고 있다가 입력이 일정시간동안 일어나지 않으면 debounce 가 호출된다는 거지.
    debounce(_count, (callback) => print("디바운스 맨마지막에 한번만 호출"), time: Duration(seconds: 1));
    // 변경되고 있는 1초마다 호출되도록 하는것.
    interval(_count, (callback) => print("변경되고 잇는 1초마다 호출"), time: Duration(seconds: 1));
  }
}