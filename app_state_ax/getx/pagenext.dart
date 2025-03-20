import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_simple_state_manager.dart';



class PageNext extends StatelessWidget {
  PageNext({super.key});

  final c = Get.put(ControllerSimpleState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetX Page Next"),
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
          ],
        ),
      ),
    );
  }
}
