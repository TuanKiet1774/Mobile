import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thigk/sinhvien_controller.dart';

class Page_SinhVien extends StatefulWidget {
  const Page_SinhVien({super.key});

  @override
  State<Page_SinhVien> createState() => _Page_SinhVienState();
}

class _Page_SinhVienState extends State<Page_SinhVien> {
  TextEditingController monHoc = TextEditingController();
  TextEditingController soTC = TextEditingController();
  TextEditingController hocPhi = TextEditingController();
  MonHoc_Controller ds = Get.put(MonHoc_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phạm Tuấn Kiệt"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: monHoc,
              decoration: InputDecoration(
                labelText: "Môn học",
                hintText: "Tiếng Anh",
              ),
            ),

            SizedBox(height: 15,),
            TextField(
              controller: soTC,
              decoration: InputDecoration(
                labelText: "Số tín chỉ",
                hintText: "3",
              ),
            ),

            SizedBox(height: 15,),
            TextField(
              controller: hocPhi,
              decoration: InputDecoration(
                labelText: "Học phí",
                hintText: "3",
              ),
            ),

            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if(monHoc.text.isNotEmpty && soTC.text.isNotEmpty && hocPhi.text.isNotEmpty ){
                      ds.addMonHoc(monHoc.text, soTC.text, hocPhi.text);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Đã thêm " + monHoc.text),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      monHoc.clear();
                      soTC.clear();
                      hocPhi.clear();
                    }
                    else{
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Vui lòng nhập thông tin"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }, 
                  child: Text("Thêm"),
                )
              ],
            ),

            Row(
              children: [
                Text("Danh sách môn học:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
              ],
            ),

            SizedBox(height: 15,),
            Expanded(
              child: Obx(() => ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Text(ds.dsmh[index].monHoc, style: TextStyle(fontSize: 20),)
                          ),
                          Expanded(
                              flex: 3,
                              child: Text(ds.dsmh[index].soTin + " tín chỉ", style: TextStyle(fontSize: 17),)
                          ),
                        ],
                      ),
                      subtitle: Text("Học phí: " + ds.dsmh[index].hocPhi + " vnđ", style: TextStyle(fontSize: 20),),

                    ),
                    
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: ds.dsmh.length,
              ))
            ),

            SizedBox(height: 15,),
            Row(
              children: [
                Obx(() => Text("Danh sách có: " + ds.soLuongMonHoc().toString() + " môn học", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),)
              ],
            ),
            Row(
              children: [
                Obx(() => Text("Tổng học phí: " + ds.tongTien().toString() + " VNĐ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),)
              ],
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),


    );
  }
}
