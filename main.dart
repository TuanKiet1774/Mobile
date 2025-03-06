import 'package:flutter/material.dart';
import 'package:tuankiet_64131060/Layput/gridview_example.dart';
import 'package:tuankiet_64131060/Layput/list_view_example.dart';
import 'package:tuankiet_64131060/Profile/pagehomeapp.dart';

void main() {
  runApp(const MyApp());
}
//Stateless: Widget không trạng thái
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { //Mỗi Widget có một phương thức đặc biệt build
    return MaterialApp( //trả về 1 widget
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange,),
        useMaterial3: true,
      ),
      //home: MyHomePageApp(),
      home: MyHomePageApp(), //Trang dao diện
    );
  }
}

//Stateful: Widget có trạng thái
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title; //final: Gán 1 lần duy nhất

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  //_: private
}

class _MyHomePageState extends State<MyHomePage> {
  String message = "Hello Tk1774";
  TextEditingController txtname = TextEditingController();
  TextEditingController txtdate = TextEditingController();
  String name = "";
  String images = "https://ukiyaseed.weebly.com/uploads/5/8/8/7/58878313/gflxi5-biaabxv8_orig.jpg";


  @override
  Widget build(BuildContext context) { //Stateful: PT build nằm trong phương thức trạng thái
    return Scaffold(
      appBar: AppBar(
        title: Text("App của TK1774"),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0,),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 600,
                height: 300,
                child: Image.network(images),
              ),
              Text(message, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),),
              Text("Welcome to my app ${txtname.text}", style: TextStyle(color: Colors.lightGreen),),
              TextField(
                controller: txtname,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Nhập tên",
                ),
              ),
              TextField(
                controller: txtdate,
                decoration: InputDecoration(
                  labelText: "Ngày sinh",
                  hintText: "Nhập ngày sinh",
                ),
                keyboardType: TextInputType.datetime, //Định dạng kiểu nhập vào
              ),
              ElevatedButton(
                onPressed: (){
                    if(message == "Bye TK1774"){
                      message = "Chào TK1774";
                    }
                    else{
                      message = "Bye TK1774";
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Chào ${txtname.text}"),
                          duration: Duration(seconds: 5),
                        ),
                    );
                    setState(() {

                    });
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 10,
                ),
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Colors.blue, // Màu nền
                //   foregroundColor: Colors.white, // Màu chữ
                //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Khoảng cách bên trong
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10), // Bo góc
                //   ),
                //   elevation: 5, // Độ nổi
                // ),
                child: Text("Pick me"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {// Khi host thì nó sẽ bỏ qua initstate
    // TODO: implement initState
    super.initState();
    txtname.text = "Tuấn Kiệt";
    txtdate.text = "17/07/2004";
  }
}

//chia layout theo tỷ lệ: expanded (vd: expended (flex = 1))
//flexible giống expanded nhưng ko yêu cầu fill hết
