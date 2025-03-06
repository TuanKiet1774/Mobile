import 'package:flutter/material.dart';
import 'package:tuankiet_64131060/Layput/chitiet_sp.dart';
import 'package:tuankiet_64131060/Layput/gridview_example.dart';
import 'package:tuankiet_64131060/Layput/list_view_example.dart';
import 'package:tuankiet_64131060/Profile/page_myprofile.dart';
import 'package:tuankiet_64131060/app_state_ax/getx/getx_ex.dart';
import 'package:tuankiet_64131060/app_state_ax/getx/getx_simple_state_manager.dart';

import '../main.dart';

class MyHomePageApp extends StatelessWidget {
  const MyHomePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile App"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              buildButton(context,title: "GetX", destination: PageCounterGetX()),
              buildButton(context,title: "GetX Simple State", destination: PageSimpleState()),
              buildButton(context,title: "My Profile", destination: MyPageProfile()),
              buildButton(context,title: "Grid View", destination: PageGridView()),
              buildButton(context,title: "List View", destination: PageListView()),
              buildButton(context,title: "Detial Product", destination: PageChiTiet()),
              buildButton(context,title: "Demo", destination: MyHomePage(title: '',)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, {required String title, required Widget destination}) {
    return Container(
      //width: 200,
      width: MediaQuery.of(context).size.width*2/3,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => destination,
            )
          );
        },
        child: Text(title),
      ),
    );
  }
}
