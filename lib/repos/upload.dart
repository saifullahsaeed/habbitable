import 'package:dio/dio.dart';
import 'package:habbitable/utils/api_client.dart';

class UploadRepository {
  final HttpWrapper httpWrapper;
  final String base = "files/";
  UploadRepository() : httpWrapper = HttpWrapper();

  Future<Response> uploadImage(String file) async {
    return await httpWrapper.post(base, data: {'file': file});
  }

  Future<Response> deleteImage(String file) async {
    return await httpWrapper.delete('$base$file');
  }
}
