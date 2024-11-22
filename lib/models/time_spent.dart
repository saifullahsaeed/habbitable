class TimeSpent {
  final DateTime date;
  final int totalTime;

  TimeSpent({required this.date, required this.totalTime});

  factory TimeSpent.fromJson(Map<String, dynamic> json) {
    return TimeSpent(
      date: DateTime.parse(json['date']),
      totalTime: json['totalTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'totalTime': totalTime,
    };
  }
}
