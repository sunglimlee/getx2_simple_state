
# GetX 란?
> GetX 는 미니 프레임 워크이다. 생산성, 성능, 조직화(MVC, MVVM 즉 Clean Code)
- 라우트 관리
- 상태관리, State Management
- 종속성 관리, Dependency Injection (Get.to 할 때)
- 종속성 관리, Binding (라우트 설정부분에서도 할 수 있다. 똑같다. 단지 Route 에 해준다는것)
- 기타 유용한 기능
- GetX Service



## 설정방법
###### pubspec.yaml 에서
dependencies :
get: ^3.24.0

###### main.dart 에서
```dart
void main() => runApp(GetMaterialApp(home: Home())); // 상태관리만 사용한다면 GetMaterialApp 을 사용하지 않아도 된다.
```



# 라우트 관리
- 기본 페이지 라우팅(기존 Navigator 와 GetX route 차이)
- Named 페이지 라우팅 (기존 Navigator 와 GetX route 차이)
- 페이지 전화 효과 적용 (Transition)
- arguments 전달 (데이터를 전달할 때)
- parameters 동적 링크 적용 (페이지에 해당하는 값을 전달할 때)

## 기본 페이지 라우팅
###### 기존 Navigator
```dart
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => FirstPage()));
  Navigator.of(context).pop(); // 뒤로가기
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => Home()), (route)=> false;
```
###### GetX route
```dart
  Get.to(FirstPage());
  Get.back(); // 뒤로가기
  Get.offAll(Home()); // 이게 문제가 뭐냐면 Home() 이 새롭게 생성된다는 점이다. NamedTo 를 사용하면 그럴일이 없지.
```
###### Named 페이지 라우팅
- 기존 방식 GetMaterialApp at main.dart
```dart
  // initialRoute: "/" 밑에서 route 에서 "/" 를 정의하면 이부분은 필요없슴
  route: {
  "/" : (context)=> Home(),
  "/FirstNamedPage" : (context) => FirstNamedPage(),
  "/SecondNamedPage" : (context) => SecondNamedPage(),
```
- 파일에서 사용할 때
```dart
  Navigator.of(context).pushNamed("/FirstNamedPage");
```

- GetX in GetMaterialApp at main.dart
```dart
  getPages: [
  GetPage(name: "/", page: ()=> Home()),
  GetPage(name: "/FirstNamePage", page: ()=> FirstNamedPage()),
  GetPage(name: "/SecondNamePage", page: ()=> SecondNamedPage()),
  ],
```
- 파일에서 사용할 때
```dart
  Get.toNamed("/FirstNamedPage");
  Get.offNamed("/SecondNamedPage"); // 현재 페이지를 없애고 두번째 페이지로 가자.
  Get.offAllNamed("/");
```

## 페이지 전화 효과 적용 (Transition)
- GetMaterialApp 에서
```dart
  GetPage(name: "/", page: () => Home(), transition: Transition.zoom), // 여러가지가 있다.
```

## argument 전달
- 보내는곳에서
```dart
  Get.toNamed("/next", arguments: "개남");
  Get.toNamed("/next", arguments: 3);
  Get.toNamed("/NextNamedPage", arguments: ["개남", "스티브"], ),
  Get.toNamed("/NextNamedPage", arguments: [ {"name": "개남", "age": 52} ], ), // 맵을 보낼 때
  onPressed: () => Get.toNamed("/NextNamedPage", arguments: [User(name: "스티브", age: 52) ], ), // User class 보낼 때
```
- 받는곳에서
```dart
  ${Get.arguments}
  Text("전달받은 데이터는 : ${Get.arguments[0].toString()}"),
  Text("전달받은 데이터는 : ${Get.arguments[0]["age"]}"), // 맵을 보냈을 때 받는법
  Text("전달받은 데이터는 : ${(Get.arguments as User).age}"), // User class 받을 때, 새로 시작해라. 안그러면 오류나더라.
  Text("전달받은 데이터는 : ${(Get.arguments[0] as User).name}"), // User class 리스트로 받을 때, 새로 시작해라. 안그러면 오류나더라.
```

