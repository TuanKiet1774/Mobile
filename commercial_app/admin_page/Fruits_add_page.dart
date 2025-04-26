import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuankiet_64131060/commercial_app/helper/dialogs.dart';
import 'package:tuankiet_64131060/commercial_app/helper/supabase_helper.dart';
import 'package:tuankiet_64131060/commercial_app/model/model.dart';
import 'package:tuankiet_64131060/helpers/permission_grant.dart';

class Page_Add_Fruit extends StatefulWidget {
  const Page_Add_Fruit({super.key});

  @override
  State<Page_Add_Fruit> createState() => _Page_Add_FruitState();
}

class _Page_Add_FruitState extends State<Page_Add_Fruit> {
  TextEditingController txtId = new TextEditingController();
  TextEditingController txtTen = new TextEditingController();
  TextEditingController txtGia = new TextEditingController();
  TextEditingController txtMoTa = new TextEditingController();
  XFile? _xFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 300,
                child: _xFile == null ? Icon(Icons.image, size: 40,): Image.file(File(_xFile!.path)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if(await requestPermission(Permission.photos)){
                        var picImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if(picImage != null){
                          setState(() {
                            _xFile = picImage;
                          });
                        }
                      }
                    },
                    child: Text("Tải ảnh lên"),
                  ),
                  SizedBox(width: 10,)
                ],
              ),
              SizedBox(height: 15,),
              TextField(
                controller: txtId,
                decoration: InputDecoration(
                  labelText: "Nhập mã sản phẩm",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: txtTen,
                decoration: InputDecoration(
                  labelText: "Nhập tên sản phẩm",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text
              ),
              SizedBox(height: 15,),
              TextField(
                controller: txtGia,
                decoration: InputDecoration(
                  labelText: "Giá sản phẩm",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: txtMoTa,
                decoration: InputDecoration(
                  labelText: "Mô tả sản phẩm",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if(_xFile != null){
                        //1 Upload ảnh và lấy đường dẫn
                        showSnackBar(
                          context, 
                          message: "Đang thêm ${txtTen.text}...", seconds: 3);
                        String url = await uploadImage(
                          image: File(_xFile!.path), 
                          bucket: "images",
                          path: "fruits/fruit_${txtId.text}.jpg"
                        );
                        Fruit fruit = Fruit(
                          id: int.parse(txtId.text),
                          ten: txtTen.text,
                          gia: int.parse(txtGia.text),
                          moTa: txtMoTa.text,
                          anh: url,
                        );
                        await FruitSnapshot.insert(fruit);
                        showSnackBar(
                          context,
                          message: "Đã thêm ${txtTen.text}...", seconds: 3);
                      }
                    },
                    child: Text("Thêm sản phẩm"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
