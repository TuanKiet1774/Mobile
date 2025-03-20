import 'package:flutter/material.dart';
import 'package:tuankiet_64131060/json_list/json_data.dart';

class PageAlbum extends StatelessWidget {
  const PageAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Album>>(
        future: docDuLieu(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("Lỗi"),
            );
          }
          //else nếu chưa có dữ liệu thì xoay vòng tròn
          else if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          var list = snapshot.data!;

          return ListView.separated(
            itemBuilder: (context, index){
              Album alb = list[index];
              return ListTile(
                leading: Text("${index + 1}"),
                //leading: Text("${alb.albumId}"),
                title: Text("${alb.title}"),
                subtitle: Text("${alb.url}"),
              );
            },
            separatorBuilder:(context, index) => Divider(),
            itemCount: list.length,
          );
        },
      ),
    );
  }
}