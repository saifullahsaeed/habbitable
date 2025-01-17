import 'package:get/get.dart';
import 'package:habbitable/Services/clubs.dart';

class JoinClubController extends GetxController {
  final clubsService = Get.find<ClubsService>();
  RxBool isLoading = false.obs;
  String clubId = Get.parameters['clubId']!;

  Future<bool> joinClub() async {
    isLoading.value = true;
    bool isJoined = await clubsService.joinClub(clubId);
    isLoading.value = false;
    return isJoined;
  }
}
