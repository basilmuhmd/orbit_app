import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:orbit_teams_flutter/api/api_routes.dart';
import 'package:orbit_teams_flutter/api/cofig.dart';
import 'package:orbit_teams_flutter/models/api_response_model.dart';
import 'package:orbit_teams_flutter/utils/app_prefrence/app_prefr.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIRoutes.baseURL,
      connectTimeout: const Duration(seconds: timeoutDuration),
    ),
  );

  static Dio getDio() {
    return _dio;
  }
}

Map<String, dynamic> buildHeader() {
  String? token = getStringAsync(tokenPref);

  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  if (!token.isEmptyOrNull) {
    log('Token: $token');
    headers['Authorization'] = 'Bearer $token';
  }

  return headers;
}

Future<Response> postRequest(String endPoint, dynamic body) async {
  Dio dio = DioClient.getDio();

  try {
    if (!await isNetworkAvailable()) throw noInternetMsg;

    log('Request: $endPoint $body');

    Response response = await dio.post(endPoint,
        data: body,
        options: Options(
          headers: buildHeader(),
        ));

    // Log the response received
    log('Response: $endPoint ${response.statusCode} ${response.data.toString()}');
    return response;
  } catch (e) {
    log(e);

    if (!await isNetworkAvailable()) {
      throw noInternetMsg;
    } else {
      throw "language.lblPleaseTryAgain";
    }
  }
}

Future<Response> getRequest(String endPoint) async {
  Dio dio = DioClient.getDio();
  try {
    if (!await isNetworkAvailable()) throw noInternetMsg;
    log('Request : $endPoint');

    Response response =
        await dio.get(endPoint, options: Options(headers: buildHeader()));

    log('Response: $endPoint ${response.statusCode} ${response.toString()}');
    return response;
  } catch (e) {
    log(e.toString());
    if (!await isNetworkAvailable()) {
      throw noInternetMsg;
    } else if (e is DioException && e.response?.statusCode == 400) {
      throw 'Error 400: ${e.response?.data['message'] ?? 'Bad Request'}';
    } else {
      toast("language.lblPleaseTryAgain");
      throw "language.lblPleaseTryAgain";
    }
  }
}

Future<Response> getRequstWithQuery(String endPoint, String query) async {
  Dio dio = DioClient.getDio();

  try {
    if (!await isNetworkAvailable()) throw noInternetMsg;
    String url = '$endPoint?$query';

    Response response =
        await dio.get(url, options: Options(headers: buildHeader())).timeout(
              const Duration(seconds: timeoutDuration),
              onTimeout: () => throw "language.lblPleaseTryAgain",
            );

    log('Response: $url ${response.statusCode} ${response.data.toString()}');
    log(response.data.toString());
    return response;
  } catch (e) {
    log(e.toString());
    if (!await isNetworkAvailable()) {
      throw noInternetMsg;
    } else {
      toast("language.lblPleaseTryAgain");
      throw "language.lblPleaseTryAgain";
    }
  }
}

Future<bool> multipartRequest(String endPoint, String filePath) async {
 Dio dio = DioClient.getDio();
  try {
    if (!await isNetworkAvailable()) throw noInternetMsg;

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });
    log("Multipart Request: $endPoint with file: $filePath");

    Response response = await dio.post(
      endPoint,
      data: formData,
      options: Options(headers: buildHeader()),
    );

    log('Multipart Response: $endPoint Status ${response.statusCode}');

    return response.statusCode == 200;
  } catch (e) {
    log(e.toString());
    if (!await isNetworkAvailable()) {
      throw noInternetMsg;
    } else {
      toast("language.lblPleaseTryAgain");
      throw "language.lblPleaseTryAgain";
    }
  }
}

Future<Response> multipartRequestWithData(
    String endPoint, String filePath, Map<String, String> data) async {
  Dio dio = DioClient.getDio();
  try {
    if (!await isNetworkAvailable()) throw noInternetMsg;

    log("Multipart Request to: $endPoint with file: $filePath");

    FormData formData = FormData.fromMap({
      ...data,
      "file": await MultipartFile.fromFile(filePath),
    });

    Response response = await dio.post(
      endPoint,
      data: formData,
      options: Options(headers: buildHeader()),
    );

    log('"Multipart Response: $endPoint Status ${response.statusCode}');

    return response;
  } catch (e) {
    log(e);
    if (!await isNetworkAvailable()) {
      throw noInternetMsg;
    } else {
      toast("lblPleaseTryAgain");
      throw "language.lblPleaseTryAgain";
    }
  }
}



Future<bool> multipartRequestWithMultiFile(String endPoint, List<String> filePaths, Map<String, String> data) async {
  try {
    if (!await isNetworkAvailable()) throw noInternetMsg;

  
    Dio dio = DioClient.getDio();

    
    FormData formData = FormData();
    formData.fields.addAll(data.entries);

    for (String filePath in filePaths) {
      formData.files.add(
        MapEntry(
          'file',
          await MultipartFile.fromFile(filePath, filename: filePath.split('/').last),
        ),
      );
    }

    log("Multipart Request: $formData");

    
    Response response = await dio.post(
      endPoint,
      data: formData,
      options: Options(headers: buildHeader()),
    );

    log('Multipart Response: $endPoint Status ${response.statusCode}');

    return response.statusCode == 200;
  } catch (e) {
    log(e.toString());

    if (!await isNetworkAvailable()) {
      throw noInternetMsg;
    } else {
      toast("language.lblPleaseTryAgain");
      throw "language.lblPleaseTryAgain";
    }
  }
}



Future<ApiResponseModel?> handleResponse(Response response) async {
  if (response.statusCode.isSuccessful()) {
    var resModel =
        ApiResponseModel.fromJson(response.data); // No need for jsonDecode
    return resModel;
  } else if (response.statusCode == 401) {
    // sharedHelper.logout();
    throw ('Please login again');
  } else if (response.statusCode == 400) {
    var resModel =
        ApiResponseModel.fromJson(response.data); // No need for jsonDecode
    return resModel;
  } else {
    return null;
  }
}
