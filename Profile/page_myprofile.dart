import 'package:flutter/material.dart';

class MyPageProfile extends StatefulWidget {
  const MyPageProfile({super.key});

  @override
  State<MyPageProfile> createState() => _MyPageProfileState();
}

class _MyPageProfileState extends State<MyPageProfile> {
  DateTime ngaysinh = DateTime(2004, 7, 17);
  String ? gioitinh = "Nam";
  List<String> nnlts = ["Tiếng việt", "C/C++", "C#", "Java", "Python", "HTML/CSS", "Dart"];
  String? nnlt = "Tiếng việt";
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _buildBody(index), //Sử dụng nút điều hướng, mặc đinh là hiển thị ở nút home
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Phạm Tuấn Kiệt"),
              accountEmail: Text("kiet.pt.64cntt@ntu.edu.vn"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("asset/images/Anhmau.jpg"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.sms),
              title: Text("SMS"),
              trailing: Text("10"),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  index = 1;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Inbox"),
              trailing: Text(""),
            ),
            ListTile(
              leading: Icon(Icons.drafts),
              title: Text("Draft"),
              trailing: Text("10"),
            ),
            ListTile(
              leading: Icon(Icons.send),
              title: Text("Sent"),
              trailing: Text("10"),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
              trailing: Text("100"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            ListTile(
              leading: Icon(Icons.arrow_left),
              title: Text("Quay lại"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home, color: Colors.blue,)
          ),
          BottomNavigationBarItem(
            label: "SMS",
            icon: Icon(Icons.sms, color: Colors.yellow,)
          ),
          BottomNavigationBarItem(
            label: "Phone",
            icon: Icon(Icons.phone, color: Colors.blue,)
          ),
        ],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }

  //Nút điều hướng
  Widget _buildHome(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*3/4,
                child: Image.asset("asset/images/Anhmau.jpg"),
              ),
            ),
            SizedBox(height: 15,),
            Text("Họ và tên:"),
            Text("Phạm Tuấn Kiệt", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
            SizedBox(height: 15,),
            Text("Ngày sinh:"),
            Row(
              children: [
                Expanded(
                    child: Text("${ngaysinh.day}/${ngaysinh.month}/${ngaysinh.year}", style: TextStyle(fontSize: 16),)
                ),
                IconButton(
                    onPressed: () async{
                      DateTime ? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: ngaysinh,
                        firstDate: DateTime(1998),
                        lastDate: DateTime(2040),
                      );
                      if(selectedDate != null){
                        setState(() {
                          ngaysinh = selectedDate;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_month)
                ),
                SizedBox(height: 25,),
              ],
            ),
            SizedBox(height: 15,),
            Text("Giới tính:"),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text("Nam"), //Không thay đổi
                    value: "Nam",
                    groupValue: gioitinh, //Giới tính thay đổi khi groupValue == value thì sẽ được chọn
                    onChanged: (value) {
                      setState(() {
                        gioitinh = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text("Nữ"), //Không thay đổi
                    value: "Nữ",
                    groupValue: gioitinh, //Giới tính thay đổi khi groupValue == value thì sẽ được chọn
                    onChanged: (value) {
                      setState(() {
                        gioitinh = value;
                      });
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 15,),
            Text("Sở thích:"),
            Text("Chơi game, nghe nhạc, xem phim, cầu lông,...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),),
            SizedBox(height: 15,),
            Text("Ngôn ngữ lập trình:"),
            DropdownButton<String>(
              isExpanded: true,
              value: nnlt,//value thay đổi khi value == value vủa dropdownmenuitem thì item đó sẽ được chọn
              items: nnlts.map(
                    (e) {
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  );
                },
              ).toList(), //Chuyển chuỗi thành các widget
              onChanged: (value) {
                setState(() {
                  nnlt = value;
                });
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Quay lại"),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildSMS(){
    return Center(
      child: Text("SMS"),
    );
  }
  Widget _buildPhone(){
    return Center(
      child: Text("Phone"),
    );
  }

  Widget _buildBody(int index){
    switch(index){
      case 0:return _buildHome();
      case 1: return _buildSMS();
      case 2: return _buildPhone();
      default: return _buildHome();
    }
  }
}
