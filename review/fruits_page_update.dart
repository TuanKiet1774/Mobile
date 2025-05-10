import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../commercial_app/helper/dialogs.dart';
import '../commercial_app/helper/supabase_helper.dart';
import '../commercial_app/model/model.dart';


class PageUpdateFruits extends StatefulWidget {
  final Fruit fruit;
  const PageUpdateFruits({super.key, required this.fruit});

  @override
  State<PageUpdateFruits> createState() => _PageUpdateFruitsState();
}

class _PageUpdateFruitsState extends State<PageUpdateFruits> {
  XFile? xFile = null;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMota = TextEditingController();
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Fruits", style: TextStyle(fontSize: 32),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: xFile == null? Image.network(widget.fruit.anh?? "Link ảnh mặc định") : Image.file(File(xFile!.path)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async{
                      var imagePicker = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (imagePicker != null){
                        setState(() {
                          xFile = imagePicker;
                        });
                      }
                    },
                    child: Text("Chọn ảnh mới")),
                SizedBox(height: 20),
              ],
            ),
            TextField(
              controller: txtId,
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "ID"),
            ),
            TextField(
              controller: txtTen,
              decoration: InputDecoration(labelText: "Tên"),
            ),
            TextField(
              controller: txtGia,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Giá"),
            ),
            TextField(
              controller: txtMota,
              decoration: InputDecoration(labelText: "Mô tả"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      Fruit fruit = widget.fruit;
                      showSnackBar(context, message: "Đang cập nhật ${fruit.ten}...");
                      imageUrl = widget.fruit.anh;
                      if (xFile != null) {
                        imageUrl = await uploadImage(
                          image: File(xFile!.path),
                          bucket: "images",
                          path: "fruits/fruit_(${txtId.text}).jpg",
                          upsert: true
                        );
                      }

                      Fruit updated = Fruit(
                        id: widget.fruit.id,
                        ten: txtTen.text,
                        gia: int.tryParse(txtGia.text) ?? 0,
                        moTa: txtMota.text,
                        anh: imageUrl,
                      );

                      await FruitSnapshot(fruit: updated).update(updated);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Đã cập nhật ${fruit.ten}")),
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Cập nhật")),
              ],
            )
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtId.text = widget.fruit.id.toString();
    txtTen.text = widget.fruit.ten;
    txtGia.text = widget.fruit.gia.toString();
    txtMota.text = widget.fruit.moTa?? "";
  }
}
