import 'package:flutter/material.dart';

class PageListView extends StatelessWidget {
  const PageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My list view"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) { //Hàm trả về 1 widget
             var itemData = data[index];
             return ListTile(
               leading: Text("${index + 1}.", style: TextStyle(fontSize: 16),), //Số thứ tự bên mép trái
               title: Text(itemData.ten),
               subtitle: Text("Trái cây VietGap", style: TextStyle(fontStyle: FontStyle.italic),), //Dòng chữ nhỏ bên dưới
               trailing: Text("${itemData.gia} VND", style: TextStyle(color: Colors.red),), // Giá bên mép phải
               onTap: () {
                 ScaffoldMessenger.of(context).clearSnackBars();
                 ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text("Bạn đã chọn sản phẩm ${itemData.ten}"), //Thanh biểu ngữ
                     duration: Duration(seconds: 2), //Thời gian hiển thị 2s
                   )
                 );
               },
             );
          },
          separatorBuilder: (context, index) => Divider(
            thickness: 1.5,
          ),
          itemCount: data.length
      ),
    );
  }
}

class SanPham{
  String ten;
  int gia;

  SanPham({
    required this.ten,
    required this.gia,
  });
}

var data = [
  SanPham(ten: "Chuối", gia: 25000),
  SanPham(ten: "Cam", gia: 25000),
  SanPham(ten: "Dưa", gia: 25000),
  SanPham(ten: "Tắc", gia: 25000),
  SanPham(ten: "Nho", gia: 25000),
  SanPham(ten: "Dừa", gia: 25000),
  SanPham(ten: "Táo", gia: 25000),
  SanPham(ten: "Măng cụt", gia: 25000),
  SanPham(ten: "Thanh Long", gia: 25000),
  SanPham(ten: "Dâu", gia: 25000),
  SanPham(ten: "Jerry", gia: 25000),
  SanPham(ten: "Bưởi", gia: 25000),
  SanPham(ten: "Quít", gia: 25000),
  SanPham(ten: "Sầu riêng", gia: 25000),
  SanPham(ten: "Kiwi", gia: 25000),
  SanPham(ten: "Hồng", gia: 25000),
  SanPham(ten: "Chanh", gia: 25000),
  SanPham(ten: "Chanh Dây", gia: 25000),
  SanPham(ten: "Vú Sửa", gia: 25000),
  SanPham(ten: "Nhãn", gia: 25000),
  SanPham(ten: "Chôm chôm", gia: 25000),
  SanPham(ten: "Xoài", gia: 25000),
];
