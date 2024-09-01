import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/widgets/common.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final Map<String, dynamic> authDetails = {
    "first_name": "",
    "last_name": "",
    "age": "",
    "email": "",
    "password": "",
  };

  bool showPassword = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 63.h,
                ),
                Text(
                  "SnapFeast",
                  style: context.textTheme.displaySmall!.copyWith(
                    color: p100,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                ),
                Text(
                  "Creating your account has never being easier",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: p150,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: firstNameController,
                        prefix: Icon(
                          Icons.person_2_outlined,
                          size: 18.r,
                          color: p100,
                        ),
                        onValidate: (value) {
                          if (value!.isEmpty) {
                            showToast("Let us know your first name", context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => authDetails["first_name"] = value!,
                        hint: "First Name",
                      ),
                      SizedBox(height: 10.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: lastNameController,
                        prefix: Icon(
                          Icons.person_2_outlined,
                          size: 18.r,
                          color: p100,
                        ),
                        onValidate: (value) {
                          if (value!.isEmpty) {
                            showToast("Let us know your last name", context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => authDetails["last_name"] = value!,
                        hint: "Last Name",
                      ),
                      SizedBox(height: 10.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: ageController,
                        type: TextInputType.number,
                        prefix: Icon(
                          Icons.cake_outlined,
                          size: 18.r,
                          color: p100,
                        ),
                        onValidate: (value) {
                          if (value!.isEmpty) {
                            showToast("Let us know your age", context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => authDetails["age"] = value!,
                        hint: "Age",
                      ),
                      SizedBox(height: 10.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: emailController,
                        prefix: Icon(
                          Icons.mail_outline_rounded,
                          size: 18.r,
                          color: p100,
                        ),
                        type: TextInputType.emailAddress,
                        onValidate: (value) {
                          if (value!.isEmpty || !value.contains("@")) {
                            showToast("Invalid Email Address", context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => authDetails["email"] = value!,
                        hint: "Email",
                      ),
                      SizedBox(height: 10.h),
                      SpecialForm(
                        obscure: !showPassword,
                        width: 390.w,
                        height: 40.h,
                        controller: passwordController,
                        type: TextInputType.text,
                        prefix: Icon(
                          Icons.lock_outline_rounded,
                          size: 18.r,
                          color: p100,
                        ),
                        suffix: GestureDetector(
                          onTap: () =>
                              setState(() => showPassword = !showPassword),
                          child: AnimatedSwitcherTranslation.right(
                            duration: const Duration(milliseconds: 500),
                            child: Icon(
                              !showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 18.r,
                              key: ValueKey<bool>(showPassword),
                              color: p150,
                            ),
                          ),
                        ),
                        onValidate: (value) {
                          if (value!.length < 6) {
                            showToast(
                                "Password is too short. Use at least 6 characters",
                                context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => authDetails["password"] = value!,
                        hint: "Password",
                      ),
                      SizedBox(
                        height: 230.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(390.w, 50.h),
                          backgroundColor: p100,
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.h),
                          ),
                        ),
                        onPressed: () {
                          if (!validateForm(formKey)) return;

                          context.router.pushNamed(
                            Pages.details,
                            extra: authDetails,
                          );
                        },
                        child: Text(
                          "Continue",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: p150,
                              fontFamily: "Montserrat",
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                            onTap: () => context.router
                                .pushReplacementNamed(Pages.login),
                            child: Text(
                              "Log In",
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: p100,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
