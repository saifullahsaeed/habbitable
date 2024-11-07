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
}