## url parameter 전달
- 먼저 이렇게 세팅하고
```dart
  GetPage(name: "/UserNamedPage/:uid", page: () => UserNamedPage()), // 파라미터 넘길때, 웹페이지처럼 UserId 를 넘길 때
```
- 보내는곳에서
```dart
  onPressed: () => Get.toNamed("/UserNamedPage/28357"),
```
- 받는곳에서
```dart
  Text("${Get.parameters['uid']}"),
```
- 보내는곳에서
```dart
  onPressed: () => Get.toNamed("/UserNamedPage/28357?name=개남&age=22"),
```
- 받는곳에서
```dart
  Text("${Get.parameters['uid']}"),
  Text("${Get.parameters['name']}님 안녕하세요."),
  Text("${Get.parameters['age']}살 이시군요."),
```


# 상태관리 (기본적으로 Model, View, Controller 방식으로 따라가도록 하자.)
- 단순 상태관리
- 단순 상태관리 ID 넣어주는 방식 (각각의 버턴들과 값변경부분들을 id 로 정해줄 수 있다는것)
- 반응형 상태관리
- 이벤트 트리거
- Rx type

## 단순 상태관리 (값이 변화할 때마다 계속 화면 업데이트가 일어난다. 별로 않좋다.)

###### 기존 provider 방식
- 전역으로 설정할건지 지역적으로 설정할 건지 정해놓고
```dart
return ChangeNotifierProvider<CountControllerWithProvider>(
      create: (context) => CountControllerWithProvider(),
      child: GetMaterialApp(),);
```
- 컨트롤러부분
```dart
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
```dart
Consumer<CountControllerWithProvider>( // Consumer 가 Widget 을 리턴하기 때문에 child 를 사용할 필요가 지금은 없다.
                builder: (context, value, child) {
                  return Text(value.count.toString(),  style: TextStyle(fontSize: 20, color: Colors.red));
                }),
```
- view 부분에서 변경시키는부분
```dart
countControllerWithProvider = Provider.of<CountControllerWithProvider>(context, listen: false); // 기억하자 listen : false 중요하다.
onPressed: () {countControllerWithProvider.increment();},
```

###### GetX 방식
- 전역으로 설정할건지 지역적으로 설정할 건지 정해놓고
```dart
    Get.put(CountControllerWithGetX()); // 이게 다야???? 둘러싸주고 뭐 그런것도 없다.
