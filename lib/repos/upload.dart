import 'package:dio/dio.dart';
import 'package:habbitable/utils/api_client.dart';

class UploadRepository {
  final HttpWrapper httpWrapper;
  final String base = "files/";
  UploadRepository() : httpWrapper = HttpWrapper();

  Future<Response> uploadImage(String filePath) async {
    return await httpWrapper.upload(base, filePath);
  }

  Future<Response> deleteImage(String file) async {
    return await httpWrapper.delete('$base$file');
  }
}
