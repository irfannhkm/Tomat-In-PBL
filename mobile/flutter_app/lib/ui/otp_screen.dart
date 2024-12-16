import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:tomatin/modules/controllers/register_controller.dart';

class OtpScreen extends GetView<RegisterController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF191d26),
        body: SafeArea(
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  ],
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) async {
                    controller.isLoading.value = true;

                    final bool status = await controller.otpVerify(
                        verificationCode, controller.emailController.text);

                    controller.isLoading.value = false;

                    if (status) {
                      Get.snackbar(
                        "Success",
                        "OTP verified successfully",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                      // Navigate to the next page
                      Get.offAllNamed('/home');
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
              ],
            );
          }),
        ));
  }
}
