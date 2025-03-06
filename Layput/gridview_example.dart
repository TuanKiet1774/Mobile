import 'package:flutter/material.dart';
import 'package:tuankiet_64131060/Layput/chitiet_sp.dart';
import 'package:tuankiet_64131060/Layput/list_view_example.dart';

class PageGridView extends StatefulWidget {
  PageGridView({super.key});

  @override
  State<PageGridView> createState() => _PageGridViewState();
}

class _PageGridViewState extends State<PageGridView> {
  String image = "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQThAbwb_wDyKaViQ4H2V-uWjcBj4V2ar_Qz6glIsmoBXFca0mfd1lyVIqhUq7q9YQJ3pKFG0d2-xwZ7Cq_Ix9Duw";

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Grid View"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Stack(
            children: [
              Icon(Icons.shopping_cart, color: Colors.white, size: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 17, top: 5),
                child: Text("${count}", style: TextStyle(color: Colors.black,fontSize: 12),),
              )
            ],
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.8, //Số càng nhỏ hình càng lớn
        children: data.map( //Nhập 1 phần tử từ danh sách thành element
          (e){ // 1 phần tử
            return Card(
              child: GestureDetector(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Image.network(image),
                      ),
                    ),
                    Text(e.ten),
                    Text("${e.gia}đ"),
                  ],
                ),
                onTap: () async { //Đổi thành StatefulWidget
                  String message = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PageChiTiet()
                    ));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)
                  ));
                },
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
