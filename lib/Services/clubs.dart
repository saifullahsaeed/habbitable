import 'package:get/get.dart';
import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/repos/club.dart';

class ClubsService extends GetxService {
  final ClubRepository clubRepository;
  ClubsService() : clubRepository = ClubRepository();

  Future<List<Club>> getMyClubs() async {
    final res = await clubRepository.getMyClubs();
    final List<Club> clubs =
        res.data.map((c) => Club.fromJson(c)).toList().cast<Club>();
    return clubs;
  }

  Future<Club> getClub(String id) async {
    final res = await clubRepository.getClub(id);
    return Club.fromJson(res.data);
  }

  Future<Club> createClub({
    required String name,
    required String description,
    String? imageId,
    bool isPrivate = false,
  }) async {
    final res = await clubRepository.createClub(
      {
        "name": name,
        "description": description,
        "image": imageId,
        "isPrivate": isPrivate,
      },
    );
    return Club.fromJson(res.data);
  }
}
