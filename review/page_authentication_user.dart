
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../commercial_app/helper/dialogs.dart';
import '../commercial_app/helper/supabase_helper.dart';
AuthResponse? response;
class PageFruitStoreUser extends StatelessWidget {
  const PageFruitStoreUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                    child: Container()
                ),
                SupaEmailAuth(
                  onSignInComplete: (res) {
                    response = res;
                    Navigator.of(context).pop();
                    },
                  onSignUpComplete: (response) {
                    if(response.user!=null){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PageVerifyOTP(email: response.user!.email!),)
                      );
                    }
                    },
                  showConfirmPasswordField: true,
                ),
                Expanded(
                    child: Container()
                )
              ],
            ),
        ),
      ),
    );
  }
}

class PageVerifyOTP extends StatelessWidget {
  String email;
  PageVerifyOTP({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xác thực mã OTP"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) async{
              response = await Supabase.instance.client.auth.verifyOTP(
                  email: email,
                  token: verificationCode,
                  type: OtpType.email
              );
              if(response?.session!=null && response?.user!=null){
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => PageThongTinUser()),
                      (route) => false,
                );
              }
              // showDialog(
              //     context: context,
              //     builder: (context){
              //       return AlertDialog(
              //         title: Text("Verification Code"),
              //         content: Text('Code entered is $verificationCode'),
              //       );
              //     }
              // );
            }, // end onSubmit
          ),
          SizedBox(height: 50,),
          ElevatedButton(
              onPressed: () async{
                showSnackBar(context, message: "Đang gửi mã OTP...");
                final response = await supabase.auth.signInWithOtp(
                  email: email
                );
                showSnackBar(context, message: "Mã OTP đã gửi vào email ${email} của bạn.");
              },
              child: Text("Gửi lại mã OTP")
          )
        ],
      ),
    );
  }
}

class PageThongTinUser extends StatefulWidget {
  const PageThongTinUser({super.key});

  @override
  State<PageThongTinUser> createState() => _PageThongTinUserState();
}

class _PageThongTinUserState extends State<PageThongTinUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin khách hàng"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
