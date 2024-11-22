import 'package:get/get.dart';
import 'package:habbitable/Services/habits.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/models/time_spent.dart';
import 'package:habbitable/utils/functions.dart';

class HomeController extends GetxController {
  final HabitsService habitsService = Get.find<HabitsService>();
  final RxList<Habit> _habits = <Habit>[].obs;

  RxList<Habit> get habits => _habits;

  @override
  void onInit() {
    super.onInit();
    getHabits();
  }

  void removeHabit(int habitId) {
    _habits.removeWhere((h) => h.id == habitId);
  }

  List<Habit> get habitsTodaysUpcoming => _habits;

  Future<void> getHabits() async {
    _habits.value = await habitsService.getHabitsByDate(DateTime.now());
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
    Habit habit = _habits.firstWhere((h) => h.id == int.parse(id));
    habit.lastCompleted = DateTime.now();
    habit.streak = habit.streak + 1;
    await habitsService.completeHabit(id);
  }

  Future<void> undoHabit(String id) async {
    Habit habit = _habits.firstWhere((h) => h.id == int.parse(id));
    if (habit.streak > 0) {
      habit.streak = habit.streak - 1;
    }
    await habitsService.undoHabit(id);
  }

  Future<List<int>> getTimeSpent(
      {DateTime? startDate, DateTime? endDate}) async {
    startDate ??= startOfWeek();
    endDate ??= endOfWeek();
    final data = await habitsService.getTimeSpent(startDate, endDate);
    List<int> result = List<int>.filled(7, 0);
    for (var t in data) {
      int dayOfWeek = t.date.weekday;
      dayOfWeek = dayOfWeek == 7 ? 0 : dayOfWeek;
      result[dayOfWeek] = t.totalTime;
    }
    return result;
  }
}
