import 'package:flutter/material.dart';
import 'package:tuankiet_64131060/commercial_app/model/model.dart';

class PageFruitStream extends StatelessWidget {
  const PageFruitStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit Stream"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FruitSnapshot.getFruitStream(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              print(snapshot.error.toString());
              return Center(child: Text("ERROR"),);
            }
            if(!snapshot.hasData){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Loanding..."),
                  ],
                ),
              );
            }

            var list = snapshot.data!;
            return GridView.extent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 0.75,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: list.map(
                (fruit) {
                  return Card(
                    child: Column(
                      children: [
                        Expanded(child: Image.network(fruit.anh ?? " ", fit: BoxFit.cover,)),
                        Text(fruit.ten),
                        SizedBox(width: 15,),
                        Text("${fruit.gia}"),
                        SizedBox(width: 15,)
                      ],
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
