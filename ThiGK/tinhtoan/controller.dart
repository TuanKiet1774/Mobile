import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Math {
  double cm;
  double inch;

  Math({
    required this.cm,
    required this.inch
  });
}

class CourseController extends GetxController {
  var ds = <Math>[].obs;
  final cmController = TextEditingController();
  final inchController = TextEditingController();


  void convertToInch() {
    double cm = double.tryParse(cmController.text) ?? 0;
    double inch = cm / 2.54;
    inchController.text = inch.toStringAsFixed(2);
    addMath(cm, inch);
  }

  void convertToCm() {
    double inch = double.tryParse(inchController.text) ?? 0;
    double cm = inch * 2.54;
    cmController.text = cm.toStringAsFixed(2);
    addMath(cm, inch);
  }

  void addMath(double cms, double ins) {
    if (cms > 0 || ins > 0) {
      var temp = Math(cm: cms, inch: ins);
      ds.add(temp);
    }
  }

  void clearButton(){
    inchController.clear();
    cmController.clear();
  }
}