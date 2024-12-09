import 'package:dio/dio.dart';
import 'package:habbitable/utils/api_client.dart';

class ClubRepository {
  final HttpWrapper httpWrapper;
  final String base = "clubs/";
  ClubRepository() : httpWrapper = HttpWrapper();

  Future<Response> getMyClubs() async {
    return await httpWrapper.get(base);
  }

  Future<Response> getClub(String id) async {
    return await httpWrapper.get('$base$id');
  }

  Future<Response> createClub(Map<String, dynamic> data) async {
    return await httpWrapper.post(base, data: data);
  }

  Future<Response> updateClub(String id, Map<String, dynamic> data) async {
    return await httpWrapper.put('$base$id', data: data);
  }

  Future<Response> deleteClub(String id) async {
    return await httpWrapper.delete('$base$id');
  }

  Future<Response> getClubHabits(String id) async {
    return await httpWrapper.get('$base$id/habits');
  }

  Future<Response> addClubHabit(String clubId, String habitId) async {
    return await httpWrapper.post('$base$clubId/add-habit', data: {
      'habitId': habitId,
    });
  }

  Future<Response> removeClubHabit(String clubId, String habitId) async {
    return await httpWrapper.delete('$base$clubId/remove-habit/$habitId');
  }

  Future<Response> getClubPosts(String id) async {
    return await httpWrapper.get('$base$id/posts');
  }

  Future<Response> addClubPost(String clubId, Map<String, dynamic> data) async {
    return await httpWrapper.post('$base$clubId/add-post', data: data);
  }

  Future<Response> updateClubPost(
      String clubId, String postId, Map<String, dynamic> data) async {
    return await httpWrapper.patch('$base$clubId/update-post/$postId',
        data: data);
  }

  Future<Response> deleteClubPost(String clubId, String postId) async {
    return await httpWrapper.delete('$base$clubId/delete-post/$postId');
  }

  Future<Response> likeClubPost(String clubId, String postId) async {
    return await httpWrapper.post('$base$clubId/like-post/$postId');
  }

  Future<Response> getPostComments(
      String clubId, String postId, int limit, int offset) async {
    return await httpWrapper
        .get('$base$clubId/comments/$postId?limit=$limit&offset=$offset');
  }

  Future<Response> addPostComment(
      String clubId, String postId, Map<String, dynamic> data) async {
    return await httpWrapper.post('$base$clubId/add-comment/$postId',
        data: data);
  }

  Future<Response> deleteComment(String clubId, String commentId) async {
    return await httpWrapper.delete('$base$clubId/delete-comment/$commentId');
  }

  Future<Response> likeComment(String clubId, String commentId) async {
    return await httpWrapper.post('$base$clubId/like-comment/$commentId');
  }

  Future<Response> getFeed(int limit, int offset) async {
    final res =
        await httpWrapper.get('$base' 'feed?limit=$limit&offset=$offset');
    return res;
  }
}
