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
    this.gap = 0,
    String? id,
    this.name,
    this.targetFrame,
    required this.duration,
    this.type = CountdownType.simple,
  }) : id = id ?? const Uuid().v4();

  final int? currentFrame;
  final int gap;
  final String id;
  final String? name;
  final int? targetFrame;
  final Duration duration;
  final CountdownType type;

  Countdown.fromMilliseconds(
    int time, {
    this.currentFrame,
    this.gap = 0,
    String? id,
    this.name,
    this.targetFrame,
    this.type = CountdownType.simple,
  })  : id = id ?? const Uuid().v4(),
        duration = Duration(milliseconds: time);

  @override
  List<Object?> get props => [
        currentFrame,
        gap,
        name,
        id,
        targetFrame,
        duration,
        type,
      ];

  @override
  bool get stringify => true;

  factory Countdown.fromMap(Map<String, dynamic> json) => Countdown(
        currentFrame: json['currentFrame'],
        gap: json['gap'] ?? 0,
        targetFrame: json['targetFrame'],
        id: json['id'],
        name: json['name'],
        duration: Duration(milliseconds: json['time'] as int),
        type: CountdownType.values.byName(json['type']),
      );

  Map<String, dynamic> toMap() {
    return {
      'currentFrame': currentFrame,
      'gap': gap,
      'id': id,
      'name': name,
      'targetFrame': targetFrame,
      'time': duration.inMilliseconds,
      'type': type.name,
    };
  }
}
