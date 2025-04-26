import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tuankiet_64131060/commercial_app/admin_page/Fruits_add_page.dart';
import 'package:tuankiet_64131060/commercial_app/helper/dialogs.dart';
import 'package:tuankiet_64131060/commercial_app/model/model.dart';
import 'package:tuankiet_64131060/widgets/async_widget.dart';

class Page_Fruits_Admin extends StatelessWidget {
  Page_Fruits_Admin({super.key});
  late BuildContext myContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruits Admin"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Page_Add_Fruit(),)
              );
            },
            icon: Icon(Icons.add_circle_outline, size: 30),
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: StreamBuilder(
        stream: FruitSnapshot.getFruitStream(),
        builder: (context, snapshot) {
          return AsyncWidget(
            snapshot: snapshot,
            builder: (context, snapshot) {
              var list = snapshot.data! as List<Fruit>;
              return ListView.separated(
                itemBuilder: (context, index) {
                  myContext = context;
                  Fruit fruit = list[index];
                  return Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 3,
                          onPressed: (context) {

                          },
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Sửa',
                        ),
                        SlidableAction(
                          flex: 3,
                          onPressed: (context) async {
                            String? xacNhan = await showConfirmDialog(
                              myContext,
                              "Bạn có muốn xóa ${fruit.ten}"
                            );
                            if(xacNhan == "ok"){
                              await FruitSnapshot.delete(fruit.id);
                              showSnackBar(
                                myContext,
                                message: "Đã xóa ${fruit.ten}");
                            }
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete_forever,
                          label: 'Xóa',
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.network(
                            fruit.anh ?? "Link ảnh mặt định",
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mã sản phẩm: ${fruit.id}", style: TextStyle(fontSize: 15)),
                              Text(fruit.ten, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Text("Giá: ${fruit.gia} VNĐ", style: TextStyle(fontSize: 17, color: Colors.red),),
                              Text("Mô tả: ${fruit.moTa}", style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),),
                            ],
                          )
                        )
                      ],
                    ),
                  );
                },
                itemCount: list.length,
                separatorBuilder:(context, index) =>  Divider(thickness: 1.5,),
              );
            },
          );
        },
      ),
    );
  }
}
