import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:tuankiet_64131060/commercial_app/model/model.dart';
import 'dart:math';
import 'package:badges/badges.dart' as badges;
import 'controller/controller_fruit.dart';


//Bỏ const
class PageChitietFruit extends StatelessWidget {
  PageChitietFruit({super.key, required this.fruit});
  //Cung cấp thông tin fruit
  Fruit fruit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fruit.ten),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.network(fruit.anh ?? "https://cdn.tgdd.vn/2022/07/CookDishThumb/chanh-day-la-gi-cac-loai-chanh-day-gia-bao-nhieu-1kg-va-lam-thumb-620x620-1.jpg", fit: BoxFit.cover,),
              ),
              SizedBox(width: 20,),
              Text(fruit.ten, style: TextStyle(fontSize: 30),),
              Row(
                children: [
                  Text("${fruit.gia ?? 0}\$ vnd", style: TextStyle(color: Colors.red, fontSize: 20),),
                  SizedBox(width: 20,),
                  Text("${(fruit.gia ?? 0) * 1.2 }\$ vnd", style: TextStyle(fontSize: 20, decoration: TextDecoration.lineThrough),),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: getRating(),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: 20,),
                  Text("Điểm: ${getRating()}", style: TextStyle(color: Colors.red),),
                  SizedBox(width: 20,),
                  Expanded(child: Text("${Random().nextInt(1000) + 1} đánh giá"))
                ],
              ),
              SizedBox(height: 20,),
              Text("Nhà cung cấp: ${fruit.moTa}", style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ControllerFruit.get().themMHGH(fruit);
        },
        child: Icon(Icons.add_shopping_cart),
    ),
    );
  }
}

double getRating(){
  return Random().nextInt(201)/100 + 3;
}
