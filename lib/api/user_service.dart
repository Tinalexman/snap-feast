import "package:snapfeast/components/user.dart";

import "base.dart";

export "base.dart";

String token = "";

Future<SnapfeastResponse<User?>> createUser(Map<String, dynamic> map) async {
  try {
    Response response = await dio.post("/users/", data: map);

    token = response.data["access_token"];

    Response userResponse = await dio.get(
      "/users/me/",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    Map<String, dynamic> data = userResponse.data as Map<String, dynamic>;

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
  } on DioException catch (e) {
    if (e.response?.statusCode! == 400) {
      return const SnapfeastResponse(
        message: "Email already registered",
        data: null,
        success: false,
      );
    }
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
    Response tokenResponse = await dio.post(
      "/auth/token/",
      data: FormData.fromMap(map),
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );

    token = tokenResponse.data["access_token"];

    Response userResponse = await dio.get(
      "/users/me/",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
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
  } on DioException catch (e) {
    if (e.response?.statusCode! == 401) {
      return const SnapfeastResponse(
        message: "Wrong password",
        data: null,
        success: false,
      );
    }
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
      "/users/login/face/",
      data: form,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );

    token = response.data["access_token"];

    Response userResponse = await dio.get(
      "/users/me/",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
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
    log("Face Login Error: $e");
  }

  return const SnapfeastResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}

Future<SnapfeastResponse> createFace(String facePath) async {
  FormData form = FormData();
  form.files.add(MapEntry("file", await MultipartFile.fromFile(facePath)));

  try {
    await dio.post(
      "/users/me/face/",
      data: form,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $token"
        },
      ),
    );

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
