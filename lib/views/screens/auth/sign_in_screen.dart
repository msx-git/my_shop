import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_shop/utils/extensions.dart';
import 'package:my_shop/views/widgets/my_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/routes.dart';
import '../../../utils/show_loader.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  submit() async {
    if (formKey.currentState!.validate()) {
      Messages.showLoadingDialog(context);
      await context
          .read<AuthController>()
          .login(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((value) => Navigator.pop(context));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text(
          "Welcome back!",
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
                isLast: true,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter password!";
                  }
                  return null;
                },
              ),
              20.height,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: submit,
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  child: Text(
                    "Enter",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              10.height,
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RouteNames.signUp),
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
