import 'dart:convert';

class Failure {
  final String? status;
  final int code;
  final String message;
  Failure({
    this.status,
    required this.code,
    required this.message,
  });

  Failure copyWith({
    String? status,
    int? code,
    String? message,
  }) {
    return Failure(
      status: status ?? this.status,
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});
    result.addAll({'code': code});
    result.addAll({'message': message});

    return result;
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      status: map['status'] ?? '',
      code: map['code']?.toInt() ?? 0,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source));

  @override
  String toString() =>
      'Failure(status: $status, code: $code, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure &&
        other.status == status &&
        other.code == code &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ code.hashCode ^ message.hashCode;
}
