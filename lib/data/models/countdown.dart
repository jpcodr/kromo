import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum CountdownType {
  simple(label: 'Simple'),
  extended(label: 'Avanzado');

  const CountdownType({
    required this.label,
  });

  final String label;
}

class Countdown extends Equatable {
  Countdown({
    this.currentFrame,
    String? id,
    this.name,
    this.targetFrame,
    required this.time,
    this.type = CountdownType.simple,
  }) : id = id ?? const Uuid().v4();

  final int? currentFrame;
  final String id;
  final String? name;
  final int? targetFrame;
  final int time;
  final CountdownType type;

  @override
  List<Object?> get props => [
        currentFrame,
        name,
        id,
        targetFrame,
        time,
        type,
      ];

  @override
  bool get stringify => true;

  factory Countdown.fromMap(Map<String, dynamic> json) => Countdown(
        currentFrame: json['currentFrame'],
        targetFrame: json['targetFrame'],
        id: json['id'],
        name: json['name'],
        time: json['time'] as int,
        type: CountdownType.values.byName(json['type']),
      );

  Map<String, dynamic> toMap() {
    return {
      'currentFrame': currentFrame,
      'id': id,
      'name': name,
      'targetFrame': targetFrame,
      'time': time,
      'type': type.name,
    };
  }
}
