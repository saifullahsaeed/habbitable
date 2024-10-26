import 'package:dio/dio.dart';

class HttpWrapper {
  final String baseUrl = "http://localhost:3000/";
  final int timeout = 10000; //timeout in milliseconds 1s = 1000ms
  final String contentType = "application/json";
  final Dio dio = Dio();

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(
      baseUrl + path,
      queryParameters: queryParameters,
      options: Options(
        contentType: contentType,
        responseType: ResponseType.json,
      ),
    );
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
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
    return await dio.put(
      baseUrl + path,
      data: data,
      options: Options(
        contentType: contentType,
        responseType: ResponseType.json,
      ),
    );
  }

  Future<Response> delete(String path) async {
    return await dio.delete(baseUrl + path);
  }

  Future<Response> patch(String path, {Map<String, dynamic>? data}) async {
    return await dio.patch(baseUrl + path, data: data);
  }
}
