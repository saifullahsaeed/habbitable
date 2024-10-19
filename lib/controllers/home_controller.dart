import 'package:get/get.dart';
import 'package:habbitable/Services/habits.dart';
import 'package:habbitable/models/habit.dart';

class HomeController extends GetxController {
  final HabitsService habitsService = Get.find<HabitsService>();
  final RxList<Habit> _habits = <Habit>[].obs;

  List<Habit> get habits => _habits;

  @override
  void onInit() {
    super.onInit();
    getHabits();
  }

  Future<void> getHabits() async {
    _habits.value = await habitsService.getHabits();
  }

  Future<void> createHabit(Habit habit) async {
    await habitsService.createHabit(habit);
    getHabits();
  }

  Future<void> updateHabit(Habit habit) async {
    await habitsService.updateHabit(habit);
    getHabits();
  }

  Future<void> deleteHabit(String id) async {
    await habitsService.deleteHabit(id);
    getHabits();
  }

  Future<void> completeHabit(String id) async {
    await habitsService.completeHabit(id);
    getHabits();
  }

  Future<void> undoHabit(String id) async {
    await habitsService.undoHabit(id);
    getHabits();
  }
}
