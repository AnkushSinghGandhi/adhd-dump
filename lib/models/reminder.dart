class Reminder {
  final String id;
  final String title;
  final String dumpId;
  final DateTime fireAt;
  final String recurrence;
  final String priority;
  final bool isCompleted;
  final bool isMissed;
  final int snoozeCount;

  Reminder({
    required this.id,
    required this.title,
    required this.dumpId,
    required this.fireAt,
    required this.recurrence,
    required this.priority,
    required this.isCompleted,
    required this.isMissed,
    required this.snoozeCount,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String,
      title: json['title'] as String,
      dumpId: json['dumpId'] as String,
      fireAt: DateTime.parse(json['fireAt'] as String),
      recurrence: json['recurrence'] as String,
      priority: json['priority'] as String,
      isCompleted: json['isCompleted'] as bool,
      isMissed: json['isMissed'] as bool,
      snoozeCount: json['snoozeCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dumpId': dumpId,
      'fireAt': fireAt.toIso8601String(),
      'recurrence': recurrence,
      'priority': priority,
      'isCompleted': isCompleted,
      'isMissed': isMissed,
      'snoozeCount': snoozeCount,
    };
  }

  Reminder copyWith({
    String? id,
    String? title,
    String? dumpId,
    DateTime? fireAt,
    String? recurrence,
    String? priority,
    bool? isCompleted,
    bool? isMissed,
    int? snoozeCount,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      dumpId: dumpId ?? this.dumpId,
      fireAt: fireAt ?? this.fireAt,
      recurrence: recurrence ?? this.recurrence,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      isMissed: isMissed ?? this.isMissed,
      snoozeCount: snoozeCount ?? this.snoozeCount,
    );
  }
}
