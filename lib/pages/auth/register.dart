import 'dart:io';
import 'dart:typed_data';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/api/file_manager.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/widgets/common.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late TabController tabController;

  Uint8List? pickedImage;

  final Map<String, String> _authDetails = {
    "email": "",
    "password": "",
    "firstName": "",
    "lastName": "",
  };

  int index = 0;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 2,
      vsync: this,
    );
    unFocus();
  }

  @override
  void dispose() {
    tabController.dispose();
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  index == 0
                      ? "Creating your account has never being easier"
                      : "Now let's see what you look like",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 32.h),
                if (index == 0)
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
                            color: Colors.white,
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
                          fillColor: neutral2,
                          borderColor: Colors.transparent,
                          controller: passwordController,
                          type: TextInputType.text,
                          prefix: Icon(
                            Icons.lock_outline_rounded,
                            size: 18.r,
                            color: Colors.white,
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
                                color: Colors.white,
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
                          onSave: (value) => _authDetails["password"] = value!,
                          hint: "Password",
                        ),
                        SizedBox(
                          height: 250.h,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(390.w, 50.h),
                            backgroundColor: Colors.white,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.h),
                            ),
                          ),
                          onPressed: () => setState(() => index = 1),
                          child: Text(
                            "Proceed",
                            style: context.textTheme.bodyLarge!.copyWith(
                              color: p100,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: context.textTheme.bodyMedium,
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
                                    color: p400, fontWeight: FontWeight.w600),
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
                if (index == 1 && pickedImage == null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
                      GestureDetector(
                        onTap: () => context.router
                            .pushNamed(Pages.camera)
                            .then((response) async {
                          if (response == null) return;
                          String path = (response as File).path;
                          pickedImage =
                              await FileManager.convertSingleToData(path);
                          setState(() {});
                        }),
                        child: Container(
                          width: 390.w,
                          height: 250.r,
                          decoration: BoxDecoration(
                            color: neutral2,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 32.r,
                              ),
                              Text(
                                "Open Camera",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Center(
                        child: Text(
                          "- OR -",
                          style: context.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(390.w, 50.h),
                          backgroundColor: Colors.white,
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.h),
                          ),
                        ),
                        onPressed: () =>
                            FileManager.single(type: FileType.image)
                                .then((resp) {
                          if (resp == null) return;
                          setState(() => pickedImage = resp.data);
                        }),
                        child: Text(
                          "Choose Image from Device",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: p100,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                if (index == 1 && pickedImage != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
                      Container(
                        width: 390.w,
                        height: 250.r,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(pickedImage!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () => setState(() {
                          index = 1;
                          pickedImage = null;
                        }),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Clear Image",
                              style: context.textTheme.bodyLarge!.copyWith(
                                color: p400,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Boxicons.bx_x,
                              color: p400,
                              size: 20.r,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(390.w, 50.h),
                          backgroundColor: Colors.white,
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.h),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Create Account",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: p100,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
