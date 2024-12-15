import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:tomatin/controllers/register_controller.dart';

class OtpScreen extends GetView<RegisterController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF191d26),
        body: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              fillColor: Colors.white,
              styles: [
                TextStyle(color: Colors.white),
                TextStyle(color: Colors.white),
                TextStyle(color: Colors.white),
                TextStyle(color: Colors.white),
                TextStyle(color: Colors.white),
                TextStyle(color: Colors.white),
              ],
              //runs when every textfield is filled
              onSubmit: (String verificationCode) async {
                final bool status = await controller.otpVerify(
                    verificationCode, controller.emailController.text);

                if (status) {
                  controller.register(
                      controller.usernameController.text,
                      controller.fullNameController.text,
                      controller.emailController.text,
                      controller.passwordController.text,
                      controller.cPasswordController.text);
                } else {
                  Get.snackbar(
                    "Error",
                    "OTP Salah, silahkan coba lagi",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              }, // end onSubmit
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                controller.otpRegister(controller.emailController.text);
              },
              child: const Text(
                'Kirim ulang OTP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        ));
  }
}
