import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tuankiet_64131060/ontap/student_controller.dart';

class PageStudent extends StatefulWidget {
  const PageStudent({super.key});

  @override
  State<PageStudent> createState() => _PageStudentState();

}

class _PageStudentState extends State<PageStudent> {
  TextEditingController ten = TextEditingController();
  TextEditingController mssv = TextEditingController();
  TextEditingController ngaysinh = TextEditingController();
  StudentController sc = Get.put(StudentController());
  List<String> dsks = ["Du Lịch", "Kinh Tế", "Công Nghệ Thông Tin", "Cơ Khí", "Điện Tử"];
  String? dsk = "Công Nghệ Thông Tin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý sinh viên"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text("Đại học Nha Trang", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),),
              SizedBox(height: 15,),
              TextField(
                controller: ten,
                decoration: InputDecoration(
                  labelText: "Nhập tên sinh viên",
                  hintText: "Pham Tuan Kiet",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 15,),
              TextField(
                controller: mssv,
                decoration: InputDecoration(
                  labelText: "Nhập mã sinh viên",
                  hintText: "64131060",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: ngaysinh,
                      decoration: InputDecoration(
                        labelText: "Nhập ngày sinh sinh viên",
                        hintText: "17/07/2004",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2004, 7, 17),
                        firstDate: DateTime(1998),
                        lastDate: DateTime(2030),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          ngaysinh.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),

              //Giới tính
              SizedBox(height: 15,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Giới tính", style: TextStyle(fontSize: 17),),
                    ],
                  ),
                  Obx(() => Row(
                    children: [
                      Expanded(
                          child: RadioListTile(
                            title: Text("Nam"),
                            value: "Nam",
                            groupValue: sc.gt.value,
                            onChanged: (value) {
                              if(value != null){
                                sc.changed(value);
                              };
                            },
                          )
                      ),
                      Expanded(
                          child: RadioListTile(
                            title: Text("Nữ"),
                            value: "Nữ",
                            groupValue: sc.gt.value,
                            onChanged: (value) {
                              if(value != null){
                                sc.changed(value);
                              };
                            },
                          )
                      )
                    ],
                  ),)
                ],
              ),

              //Chọn khoa
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Ngành học", style: TextStyle(fontSize: 17),),
                    ],
                  ),
                  SizedBox(width: 20,),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: dsk,
                    items: dsks.map(
                      (e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        dsk = value;
                      });
                    },
                  ),
                ],
              ),

              //Nút bấm
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () {
                  if(ten.text.isNotEmpty && mssv.text.isNotEmpty && ngaysinh.text.isNotEmpty){
                    sc.addStudent(ten.text, mssv.text, ngaysinh.text, sc.gt.value, dsk!);
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Đã thêm " + ten.text),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    ten.clear();
                    mssv.clear();
                    ngaysinh.clear();
                    sc.gt.value = "Nam";
                    setState(() {
                      dsk = "Công Nghệ Thông Tin";
                    });
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
              ),

              //Hiển thị danh sách
              SizedBox(height: 15,),
              Expanded(
                child: Obx(() =>ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text("${index + 1}"),
                      title: Text(sc.ds[index].ten +" | " +sc.ds[index].mssv +" | "+sc.ds[index].ngaysinh +" | "+ sc.ds[index].gioitinh),
                      subtitle: Text("Ngành học: " + sc.ds[index].nganhhoc),
                      trailing: IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Đã xóa " + sc.ds[index].ten),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          sc.removeStudent(index);
                        },
                        icon: Icon(Icons.delete, color: Colors.red,),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: sc.ds.length,
                ),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