```
- 컨트롤러 부분에서
```dart
class CountControllerWithGetX extends GetxController {
  int _count =0;
  void increment() {_count++; update();}
```
- view 부분에서 변경되는부분
```dart
GetBuilder<CountControllerWithGetX>(builder: (controller) { // 이게 마치 Consumer 를 사용한 것 같은 느낌.
  return Text(controller.count.toString(),  style: TextStyle(fontSize: 20, color: Colors.red),);
```
- view 부분에서 변경시키는부분
```dart
onPressed: () { // 여기도 여전히 listen : false 기능이 들어가야 되는거 아냐???????
  Get.find<CountControllerWithGetX>().increment(); },
```

## 단순상태관리 with ID
- 컨트롤러 부분에서
```dart
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
```dart
GetBuilder<CountControllerWithGetX>(id: "second", builder: (controller) { // 이게 마치 Consumer 를 사용한 것 같은 느낌.
  return Text(controller.count.toString(),  style: TextStyle(fontSize: 20, color: Colors.red),);
```
- view 부분에서 변경시키는부분
```dart
onPressed: () { // 여기도 여전히 listen : false 기능이 들어가야 되는거 아냐???????
  Get.find<CountControllerWithGetX>().increment(whichOne:  "second");  }, //기억나지? 만약에 위에서 바로 Get.put 을 사용하고 변수에 등록하면 find 사용할 필요없다는것.
```

## 반응형 상태관리 (값이 변화할 때만 화면 업데이트가 일어난다.)
###### obx, GetX 둘다 사용방법
- 전역으로 설정할건지 지역적으로 설정할 건지 정해놓고
```dart
    Get.put(CountControllerWithReactiveGetX());
```
- 컨트롤러 부분에서
```dart
class CountControllerWithReactiveGetX extends GetxController { // 이 클래스 스스로가 반응형 상태관리가 되는거다. GetxController 안넣어도된다.
  RxInt _count = 0.obs; // obs 옵져버블로 등록하고 대신 RxInt 로 등록해준다. 끝.
  void increment() {
    _count++; // update() 도 필요없다.
  }
  RxInt get count => _count;
}
```
- view 부분에서 변경되는 부분 (obx 를 사용할 때)
```dart
Obx(() => Text("${Get.find<CountControllerWithReactiveGetX>().count.value.toString()}", style: TextStyle(fontSize: 30),)), 
```
- view 부분에서 변경되는 부분 (GetX 를 사용할 때)
```dart
GetX(builder: (_) { return Text( // 이건 마치 Consumer 처럼 반응하는거네.. GetBuilder 사용이랑 비슷하긴한데.. obx 라고 한다는 거지.
  "${Get.find<CountControllerWithReactiveGetX>().count.value}",
  style: TextStyle(fontSize: 50.0));  },),
```
- view 부분에서 변경시키는 부분
```dart
ElevatedButton(onPressed: () {
  Get.find<CountControllerWithReactiveGetX>().increment(); // 메모리에서 모든 컨트롤러를 다지워버린다.
  }, child: Text("")),       
```
- [그렇다면 언제 GetBuilder, GetX, Obx 를 사용할까?](https://softwarezay.com/notes/462_flutter-getx-getbuilder-getx-obx-which-one-to-choose)

###### 값이 변화할 때만 화면이 업데이트가 된다. 5를 넣어서 테스트해보자.
- 컨트롤러 부분에서 (값이 변화할 때만 화면 업데이트가 일어난다.)
```dart
class CountControllerWithReactiveGetX extends GetxController { // 이 클래스 스스로가 반응형 상태관리가 되는거다. GetxController 안넣어도된다.
  RxInt _count = 0.obs; // obs 옵져버블로 등록하고 대신 RxInt 로 등록해준다. 끝.
  void putNumber(int value) {
    _count(value); // 이렇게 괄호안에 넣어야 하는구나. 5로 바꾸라고 했는데... // 숫자 5로 바뀔때 한번만 호출하고 그다음부터는 호출하지 않는다.
  }
}
```
- view 부분에서 변경시키는 부분
```dart
ElevatedButton( // id 를 부여해서 버턴을 다로 연결하는게 가능해진다.
  child: const Text("5로 변경", style: TextStyle(fontSize: 30, color: Colors.red),),
  onPressed: () { // 여기도 여전히 listen : false 기능이 들어가야 되는거 아냐???????
    Get.find<CountControllerWithReactiveGetX>().putNumber(5); //기억나지? 만약에 위에서 바로 Get.put 을 사용하고 변수에 등록하면 find 사용할 필요없다는것.
  },),
```
## 이벤트 트리거
###### 반응형일 때 이벤트에 따라 여러가지 기능을 구현할 수 있다. GetxController 를 상속받아야 한다.
```dart
class CountControllerWithReactiveGetX extends GetxController // 상속을 받게되면 GetxController 에는 라이프 사이클이 있다.
RxInt _count = 0.obs;
void increment() {}
onInit() { // 기억하자 obx 일때만 가능하다. 그리고 값이 변했을 때만 반응한다.
  ever(_count, (_) => print("매번호출")); // 잘봐라. _count 가 매번 바뀔때마다 이 함수가 실행된다.
  once(_count, (_) => print("한번만호출")); // 최초 한번만 변경되었을 때만 호출되고 그다음부터는 호출 안된다.
  // 검색할 때 키를 입력받고 있을 때 가만히 있다가 잠깐 텀을 주었을 때 데이터를 받아와서 리스트를 보여주고자 할 때 디바운스를 사용한다.
  debounce(_count, (_) => print("마지막 변경에 한번만 호출"), time: Duration(seconds: 1)); // 변경없다가 멈추고 1초이후에 마지막에 한번 호출
  interval(_count, (_) => print("변경될 동안 1초마다 호출")), time: Duration(second: 1)); 
  super.onInit();
}
onClose() {}
onDelete() {}
```

###### Rx Type 
```dart
enum NUM {FIRST, SECOND}
class User {
  String name; int age;
  User({this.name, this.age});
}
class CountControllerWithReactiveGetx extends GetxController
RxInt _count = 0.obs;
RxDouble double = 0.0.obs;
RxString string = "".obs; // 모든 타입이 다 있다.
Rx<NUM> nums = NUM.FIRST.obs; // enum type
Rx<User> user = User(name: "개남", age: 25).obs; // 데이터 클래스 타입
RxList<String> list = [""].obs; // 또는 <String>[].obs;

void increment() {
  count++;
  _double++;
  _double(424);
  nums(NUM.SECOND); // enum type 변경할 때
  user(user());
  user.update((_user) { _user.name = "스티브"; }); // 이렇게 update 를 사용할 수 있고, 함수로 데이터를 업데이트한다.
  list.addAll();
  list.add();
  list.addIf(user.vale.name == "스티브", "okay"); // 리스트는 자봐라.
}
```


# 종속성 관리 (Defendency Injection)
> 알다시피 메모리 절감을 위해서 사용하는 차원이고 계속 끌고가고 싶으면 GetxService 를 사용하도록 하자.
> 총 5가지의 방법이 있다.
1. 원래 방법대로 Get.put 을 이용해서 어디든지 넣어주는 방법
2. Get.to 페이지 전환하면서 binding 속성안에 Get.put 으로 넣어주는 방법
3. Get.to 페이지 전환하면서 binding 속성안에 Get.lazyPut 으로 넣어주는 방법
4. Get.to 페이지 전환하면서 binding 속성안에 Get.putAsync 으로 넣어주는 방법
5. Get.to 페이지 전환하면서 binding 속성안에 Get.create 으로 넣어주는방법 (인스턴스가 계속 생성된다. 위에거는 전부 싱글톤이지만 이건 아님.)

## 2. Get.to 페이지 전환하면서 binding 속성안에 Get.put 으로 넣어주는 방법
```dart
onPressed: () { // page mount 단계에서 할 수 있다. GetX 가 자동으로 생성과 파괴를 해준다.
  Get.to(GetPut(), binding: BindingsBuilder((){Get.put(DependencyController());}));
}
```

## 3. Get.to 페이지 전환하면서 binding 속성안에 Get.lazyPut 으로 넣어주는 방법
```dart
onPressed: () { // page mount 단계에서 할 수 있다. GetX 가 자동으로 생성과 파괴를 해준다.
  // GetLazyPut() 에서 Controller 에 접근하려고 할 때 메모리에 올리게 된다.
  Get.to(GetLazyPut(), binding: BindingsBuilder((){ Get.lazyPut<DependencyController>(()=>DependencyController() )   }));
}
```

## 4. Get.to 페이지 전환하면서 binding 속성안에 Get.putAsync 으로 넣어주는 방법
```dart
onPressed: () { // page mount 단계에서 할 수 있다. GetX 가 자동으로 생성과 파괴를 해준다.
// 비동기 방식, 뭔가 비동기 처리이후에 controller 에 접근하도록 할 때 사용한다
Get.to(GetPut(), binding: BindingsBuilder((){ Get.putAsync<DependencyController>(() async {
  await Future.delayed(Duration(seconds: 5)); 
  return DependencyController();} )   })); // 5초 이후에 컨트롤러가 생성된다.
}
```

## 5. Get.to 페이지 전환하면서 binding 속성안에 Get.create 으로 넣어주는방법 (인스턴스가 계속 생성된다. 위에거는 전부 싱글톤이지만 이건 아님.)
```dart
// 비동기 방식, 뭔가 비동기 처리이후에 controller 에 접근하도록 할 때 사용한다
Get.to(GetPut(), binding: BindingsBuilder((){ Get.create<DependencyController>(() {
  // 이것도 GetPut() 페이지에서 Controller 에 접근할 때 비로서 생성된다. 단 계속 새롭게 생성한다는 것
  return DependencyController();} )   })); // 5초 이후에 컨트롤러가 생성된다.
}
```
```dart
onPressed: () {
  print(Get.find<DependencyController>().hashCode); //*****
  Get.find<DependencyController>().increment(); 
}
```


# 종속성 관리 - Binding (라우트 설정부분에서도 할 수 있다.)
1. GetmaterialApp 내에서 getPages 안에 binding 하는 방법
2. Bindings 클래스를 상속받아서 getPages 안에 binding 하는 방법
3. Bindings 클래스를 상속받아서 GetxMaterialApp() 안에 'initBinding : InitBinding()',

## 1. GetmaterialApp 내에서 getPages 안에 binding 하는 방법
```dart
getPages: [
  GetPage(name: "/binding", page: ()=> BindingPage(), 
        // 완전히 똑같다. 생성될때 Controller 가 같이 생성되고 
        // 페이지에서 빠져 나올 때 Controller 가 자동 삭제된다.
        binding : bindingBuilder(() { Get.put(CountControllerWithGetX())  })),
        //binding: BindingBuilder( () { Get.lazyPut<CountControllerWithGetX>(()=> CountControllerWithGetX()); })),
],
```

## 2. Binding 클래스를 상속받아서 getPages 안에 binding 하는 방법
```dart
class BindingpageBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(CountControllerWithGetX());
  }
}
```
```dart
getPages: [
  GetPage(name: "/binding", page: ()=> BindingPage(), 
        // 완전히 똑같다. 생성될때 Controller 가 같이 생성되고 
        // 페이지에서 빠져 나올 때 Controller 가 자동 삭제된다.
        binding : BindingPageBindings()),
        //binding: BindingBuilder( () { Get.lazyPut<CountControllerWithGetX>(()=> CountControllerWithGetX()); })),
],
```

## 3. Binding 클래스를 상속받아서 GetxMaterialApp() 안에 'initBinding : CountControllerWithGetX()',
```dart
class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanant: true); // permanant 로 인해서 계속 살아있게 된다.
    // 그말은 여기에 계속 추가해서 넣어줄 수 있다는 건가??? 한번보자.
  }
}

```

# 기타 유용한 기능
1. `Get.find<CountControllerwithGetX>().increment();` static 사용하기 
2. Stateless 위젯대신 GetView<CountControllerWithGetX> 로 확장하기

## 1. controller 클래스에서 static  사용하기
>  이렇게 find 로 접근해서 값을 증가시켰는데 controller 객체에서 static 을 사용하면 훨씬 쉽게 사용할 수 있다.
```dart
class CountControllerWithGetX extends GetxController {
  static CountControllerWithGetX get to => Get.find<CountControllerWithGetX>();
  RxInt _count =0.obs;
}
```
```dart
onPressed: () {
  CountControllerWithGetX.to.increment();
  // Get.find<CountControllerWithGetX>().increment();
}
```

## 2. Stateless 위젯대신 GetView<CountControllerWithGetX> 로 확장하기
```dart
class BindingPage extends GetView<CountControllerWithGetX> {
@override 
Widget build(BuildContext context) {
  return Scaffold (
    GetBuildr<CountControllerWithGetX>(builder: (_) {})
  );

// 이제부터는 controller 를 사욯해서 쓸 수 있다.
onPressed: () { controller.increment(); // 이렇게 바로 접근가능하다. }
  }
}
```


# GetxService 
> 컨트롤러를 사용해서 최상단에 Get.put 을 사용해서 controller 의 지속성을 유지시켜 줄 수 있는데 GetxService 를 사용하면 clear() 하기전까지 안죽고 계속 유지되게 할 수 있다.
```dart
void initService() {
  Get.put(GetxControllerTest(), permanent : true); // permananent 를 꼭 해주어야 한다.
}
```
> 그런데 controller 가 GetxService 를 상속받게 되면 그때부터는 지속성을 유지시켜 줄 수 있게 된다.
```dart
// 단지 GetxService 를 상속받았을 뿐인데 메모리에 계속 살아있게 된다.
// Get.reset() 를 하면 메모리에 살아있는 모든 controller 를 지우게 된다.
class GetxServiceTest extends GetxService {
  void increment() { _count++;}
}
```






![This is an image](https://myoctocat.com/assets/images/base-octocat.svg)

- [Markdown CheetSheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
- [other markdown Tools](https://github.com/adam-p/markdown-here/wiki/Other-Markdown-Tools)

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

```markdown
Here is a simple footnote[^1].

A footnote can also have multiple lines[^2].  

You can also use words, to fit your writing style more closely[^note].

[^1]: My reference.
[^2]: Every new line should be prefixed with 2 spaces.  
This allows you to have a footnote with multiple lines.
[^note]:
Named footnotes will still render with numbers instead of the text but allow easier identification and linking.  
This footnote also has been made with a different syntax using 4 spaces for new lines.
```

```markdown
Colons can be used to align columns.

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

There must be at least 3 dashes separating each header cell.
The outer pipes (|) are optional, and you don't need to make the 
raw Markdown line up prettily. You can also use inline Markdown.

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3
```


```markdown
> Blockquotes are very handy in email to emulate reply text.
> This line is part of the same quote.

Quote break.

> This is a very long line that will still be quoted properly when it wraps. Oh boy let's keep writing to make sure this is long enough to actually wrap for everyone. Oh, you can *put* **Markdown** into a blockquote. 
```

#### inline HTML
```markdown
<dl>
  <dt>Definition list</dt>
  <dd>Is something people use sometimes.</dd>

  <dt>Markdown in HTML</dt>
  <dd>Does *not* work **very** well. Use HTML <em>tags</em>.</dd>
</dl>
```

#### Horizontal Rule
```markdown
Three or more...

---

Hyphens

***

Asterisks

___

Underscores
```

#### YoutTube Videos
```markdown
<a href="http://www.youtube.com/watch?feature=player_embedded&v=YOUTUBE_VIDEO_ID_HERE
" target="_blank"><img src="http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>
```
#### mailto link
[example@gitlab.com](mailto:example@gitlab.com)

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
