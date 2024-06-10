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

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Uint8List? pickedImage;

  final Map<String, dynamic> authDetails = {
    "firstName": "",
    "lastName": "",
    "age": "",
    "email": "",
    "password": "",
    "face": "",
  };

  int index = 0;
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
                      fontFamily: "Montserrat"),
                ),
                Text(
                  index == 0
                      ? "Creating your account has never being easier"
                      : index == 1 ? "Now let's see what you look like" :
                  "You're almost done",
                  style: context.textTheme.bodyMedium!.copyWith(
                      color: p150,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                  ),
                  textAlign: TextAlign.center,
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
                          onPressed: () => setState(() => index = 1),
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
                if (index == 1 && pickedImage == null)
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
                              String path = (response as File).path;
                              pickedImage =
                                  await FileManager.convertSingleToData(path);
                              setState(() {});
                            }),
                          ),
                        ),
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
                                color: p100,
                                size: 32.r,
                              ),
                              Text(
                                "Open Camera",
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: p150,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat",
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
                          style: context.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
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
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => ImageDialog(
                            text: openGalleryDialog,
                            onProceed: () =>
                                FileManager.single(type: FileType.image)
                                    .then((resp) {
                              if (resp == null) return;
                              setState(() => pickedImage = resp.data);
                            }),
                          ),
                        ),
                        child: Text(
                          "Choose Image from Device",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Montserrat",
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
                                fontFamily: "Montserrat",
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
                          backgroundColor: p100,
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.h),
                          ),
                        ),
                        onPressed: () {
                          File file = File.fromRawPath(pickedImage!);
                          authDetails["face"] = file;
                          setState(() => index = 2);
                        },
                        child: Text(
                          "Continue",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      )
                    ],
                  ),
                if(index == 2)
                  Column(
                    children: [
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: firstNameController,
                        prefix: Icon(
                          Icons.person_2_rounded,
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
                        onSave: (value) => authDetails["firstName"] = value!,
                        hint: "First Name",
                      ),
                      SizedBox(height: 10.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: lastNameController,
                        prefix: Icon(
                          Icons.person_2_rounded,
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
                        onSave: (value) => authDetails["lastName"] = value!,
                        hint: "Last Name",
                      ),
                      SizedBox(height: 10.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: ageController,
                        type: TextInputType.number,
                        prefix: Icon(
                          Icons.cake,
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
                      SizedBox(
                        height: 150.h,
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
                          context.router.pushNamed(Pages.details);
                        },
                        child: Text(
                          "Continue",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
