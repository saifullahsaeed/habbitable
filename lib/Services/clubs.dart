import 'package:get/get.dart';
import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/models/club/comment.dart';
import 'package:habbitable/models/club/details.dart';
import 'package:habbitable/models/club/post.dart';
import 'package:habbitable/repos/club.dart';

class ClubsService extends GetxService {
  final ClubRepository clubRepository;
  // listinable variable
  final Rx<List<String>> actionPulser = Rx<List<String>>([]);
  ClubsService() : clubRepository = ClubRepository();
  Future<List<Club>> getMyClubs() async {
    final res = await clubRepository.getMyClubs();
    final List<Club> clubs =
        res.data.map((c) => Club.fromJson(c)).toList().cast<Club>();
    return clubs;
  }

  Future<ClubDetails> getClub(String id) async {
    final res = await clubRepository.getClub(id);
    return ClubDetails.fromJson(res.data);
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

  Future<List<Post>> getFeed(int limit, int offset) async {
    final res = await clubRepository.getFeed(limit, offset);
    return res.data.map((c) => Post.fromJson(c)).toList().cast<Post>();
  }

  Future<List<Post>> getClubFeed(String clubId, int limit, int offset) async {
    final res =
        await clubRepository.getClubFeed(clubId, limit: limit, offset: offset);
    return res.data.map((c) => Post.fromJson(c)).toList().cast<Post>();
  }

  Future<bool> likePost(String clubId, String postId) async {
    final res = await clubRepository.likeClubPost(clubId, postId);
    return res.statusCode == 200;
  }

  Future<List<CommentModel>> getPostComments(
      String clubId, String postId, int limit, int offset) async {
    final res =
        await clubRepository.getPostComments(clubId, postId, limit, offset);
    return res.data
        .map((c) => CommentModel.fromJson(c))
        .toList()
        .cast<CommentModel>();
  }

  Future<void> postComment(String clubId, String postId, String content) async {
    await clubRepository.addPostComment(clubId, postId, {"content": content});
  }

  Future<void> replyToComment(
      String clubId, String postId, String parentId, String content) async {
    await clubRepository.addPostComment(clubId, postId, {
      "content": content,
      "parentId": parentId,
    });
  }

  Future<int> addPost(String clubId, Map<String, dynamic> data) async {
    final res = await clubRepository.addClubPost(clubId, data);
    if (res.statusCode == 201) {
      actionPulser.update((state) => [...?state, 'addPost']);
    }
    return res.statusCode ?? 500;
  }
}
