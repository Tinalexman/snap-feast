import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/api/user_service.dart';
import 'package:snapfeast/components/food.dart';
import 'package:snapfeast/components/user.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/providers.dart';
import 'package:snapfeast/misc/widgets.dart';

class AccountDetailsPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> details;

  const AccountDetailsPage({
    super.key,
    required this.details,
  });

  @override
  ConsumerState<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends ConsumerState<AccountDetailsPage> {
  late List<String> pickedFoods;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    List<String>? picked = widget.details["preferences"];
    if(picked == null) {
      pickedFoods = [];
      widget.details["preferences"] = pickedFoods;
    } else {
      pickedFoods = picked;
    }
  }


  void showErrorMessage(String msg) => showToast(msg, context);
  void navigate() => context.router.pushNamed(Pages.faceCapture);


  Future<void> createAccount() async {
    SnapfeastResponse<User?> user = await createUser(widget.details);
    setState(() => loading = false);

    if(!user.success) {
      showErrorMessage(user.message);
      return;
    }

    showErrorMessage("Account created!");

    ref.watch(userProvider.notifier).state = user.data!;
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
                  "Which kind of food do you prefer?",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: p150,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  height: 520.h,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.w,
                      mainAxisExtent: 230.h,
                    ),
                    itemBuilder: (_, index) {
                      Food food = availableFoods[index];
                      String image = food.image;
                      bool picked = pickedFoods.contains(food.name);

                      return Column(
                        children: [
                          if (index % 2 == 1) SizedBox(height: 30.h),
                          GestureDetector(
                            onTap: () {
                              if (picked) {
                                pickedFoods.remove(food.name);
                              } else {
                                pickedFoods.add(food.name);
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 200.h,
                              width: 390.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                image: DecorationImage(
                                  image: AssetImage(image),
                                  fit: BoxFit.cover,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.black45,
                                    BlendMode.darken,
                                  ),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 10.h,
                                        ),
                                        child: Text(
                                          food.name,
                                          style: context.textTheme.bodyLarge!
                                              .copyWith(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    top: 0.h,
                                    right: -1.w,
                                    child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      opacity: picked ? 1 : 0,
                                      child: ClipPath(
                                        clipper: _PreferenceClipper(5.r),
                                        child: Container(
                                          width: 60.r,
                                          height: 40.r,
                                          color: p100,
                                          padding: EdgeInsets.only(
                                              right: 7.w, top: 3.h),
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.done_rounded,
                                            color: Colors.white,
                                            size: 20.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (index % 2 == 0) SizedBox(height: 30.h),
                        ],
                      );
                    },
                    itemCount: availableFoods.length,
                  ),
                ),
                SizedBox(height: 20.h),
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

                    if(pickedFoods.isEmpty) {
                      showToast("Choose at least one type of food", context);
                      return;
                    }

                    setState(() => loading = true);
                    createAccount();
                  },
                  child: loading ? whiteLoader : Text(
                    "Create Account",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Montserrat",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreferenceClipper extends CustomClipper<Path> {
  final double radius;

  _PreferenceClipper(this.radius);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width - (radius * 3), 0);
    path.arcToPoint(
      Offset(size.width, radius * 3),
      radius: Radius.circular(3 * radius),
    );
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
