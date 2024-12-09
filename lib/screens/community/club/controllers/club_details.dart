import 'package:get/get.dart';
import 'package:habbitable/Services/clubs.dart';
import 'package:habbitable/models/club/details.dart';

class ClubDetailsController extends GetxController {
  final ClubsService clubsService;
  ClubDetailsController() : clubsService = ClubsService();

  Future<ClubDetails> getClub(String id) async {
    return await clubsService.getClub(id);
  }
}
