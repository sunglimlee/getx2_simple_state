
## GetX 란?
GetX 는 미니 프레임 워크이다. 생산성, 성능, 조직화(MVC, MVVM 즉 Clean Code)


## 설정방법
###### pubspec.yaml 에서
dependencies :
get: ^3.24.0

###### main.dart 에서
void main() => runApp(GetMaterialApp(home: Home())); // 상태관리만 사용한다면 GetMaterialApp 을 사용하지 않아도 된다.



# 라우트 관리
- 기본 페이지 라우팅(기존 Navigator 와 GetX route 차이)
- Named 페이지 라우팅 (기존 Navigator 와 GetX route 차이)
- 페이지 전화 효과 적용 (Transition)
- arguments 전달 (데이터를 전달할 때)
- parameters 동적 링크 적용 (페이지에 해당하는 값을 전달할 때)

## 기본 페이지 라우팅
- 기존 Navigator
```
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => FirstPage()));
  Navigator.of(context).pop(); // 뒤로가기
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => Home()), (route)=> false;
- GetX route
  Get.to(FirstPage());
  Get.back(); // 뒤로가기
  Get.offAll(Home()); // 이게 문제가 뭐냐면 Home() 이 새롭게 생성된다는 점이다. NamedTo 를 사용하면 그럴일이 없지.
```
## Named 페이지 라우팅
- 기존 방식 GetMaterialApp at main.dart
```
  // initialRoute: "/" 밑에서 route 에서 "/" 를 정의하면 이부분은 필요없슴
  route: {
  "/" : (context)=> Home(),
  "/FirstNamedPage" : (context) => FirstNamedPage(),
  "/SecondNamedPage" : (context) => SecondNamedPage(),
```
- 파일에서 사용할 때
```
  Navigatorof(context)pushNamed("/FirstNamedPage");
```
- GetX in GetMaterialApp at main.dart
```
  getPages: [
  GetPage(name: "/", page: ()=> Home()),
  GetPage(name: "/FirstNamePage", page: ()=> FirstNamedPage()),
  GetPage(name: "/SecondNamePage", page: ()=> SecondNamedPage()),
  ],
```
- 파일에서 사용할 때
```
  Get.toNamed("/FirstNamedPage");
  Get.offNamed("/SecondNamedPage"); // 현재 페이지를 없애고 두번째 페이지로 가자.
  Get.offAllNamed("/");
```
## 페이지 전화 효과 적용 (Transition)
- GetMaterialApp 에서
```
  GetPage(name: "/", page: () => Home(), transition: Transition.zoom), // 여러가지가 있다.
```
## argument 전달
- 보내는곳에서
```
  Get.toNamed("/next, arguments: "개남");
  Get.toNamed("/next, arguments: 3);
  Get.toNamed("/NextNamedPage", arguments: ["개남", "스티브"], ),
  Get.toNamed("/NextNamedPage", arguments: [ {"name": "개남", "age": 52} ], ), // 맵을 보낼 때
  onPressed: () => Get.toNamed("/NextNamedPage", arguments: [User(name: "스티브", age: 52) ], ), // User class 보낼 때
```
- 받는곳에서
```
  ${Get.arguments}
  Text("전달받은 데이터는 : ${Get.arguments[0].toString()}"),
  Text("전달받은 데이터는 : ${Get.arguments[0]["age"]}"), // 맵을 보냈을 때 받는법
  Text("전달받은 데이터는 : ${(Get.arguments as User).age}"), // User class 받을 때, 새로 시작해라. 안그러면 오류나더라.
  Text("전달받은 데이터는 : ${(Get.arguments[0] as User).name}"), // User class 리스트로 받을 때, 새로 시작해라. 안그러면 오류나더라.
```

