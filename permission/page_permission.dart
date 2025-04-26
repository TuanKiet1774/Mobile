import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuankiet_64131060/helpers/permission_grant.dart';

class PageRequestPermission extends StatelessWidget {
  const PageRequestPermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permission Page"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            String mess;
            var status = await requestPermission(Permission.camera);
            if(status)
              mess = "Quyền sử dụng camera đã được cấp";
            else
              mess = "Quyền sử dụng camera đã bị từ chối";
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(mess),
                duration: Duration(seconds: 2),
              )
            );
          },
          child: Text("Contact Permission Request")),
      ),
    );
  }
}
