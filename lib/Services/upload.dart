import 'package:get/get.dart';
import 'package:habbitable/repos/upload.dart';
import 'package:habbitable/utils/snackbar.dart';

class UploadService extends GetxController {
  UploadRepository uploadRepository = UploadRepository();

  Future<String> uploadImage(String path) async {
    try {
      final upload = await uploadRepository.uploadImage(path);
      if (upload.statusCode == 201) {
        return upload.data['id'].toString();
      } else {
        throw Exception("Failed to upload image");
      }
    } catch (e) {
      showSnackBar(
        title: "Error",
        message: e.toString(),
        type: "error",
      );
      return '';
    }
  }
}
