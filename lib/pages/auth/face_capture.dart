import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/api/file_manager.dart';
import 'package:snapfeast/api/user_service.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/widgets/common.dart';

class FaceCapture extends StatefulWidget {
  const FaceCapture({super.key});

  @override
  State<FaceCapture> createState() => _FaceCaptureState();
}

class _FaceCaptureState extends State<FaceCapture> {
  String? pickedImage;

  bool loading = false;


  void showErrorMessage(String msg) => showToast(msg, context);

  void navigate() => context.router.pushReplacementNamed(Pages.home);

  Future<void> useFaceCreation() async {
    SnapfeastResponse face = await createFace(pickedImage!);
    setState(() => loading = false);

    if (!face.success) {
      showErrorMessage(face.message);
      return;
    }

    showErrorMessage("Face embeddings created!");

    navigate();
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
                  "Now let's see what you look like",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: p150,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                if (pickedImage == null)
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
                                .then((response) {
                              if (response == null) return;
                              setState(
                                  () => pickedImage = (response as File).path);
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
                              setState(() => pickedImage = resp.path);
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
                if (pickedImage != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
                      Container(
                        width: 390.w,
                        height: 250.r,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(pickedImage!)),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () => setState(() => pickedImage = null),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Remove Image",
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
                         if(loading) return;
                         if(pickedImage == null) {
                           showToast("Please choose/capture a photo of yourself", context);
                           return;
                         }

                         setState(() => loading = true);

                         useFaceCreation();
                        },
                        child: loading
                            ? whiteLoader
                            :  Text(
                          "Save and Continue",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Montserrat",
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
