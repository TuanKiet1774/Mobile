import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuankiet_64131060/app_state_ax/getx/pagenext.dart';

class ControllerSimpleState extends GetxController{
  int counter = 0;

  static ControllerSimpleState get({String ? tag}) => Get.find<ControllerSimpleState>(tag: tag);
  void increase1(){
    counter++;
    update(["01"]); //Chỉ cập nhật khi thỏa mãn điều kiện (01 điều kiện luôn thỏa mãn)
    //update(['01',counter <= 10]);
  }
  void increase2(){
    counter++;
    update(["02"]); //Chỉ cập nhật khi thỏa mãn điều kiện (02 điều kiện luôn thỏa mãn)
  }

  void increaseAll()
  {
    counter++;
    update([]);
    //update(["01","02"]); //Cập nhật hết
  }
}

class BindingController extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => ControllerSimpleState());
  }
}

class BindingTempoController extends Bindings{

  @override
  void dependencies() {
    Get.create(() => ControllerSimpleState(), permanent: false);
  }
}

class GetXApp extends StatelessWidget {
  const GetXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "GetXApp",
      initialBinding: BindingController(),
      home: PageSimpleState(),
    );
  }
}


class PageSimpleState extends StatelessWidget {
  PageSimpleState({super.key});

  final c = Get.put(ControllerSimpleState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetX Simple State"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<ControllerSimpleState>(
              id: "01",
              builder: (controller) => Text("01: ${controller.counter}",style: TextStyle(fontSize: 20),),
            ),

            GetBuilder<ControllerSimpleState>(
              id: "02",
              builder: (controller) => Text("02: ${controller.counter}",style: TextStyle(fontSize: 20),),
            ),
            ElevatedButton(
              onPressed: () {
                ControllerSimpleState.get().increase1();
              }, 
              child: Text("increase 1"),
            ),

            ElevatedButton(
              onPressed: () {
                ControllerSimpleState.get().increase2();
              },
              child: Text("increase 2"),
            ),

            ElevatedButton(
              onPressed: () {
                ControllerSimpleState.get().increaseAll();
              },
              child: Text("increase all"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.to(PageNext(),binding: BindingTempoController());
              },
              child: Text("Tràn tiếp theo"),
            ),
          ],
        ),
      ),
    );
  }
}
