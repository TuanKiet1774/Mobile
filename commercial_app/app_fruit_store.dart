import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuankiet_64131060/commercial_app/helper/supabase_helper.dart';
//import 'package:tuankiet_64131060/commercial_app/controller/controller_fruit.dart';
import 'package:tuankiet_64131060/commercial_app/model/model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tuankiet_64131060/commercial_app/page_auth_user.dart';
import 'package:tuankiet_64131060/commercial_app/page_chitiet_fruits.dart';
import 'controller/controller_fruit.dart';
import 'model/model.dart';

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
          var fruit = controller.fruit;
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
      drawer: Drawer(
        child: ListView(
          children: [
            GetBuilder<ControllerFruit>(
              id: "drawer_header",
              init: ControllerFruit.get(),
              builder: (controller) => UserAccountsDrawerHeader(
                accountName: Text("Xin chào"), 
                accountEmail: Text("${response?.user?.email ?? "Chưa đăng nhập"}" ),
              ),
            ),
            Sign(context),
          ],
        ),
      ),
    );
  }
}

Widget Sign(BuildContext context){
  if(response?.user?.email == null){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Sign In", style: TextStyle(fontSize:20 ),),
            SizedBox(width: 10,),
            IconButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageAuthUser(),));
                ControllerFruit.get().auth();
              },
              icon: Icon(Icons.login),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
  else{
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Sign Out", style: TextStyle(fontSize:20 ),),
            SizedBox(width: 10,),
            IconButton(
              onPressed: () async {
                await supabase.auth.signOut();
                response = null;
                ControllerFruit.get().auth();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}