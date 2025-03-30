import 'package:get/get.dart';

class Student{
  String ten;
  String mssv;
  String ngaysinh;
  String gioitinh;
  String nganhhoc;

  Student({
    required this.ten,
    required this.mssv,
    required this.ngaysinh,
    required this.gioitinh,
    required this.nganhhoc,
  });
}

class StudentController extends GetxController{
  var ds = <Student>[].obs;
  var gt = "Nam".obs;

  void addStudent (String ht, String ms, String ngs, String gt, String ngh){
    Student sv = Student(ten: ht, mssv: ms, ngaysinh: ngs, gioitinh: gt, nganhhoc: ngh);
    ds.add(sv);
  }

  void removeStudent(int index){
    ds.removeAt(index);
  }

  void changed (String value){
    gt.value = value;
  }
}