import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:tuankiet_64131060/commercial_app/controller/controller_fruit.dart';
import 'package:tuankiet_64131060/commercial_app/model/model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tuankiet_64131060/commercial_app/page_chitiet_fruits.dart';

import 'controller/controller_fruit2.dart';

//NHỚ LÀ CHẠY AppFruitStore CHỨ KHÔNG PHẢI PageHomeFruitStore
class AppFruitStore extends StatelessWidget {
  const AppFruitStore({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fruit App Store",
      //Đưa phụ thuộc vào app
      initialBinding: BindingAppFruitStore(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange,),
        useMaterial3: true,
      ),
      //Gọi trang home
      home: PageHomeFruitStore(),
    );
  }
}

class PageHomeFruitStore extends StatelessWidget {
  const PageHomeFruitStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dr.Code Fruit Store"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //Giỏ hàng
        actions: [
          GetBuilder(
            id: "gh",
            init: ControllerFruit(),
            builder: (controller) => badges.Badge(
              //showBadge: điều kiện hiển thị
              showBadge: controller.sLMHGH > 0,
              badgeContent: Text("${controller.sLMHGH}",style: TextStyle(color: Colors.white),),
              child: Icon(Icons.shopping_cart),
            ),
          ),
          SizedBox(width: 20,),
        ],
      ),
      body: GetBuilder(
        id: "Fruits",
        init: ControllerFruit.get(),
        builder: (controller) {
          var fruit = controller.fruits;
          return GridView.extent(
            maxCrossAxisExtent: 300,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.75,
            children: fruit.map(
              //e là một danh sách fruit
              //GestureDetector cung cấp cho ta onTap
              (e) => GestureDetector(
                onTap: () {
                  Get.to(PageChitietFruit(fruit: e));
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: Image.network(e.anh ?? "https://cdn.tgdd.vn/2022/07/CookDishThumb/chanh-day-la-gi-cac-loai-chanh-day-gia-bao-nhieu-1kg-va-lam-thumb-620x620-1.jpg",
                          fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(e.ten),
                      Text("${e.gia}VNĐ"),
                    ],
                  ),
                ),
              ),
            ).toList(),
          );
        },
      ),
    );
  }
}
