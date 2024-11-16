import 'package:dio/dio.dart';
// import 'package:habbitable/Services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpWrapper {
  final String baseUrl = "http://localhost:3000/";
  final int timeout = 10000; //timeout in milliseconds 1s = 1000ms
  final String contentType = "application/json";
  final Dio dio = Dio();
  late Future<SharedPreferences> sharedPreferences;

  HttpWrapper() {
    sharedPreferences = SharedPreferences.getInstance();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = (await sharedPreferences).getString('token') ?? '';
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      // onError: (DioException e, ErrorInterceptorHandler handler) async {
      //   if (e.response?.statusCode == 401) {
      //     return handler.next(e);
      //   }
      // },
    ));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.get(
        baseUrl + path,
        queryParameters: queryParameters,
        options: Options(
          contentType: contentType,
          responseType: ResponseType.json,
        ),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> post(String path,
      {Map<String, dynamic>? data, bool auth = true}) async {
    try {
      return await dio.post(
        baseUrl + path,
        data: data,
        options: Options(
          contentType: contentType,
          responseType: ResponseType.json,
        ),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      return await dio.put(
        baseUrl + path,
        data: data,
        options: Options(
          contentType: contentType,
          responseType: ResponseType.json,
        ),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await dio.delete(baseUrl + path);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> patch(String path, {Map<String, dynamic>? data}) async {
    try {
      return await dio.patch(baseUrl + path, data: data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }
}