## url parameter 전달
- 먼저 이렇게 세팅하고
```
  GetPage(name: "/UserNamedPage/:uid", page: () => UserNamedPage()), // 파라미터 넘길때, 웹페이지처럼 UserId 를 넘길 때
```
- 보내는곳에서
```
  onPressed: () => Get.toNamed("/UserNamedPage/28357"),
```
- 받는곳에서
```
  Text("${Get.parameters['uid']}"),
```
- 보내는곳에서
```
  onPressed: () => Get.toNamed("/UserNamedPage/28357?name=개남&age=22"),
```
- 받는곳에서
```
  Text("${Get.parameters['uid']}"),
  Text("${Get.parameters['name']}님 안녕하세요."),
  Text("${Get.parameters['age']}살 이시군요."),
```


# 상태관리 (기본적으로 Model, View, Controller 방식으로 따라가도록 하자.)
- 단순 상태관리
- 단순 상태관리 ID 넣어주는 방식 (각각의 버턴들과 값변경부분들을 id 로 정해줄 수 있다는것)
- 반응형 상태관리

## 단순 상태관리 (값이 변화할 때마다 계속 화면 업데이트가 일어난다. 별로 않좋다.)
###### 기존 provider 방식
- 전역으로 설정할건지 지역적으로 설정할 건지 정해놓고
``` 
return ChangeNotifierProvider<CountControllerWithProvider>(
      create: (context) => CountControllerWithProvider(),
      child: GetMaterialApp(),);
```
-컨트롤러부분
``` 
class CountControllerWithProvider extends ChangeNotifier { // controller 를 ChangeNotifier 에서 확장하도록 한다.
   int _count = 0; // 초기화를 안해주었구나. 항상 초기화를 해주도록 하자. 되도록이면 초기화 해주면 null 에 대한 문제가 없잖아.
   int get count => _count;
   increment() {
      _count++;
      notifyListeners(); // 값이 변경되었을 때 notifyListeners() 꼭 해주도록
   }
}
```
- view 부분에서 변경되는부분
``` 
Consumer<CountControllerWithProvider>( // Consumer 가 Widget 을 리턴하기 때문에 child 를 사용할 필요가 지금은 없다.
                builder: (context, value, child) {
                  return Text(value.count.toString(),  style: TextStyle(fontSize: 20, color: Colors.red));
                }),
```
- view 부분에서 변경시키는부분
``` 
countControllerWithProvider = Provider.of<CountControllerWithProvider>(context, listen: false); // 기억하자 listen : false 중요하다.
onPressed: () {countControllerWithProvider.increment();},

```

###### GetX 방식
- 전역으로 설정할건지 지역적으로 설정할 건지 정해놓고
``` 
    Get.put(CountControllerWithGetX()); // 이게 다야???? 둘러싸주고 뭐 그런것도 없다.
```
- 컨트롤러 부분에서
``` 
class CountControllerWithGetX extends GetxController {
  int _count =0;
  void increment() {_count++; update();}
```
- view 부분에서 변경되는부분
``` 
GetBuilder<CountControllerWithGetX>(builder: (controller) { // 이게 마치 Consumer 를 사용한 것 같은 느낌.
  return Text(controller.count.toString(),  style: TextStyle(fontSize: 20, color: Colors.red),);

```
- view 부분에서 변경시키는부분
``` 
onPressed: () { // 여기도 여전히 listen : false 기능이 들어가야 되는거 아냐???????
  Get.find<CountControllerWithGetX>().increment(); },
```

## 단순상태관리 with ID
- 컨트롤러 부분에서
```  
class CountControllerWithGetX extends GetxController {
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
```
- view 부분에서 변경되는부분
``` 
GetBuilder<CountControllerWithGetX>(id: "second", builder: (controller) { // 이게 마치 Consumer 를 사용한 것 같은 느낌.
  return Text(controller.count.toString(),  style: TextStyle(fontSize: 20, color: Colors.red),);
```
- view 부분에서 변경시키는부분
``` 
onPressed: () { // 여기도 여전히 listen : false 기능이 들어가야 되는거 아냐???????
  Get.find<CountControllerWithGetX>().increment(whichOne:  "second");  }, //기억나지? 만약에 위에서 바로 Get.put 을 사용하고 변수에 등록하면 find 사용할 필요없다는것.
```

