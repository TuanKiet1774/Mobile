import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:tuankiet_64131060/commercial_app/helper/dialogs.dart';
import 'package:tuankiet_64131060/commercial_app/helper/supabase_helper.dart';

AuthResponse ? response;

class PageAuthUser extends StatelessWidget {
  const PageAuthUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page User Auth:Sign In"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 100,),
            SupaEmailAuth(
              onSignInComplete: (res) {
                response = res;
                Navigator.of(context).pop();
              },
              onSignUpComplete: (response) {
                if(response.user!=null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PageVeriFyOTP(email: response.user!.email!),
                    )
                  );
                }
              },
              showConfirmPasswordField: true,
            ),
          ],
        ),
      ),
    );
  }
}

class PageVeriFyOTP extends StatelessWidget {
  PageVeriFyOTP({super.key, required this.email});
  String email;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xác thực OTP"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            showFieldAsBox: true,
            onCodeChanged: (String code) {
                         
            },
            onSubmit: (String verificationCode) async {
              response = await Supabase.instance.client.auth.verifyOTP(
                token: verificationCode,
                email: email,
                type: OtpType.email,
              );
              if(response?.session != null && response?.user != null){
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => PageThongTin(),), 
                  (route) => false,
                );
              }
            }, // end onSubmit
          ),
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed:() async {
              showSnackBar(context, message: "Đang gửi lại mã...", seconds: 600);
              final respone = await supabase.auth.signInWithOtp(
                email: email,
              );
              showSnackBar(context, message: "Mã đã được gửi vào $email của bạn", seconds: 3);
            }, 
            child: Text("Gửi lại mã")
          )
        ],
      ),
    );
  }
}

class PageThongTin extends StatelessWidget {
  const PageThongTin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang thông tin khách hàng"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
