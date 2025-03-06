import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerCounter extends GetxController{
  final _counter = 0.obs;
  int get counter => _counter.value;

  void increase(){
    _counter.value++;
  }
}

class PageCounterGetX extends StatelessWidget {
  PageCounterGetX({super.key});
  final controller = Get.put(ControllerCounter());
  final controller2 = Get.put(ControllerCounter(), tag: "My tag"); //Sử dụng thông qua tag

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Getx Exammple"),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => Text("Controller: ${controller.counter}", style: TextStyle(fontSize: 20),),),
            ElevatedButton(
              onPressed: () {
                controller.increase();
              },
              child: Text(" + "),
            ),
            GetX<ControllerCounter>(
              tag: "My tag",
              builder: (controller) {
                return Text("Controller1: ${controller.counter}", style: TextStyle(fontSize: 20),);
              },
            ),
            ElevatedButton(
                onPressed: () {
                  controller2.increase();
                },
                child: Text(" + "),
            )
          ],
        ),
      ),
    );
  }
}
