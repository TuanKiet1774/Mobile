import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission permission) async{
  if(await permission.isGranted)
    return true;

  PermissionStatus status = await permission.request();
  if(status.isGranted) //isGranted: Quyền đã được cho phép hay chưa
    return true;

  //Tùy vào ứng dụng mà có thể có tùy chọn này hay không
  if(status.isPermanentlyDenied)
    await openAppSettings();

  return false;
}