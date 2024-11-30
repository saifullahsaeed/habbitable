import 'package:get/get.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/repos/user.dart';
import 'package:habbitable/utils/snackbar.dart';

class CommunityController extends GetxController {
  final sentRequests = <HabitInvite>[].obs;
  UserRepository userRepository = UserRepository();
  Rx<List<FriendRequest>> receivedRequests = Rx<List<FriendRequest>>([]);
  List<FriendRequest> get receivedRequestsList => receivedRequests.value;
  List<FriendRequest> queueInAction = [];

  Future<void> getReceivedRequests() async {
    try {
      final response = await userRepository.getReceivedRequests(0, 10);
      if (response.statusCode == 200) {
        receivedRequests.value = List<FriendRequest>.from(
            response.data.map((request) => FriendRequest.fromJson(request)));
      }
    } catch (e) {
      showSnackBar(
        title: "Something went wrong",
        message: "Please try again",
        type: "error",
      );
    }
  }

  Future<void> acceptRequest(int requestId) async {
    try {
      queueInAction.add(receivedRequestsList
          .firstWhere((request) => request.id == requestId));
      receivedRequestsList.removeWhere((request) => request.id == requestId);
      showSnackBar(
        title: "Request accepted",
        message: "Friend request accepted",
        type: "success",
      );
      userRepository.acceptRequest(requestId);
    } catch (e) {
      final request =
          queueInAction.firstWhere((request) => request.id == requestId);
      receivedRequestsList.insert(0, request);
      queueInAction.removeWhere((request) => request.id == requestId);
      showSnackBar(
        title: "Something went wrong",
        message: "Please try again",
        type: "error",
      );
    }
  }

  Future<void> rejectRequest(int requestId) async {
    try {
      queueInAction.add(receivedRequestsList
          .firstWhere((request) => request.id == requestId));
      receivedRequestsList.removeWhere((request) => request.id == requestId);
      showSnackBar(
        title: "Request rejected",
        message: "Friend request rejected",
        type: "success",
      );
      userRepository.rejectRequest(requestId);
    } catch (e) {
      final request =
          queueInAction.firstWhere((request) => request.id == requestId);
      receivedRequestsList.insert(0, request);
      queueInAction.removeWhere((request) => request.id == requestId);
      showSnackBar(
        title: "Something went wrong",
        message: "Please try again",
        type: "error",
      );
    }
  }
}