## 반응형 상태관리 (값이 변화할 때만 화면 업데이트가 일어난다.)
###### obx, GetX 둘다 사용방법
- 전역으로 설정할건지 지역적으로 설정할 건지 정해놓고
``` 
    Get.put(CountControllerWithReactiveGetX());
```
- 컨트롤러 부분에서
``` 
class CountControllerWithReactiveGetX extends GetxController { // 이 클래스 스스로가 반응형 상태관리가 되는거다. GetxController 안넣어도된다.
  RxInt _count = 0.obs; // obs 옵져버블로 등록하고 대신 RxInt 로 등록해준다. 끝.
  void increment() {
    _count++; // update() 도 필요없다.
  }
  RxInt get count => _count;

}
```
- view 부분에서 변경되는 부분 (obx 를 사용할 때)
``` 
Obx(() => Text("${Get.find<CountControllerWithReactiveGetX>().count.value.toString()}", style: TextStyle(fontSize: 30),)), 
```
- view 부분에서 변경되는 부분 (GetX 를 사용할 때)
``` 
GetX(builder: (_) { return Text( // 이건 마치 Consumer 처럼 반응하는거네.. GetBuilder 사용이랑 비슷하긴한데.. obx 라고 한다는 거지.
  "${Get.find<CountControllerWithReactiveGetX>().count.value}",
  style: TextStyle(fontSize: 50.0));  },),
```
- view 부분에서 변경시키는 부분
``` 
ElevatedButton(onPressed: () {
  Get.find<CountControllerWithReactiveGetX>().increment(); // 메모리에서 모든 컨트롤러를 다지워버린다.
  }, child: Text("")),       
```
- [그렇다면 언제 GetBuilder, GetX, Obx 를 사용할까?](https://softwarezay.com/notes/462_flutter-getx-getbuilder-getx-obx-which-one-to-choose)

###### 값이 변화할 때만 화면이 업데이트가 된다. 5를 넣어서 테스트해보자.
- 컨트롤러 부분에서 (값이 변화할 때만 화면 업데이트가 일어난다.)
``` 
class CountControllerWithReactiveGetX extends GetxController { // 이 클래스 스스로가 반응형 상태관리가 되는거다. GetxController 안넣어도된다.
  RxInt _count = 0.obs; // obs 옵져버블로 등록하고 대신 RxInt 로 등록해준다. 끝.
  void putNumber(int value) {
    _count(value); // 이렇게 괄호안에 넣어야 하는구나. 5로 바꾸라고 했는데... // 숫자 5로 바뀔때 한번만 호출하고 그다음부터는 호출하지 않는다.
  }
}
```
- view 부분에서 변경시키는 부분
``` 
ElevatedButton( // id 를 부여해서 버턴을 다로 연결하는게 가능해진다.
  child: const Text("5로 변경", style: TextStyle(fontSize: 30, color: Colors.red),),
  onPressed: () { // 여기도 여전히 listen : false 기능이 들어가야 되는거 아냐???????
    Get.find<CountControllerWithReactiveGetX>().putNumber(5); //기억나지? 만약에 위에서 바로 Get.put 을 사용하고 변수에 등록하면 find 사용할 필요없다는것.
  },),
```









# 종속성 관리







# The largest heading
## The second largest heading
###### The smallest heading

1. First list item
   - First nested list item
      - Second nested list item


> Text that is a quote

**This is bold text**
*This text is italicized*
~~This was mistaken text~~
**This text is _extremely_ important**
***All this text is important***
<sub>This is a subscript text</sub>  
<sup>This is a superscript text</sup>

Use `git status` to list all new or modified files that haven't yet been committed.  // Quoting Code

Some basic Git commands are:
``` 
git status
git add
git commit
```

![This is an image](https://myoctocat.com/assets/images/base-octocat.svg)

# getx1_route1

getx with route

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
