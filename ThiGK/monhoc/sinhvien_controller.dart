import 'package:get/get.dart';

class MonHoc{
  String monHoc;
  String soTin;
  String hocPhi;

  MonHoc({
    required this.monHoc,
    required this.soTin,
    required this.hocPhi,
  });
}

class MonHoc_Controller extends GetxController{
  var dsmh = <MonHoc>[].obs;

  void addMonHoc(String tenmh, String stc, String hp){
    dsmh.add(MonHoc(monHoc: tenmh, soTin: stc, hocPhi: hp));
  }

  int soLuongMonHoc() {
    return dsmh.length;
  }

  int tongTien(){
    int sum = 0;
    for(var i in dsmh){
      sum += (int.tryParse(i.hocPhi)! * int.tryParse(i.soTin)!)!;
    }
    return sum;
  }
}