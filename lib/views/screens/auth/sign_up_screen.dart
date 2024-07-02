import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_shop/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/show_loader.dart';
import '../../widgets/my_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  submit() async {
    if (formKey.currentState!.validate()) {
      Messages.showLoadingDialog(context);
      await context
          .read<AuthController>()
          .register(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then(
        (_) {
          emailController.clear();
          passwordController.clear();
          passwordConfirmController.clear();
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text(
          "Welcome!",
          style: GoogleFonts.poppins(fontSize: 22.sp),
        ),
        backgroundColor: const Color(0xffFFFFFF),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              20.height,
              SvgPicture.asset(
                'assets/icons/my_shop_icon.svg',
                height: 150.h,
                width: 100,
              ),
              MyTextFormField(
                controller: emailController,
                label: "Email",
                isEmail: true,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter email address!";
                  }
                  return null;
                },
              ),
              8.height,
              MyTextFormField(
                controller: passwordController,
                label: "Password",
                isPassword: true,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter password!";
                  }
                  return null;
                },
              ),
              8.height,
              MyTextFormField(
                controller: passwordConfirmController,
                label: "Confirm Password",
                isPassword: true,
                isLast: true,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter confirm password!";
                  }
                  if (passwordController.text !=
                      passwordConfirmController.text) {
                    return "Passwords didn't match!";
                  }
                  return null;
                },
              ),
              20.height,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  onPressed: submit,
                  child: Text(
                    "Join",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
