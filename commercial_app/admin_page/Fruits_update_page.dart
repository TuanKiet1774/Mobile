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

class Page_Update_Fruit extends StatefulWidget {
  Page_Update_Fruit({super.key, required this.fruit});
  Fruit fruit;

  @override
  State<Page_Update_Fruit> createState() => _Page_Update_FruitState();
}

class _Page_Update_FruitState extends State<Page_Update_Fruit> {
  TextEditingController txtId = new TextEditingController();
  TextEditingController txtTen = new TextEditingController();
  TextEditingController txtGia = new TextEditingController();
  TextEditingController txtMoTa = new TextEditingController();
  XFile? _xFile;
  String? imageUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtId.text = widget.fruit.id.toString();
    txtTen.text = widget.fruit.ten;
    txtGia.text = widget.fruit.gia.toString();
    txtMoTa.text = widget.fruit.moTa ?? " ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 300,
                child: _xFile == null ? Image.network(widget.fruit.anh ?? "Link ảnh mặ định") : Image.file(File(_xFile!.path)),
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
                readOnly: true,
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
                      Fruit fruit = widget.fruit;
                      showSnackBar(context, message: "Đang cập nhật ${fruit.ten}...");
                      imageUrl = widget.fruit.anh;
                      if (_xFile != null) {
                        imageUrl = await uploadImage(
                            image: File(_xFile!.path),
                            bucket: "images",
                            path: "fruits/fruit_(${txtId.text}).jpg",
                            //upsert: true
                        );
                      }

                      Fruit updated = Fruit(
                        id: widget.fruit.id,
                        ten: txtTen.text,
                        gia: int.tryParse(txtGia.text) ?? 0,
                        moTa: txtMoTa.text,
                        anh: imageUrl,
                      );

                      await FruitSnapshot(fruit: updated).update(updated);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Đã cập nhật ${fruit.ten}")),
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Cập nhật sản phẩm"),
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
