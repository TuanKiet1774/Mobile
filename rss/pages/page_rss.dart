import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuankiet_64131060/rss/controllers/rss_controller.dart';
import 'package:tuankiet_64131060/rss/pages/page_url.dart';

import '../models/rss_item.dart';

class PageRss extends StatelessWidget {
  PageRss({super.key});
  final controller = Get.put(RssController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VNExpress"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          GetBuilder<RssController>(
          id: "header",
          init: controller,
          builder: (controller) {
            var list = controller.headers;
            return DropdownButton<String>(
              value: controller.currentHeader, //đang hiển thị
              items: list.map(
                (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                ),
              ).toList(),
              onChanged: (value) {
                controller.changeHeader(value);
              },
            );
          },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          controller.refresh();
        },
        child: GetBuilder<RssController>(
          id: "rss",
          init: controller,
          builder: (controller) => FutureBuilder<List<RssItem>>(
              future: controller.readRss(),
              builder: (context, snapshot){
                if(snapshot.hasError){
                  print(snapshot.error.toString()); //in lỗi xem thử lỗi gì
                  return Center(child: Text("Lỗi"),);
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text("Loading...")
                      ],
                    ),
                  );
                }
                var list = snapshot.data!;
                return ListView.separated(
                    padding: EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      var item = list[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => PageUrl(link: item.link),)
                                );
                              },
                              child: Row(
                                children: [
                                  if (item.imageUrl!.isNotEmpty)
                                    Image.network(item.imageUrl ?? "Link ảnh mặc định", width: 150, height: 100, fit: BoxFit.cover),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(item.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(item.description??"", style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(thickness: 1.5,),
                    itemCount: list.length
                );
              },
          ),
        ),
      ),
    );
  }
}
