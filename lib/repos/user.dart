import 'package:dio/dio.dart';
import 'package:habbitable/utils/api_client.dart';

class UserRepository {
  final HttpWrapper httpWrapper;
  final String base = "user/";
  UserRepository() : httpWrapper = HttpWrapper();

  Future<Response> getProfile(int userId) async {
    return await httpWrapper.get('$base$userId/profile');
  }

  Future<Response> updateProfile(int userId, Map<String, dynamic> data) async {
    return await httpWrapper.put('$base' 'profile', data: data);
  }

  Future<Response> getMyFriends(int? skip, int? limit) async {
    return await httpWrapper.get('$base' 'friends', queryParameters: {
      'skip': skip,
      'limit': limit,
    });
  }

  Future<Response> sendRequest(int friendId) async {
    return await httpWrapper.post('$base' 'friend-request', data: {
      'friendId': friendId,
    });
  }

  Future<Response> rejectRequest(int friendId) async {
    return await httpWrapper.put('$base' 'friend-request/$friendId/reject');
  }

  Future<Response> acceptRequest(int friendId) async {
    return await httpWrapper.put('$base' 'friend-request/$friendId/accept');
  }

  Future<Response> withdrawRequest(int friendRequestId) async {
    return await httpWrapper
        .delete('$base' 'friend-request/$friendRequestId/withdraw');
  }

  Future<Response> getSentRequests(int? skip, int? limit) async {
    return await httpWrapper
        .get('$base' 'friend-requests-sent', queryParameters: {
      'skip': skip,
      'limit': limit,
    });
  }

  Future<Response> getReceivedRequests(int? skip, int? limit) async {
    return await httpWrapper.get('$base' 'friend-requests', queryParameters: {
      'skip': skip,
      'limit': limit,
    });
  }

  Future<Response> searchUser(String search) async {
    return await httpWrapper.get('$base' 'search', queryParameters: {
      'query': search,
    });
  }

  Future<Response> removeFriend(int friendId) async {
    return await httpWrapper.delete('$base' 'friends/$friendId');
  }
}
