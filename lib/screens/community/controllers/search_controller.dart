import 'package:get/get.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/repos/user.dart';

class SearchUserController extends GetxController {
  final UserRepository userRepository;
  SearchUserController() : userRepository = UserRepository();

  Future<List<User>> searchUser(String search) async {
    final response = await userRepository.searchUser(search);
    List<User> users = [];
    if (response.statusCode == 200) {
      for (var user in response.data) {
        users.add(User.fromJson(user));
      }
    }
    return users;
  }

  Future<int> sendFriendRequest(User user) async {
    final response = await userRepository.sendRequest(user.id);
    return response.statusCode ?? 500;
  }
}
