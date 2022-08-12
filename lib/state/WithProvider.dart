import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx2_simple_state/controller/CountControllerWithProvider.dart';
import 'package:provider/provider.dart';

class WithProvider extends StatelessWidget {
  WithProvider({Key? key}) : super(key: key);
  late CountControllerWithProvider countControllerWithProvider;

  @override
  Widget build(BuildContext context) {
    countControllerWithProvider = Provider.of<CountControllerWithProvider>(context, listen: false);
    return Center(
        child: Column(
          children: [
            Text("Provider",  style: TextStyle(fontSize: 20, color: Colors.red),),
            // Widget 을 리턴하는 곳에서는 Consumer 를 사용할 수 있다.
            Consumer<CountControllerWithProvider>( // Consumer 가 Widget 을 리턴하기 때문에 child 를 사용할 필요가 지금은 없다.
                builder: (context, value, child) {
                  return Text(value.count.toString(),  style: TextStyle(fontSize: 20, color: Colors.red));
                }),
            ElevatedButton(
              onPressed: () {countControllerWithProvider.increment();},
              child: const Text("+", style: TextStyle(fontSize: 20, color: Colors.red),),
            ),
          ],)
    );
  }
}
