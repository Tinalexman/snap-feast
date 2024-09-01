import "package:snapfeast/components/user.dart";

import "base.dart";

export "base.dart";

String token = "";

Future<SnapfeastResponse<User?>> createUser(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post("/users/", data: map);
    Map<String, dynamic> data = response.data;
    token = data["access_token"];



    return SnapfeastResponse(
      message: "Success",
      data: User(
        email: data["email"],
        firstName: data["first_name"],
        lastName: data["last_name"],
        age: (data["age"] as num).toInt(),
      ),
      success: true,
    );
  } catch (e) {
    log("Create User Error: $e");
  }

  return const SnapfeastResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}

Future<SnapfeastResponse<User?>> manualLogin(Map<String, dynamic> map) async {
  try {
    Response tokenResponse = await dio.post("/auth/token", data: map);
    log("${tokenResponse.data}");
    token = tokenResponse.data as String;



    Response userResponse = await dio.get(
      "/users/me",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
    log("${userResponse.data}");
    Map<String, dynamic> data = userResponse.data;

    return SnapfeastResponse(
      message: "Success",
      data: User(
        email: data["email"],
        firstName: data["first_name"],
        lastName: data["last_name"],
        age: (data["age"] as num).toInt(),
      ),
      success: true,
    );
  } catch (e) {
    log("Manual Login Error: $e");
  }

  return const SnapfeastResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}

Future<SnapfeastResponse<User?>> faceLogin(String facePath) async {
  FormData form = FormData();
  form.files.add(MapEntry("file", await MultipartFile.fromFile(facePath)));

  try {
    Response response = await dio.post(
      "/users/login/face",
      data: form,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    Map<String, dynamic> data = response.data;
    return SnapfeastResponse(
      message: "Success",
      data: User(
        email: data["email"],
        firstName: data["first_name"],
        lastName: data["last_name"],
        age: (data["age"] as num).toInt(),
      ),
      success: true,
    );
  } catch (e) {
    log("Face Login Error: $e");
  }

  return const SnapfeastResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}

Future<SnapfeastResponse> createFace(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post("/users/me/face");
    // Map<String, dynamic> data = response.data;
    return const SnapfeastResponse(
      message: "Success",
      success: true,
      data: null,
    );
  } catch (e) {
    log("Create Face Error: $e");
  }

  return const SnapfeastResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}
