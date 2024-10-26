import 'package:get/get.dart';
import 'package:habbitable/Services/habits.dart';
import 'package:habbitable/models/habit_logs.dart';

class HabitScreenController extends GetxController {
  final HabitsService habitsService = Get.find<HabitsService>();
  final RxBool habitLogsLoading = false.obs;
  final RxList<HabitLog> habitLogs = RxList<HabitLog>([]);
  final RxList<HabitLog> selectedDayLogs = RxList<HabitLog>([]);

  @override
  void onInit() {
    super.onInit();
    fetchHabitLogs(Get.arguments['habit'].id, DateTime.now());
  }

  Future<void> fetchHabitLogs(int habitId, DateTime month) async {
    habitLogsLoading.value = true;
    final startDate = DateTime(month.year, month.month, 1);
    final endDate = DateTime(month.year, month.month + 1, 0);
    final habitLogs =
        await habitsService.getHabitLogsRange(habitId, startDate, endDate);
    this.habitLogs.value = habitLogs;
    habitLogsLoading.value = false;
    update();
  }

  void onDaySelected(List<HabitLog> logs) {
    selectedDayLogs.value = logs;
    update();
  }
}
