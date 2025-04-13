import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class Math_Page extends StatelessWidget {
  final CourseController c = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phạm Tuấn Kiệt'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Đổi Đơn Vị ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            ),
            SizedBox(height: 15,),
            Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: c.cmController,
                    decoration: InputDecoration(
                      labelText: 'Centimet',
                      hintText: '17',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        if(c.cmController.text.isNotEmpty){
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Chuyển đổi ${c.cmController.text} sang Inches thành công"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          c.convertToInch();
                        }
                        else if (c.cmController.text.isEmpty){
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Vui lòng nhập số liệu để chuyển đổi"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        if(c.inchController.text.isNotEmpty){
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Chuyển đổi " + c.inchController.text +" sang Cms thành công"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          c.convertToCm();
                        }
                        else if (c.inchController.text.isEmpty){
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Vui lòng nhập số liệu để chuyển đổi"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                    controller: c.inchController,
                    decoration: InputDecoration(
                      labelText: 'Inch',
                      hintText: '17',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: c.clearButton,
                child: Text("Xóa"),

              ),
            ),
            SizedBox(height: 10),
            Text("Kết quả tính toán: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Divider(thickness: 2),
            Expanded(
              child: Obx(() => ListView.separated(
                itemCount: c.ds.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${c.ds[index].inch} inches = ${c.ds[index].inch * 2.54} cm'),
                              Divider(thickness: 1,),
                              Text('${c.ds[index].cm} cm = ${c.ds[index].cm / 2.54} inches')
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(thickness: 1),
              )),
            ),
          ],
        ),
      ),
    );
  }
}