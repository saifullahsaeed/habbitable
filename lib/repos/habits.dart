import 'package:dio/dio.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/models/habit_logs.dart';
import 'package:habbitable/utils/api_client.dart';

class HabitsRepository {
  final HttpWrapper httpWrapper;
  final String base = "habits/";
  HabitsRepository() : httpWrapper = HttpWrapper();

  Future<Response> getHabits() async {
    return await httpWrapper.get(base);
  }

  Future<Response> createHabit(Habit habit) async {
    return await httpWrapper.post(base, data: habit.toJson());
  }

  Future<Response> updateHabit(Habit habit) async {
    return await httpWrapper.put('$base${habit.id}', data: habit.toJson());
  }

  Future<Response> deleteHabit(int id) async {
    return await httpWrapper.delete('$base$id');
  }

  Future<Response> completeHabit(HabitLog habitLog) async {
    return await httpWrapper.post('$base' 'log', data: habitLog.toJson());
  }

  Future<Response> getHabitByDate(DateTime date) async {
    return await httpWrapper.get('$base' 'by-date', queryParameters: {
      'date': date.toIso8601String(),
    });
  }

  Future<Response> getHabitLogsRange(
      int habitId, DateTime startDate, DateTime endDate) async {
    return await httpWrapper
        .get('$base$habitId/logs/by-date-range', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
  }

  Future<Response> getTimeSpent(DateTime startDate, DateTime endDate) async {
    return await httpWrapper.get('$base' 'mytimespent', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
  }
}
