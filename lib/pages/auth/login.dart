import 'dart:typed_data';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/widgets/common.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late TabController tabController;

  Uint8List? pickedImage;

  final Map<String, String> _authDetails = {
    "email": "",
    "password": "",
  };

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void navigate() => context.router.pushReplacementNamed(Pages.home);

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
                  "Welcome back",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: p150,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(height: 32.h),
                TabBar(
                  controller: tabController,
                  labelColor: p100,
                  unselectedLabelColor: p150,
                  labelStyle: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                  ),
                  indicatorColor: p100,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: "Face Verification"),
                    Tab(text: "Email"),
                  ],
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 480.h,
                  child: TabBarView(controller: tabController, children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.h),
                        GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => ImageDialog(
                              text: openCameraDialog,
                              onProceed: () => context.router
                                  .pushNamed(Pages.camera)
                                  .then((response) async {
                                if (response == null) return;

                                navigate();
                              }),
                            ),
                          ),
                          child: Container(
                            width: 390.w,
                            height: 250.r,
                            decoration: BoxDecoration(
                              color: neutral2,
                              borderRadius: BorderRadius.circular(10.r),
                              image: pickedImage != null
                                  ? DecorationImage(
                                      image: MemoryImage(pickedImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: pickedImage == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        color: p100,
                                        size: 32.r,
                                      ),
                                      Text(
                                        "Open Camera",
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                          color: p150,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
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
                                  .pushReplacementNamed(Pages.register),
                              child: Text(
                                "Register",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: p100,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                            onSave: (value) => _authDetails["email"] = value!,
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
                            onSave: (value) =>
                                _authDetails["password"] = value!,
                            hint: "Password",
                          ),
                          SizedBox(
                            height: 250.h,
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
                            onPressed: () =>
                                context.router.pushReplacementNamed(Pages.home),
                            child: Text(
                              "Log In",
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
                                "Don't have an account? ",
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
                                    .pushReplacementNamed(Pages.register),
                                child: Text(
                                  "Register",
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
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
