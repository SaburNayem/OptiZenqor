class ServiceModel<T> {
  const ServiceModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  final bool success;
  final int statusCode;
  final String message;
  final T? data;

  factory ServiceModel.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic value)? fromData,
  }) {
    return ServiceModel<T>(
      success: json['success'] as bool? ?? false,
      statusCode: json['statusCode'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      data: fromData != null ? fromData(json['data']) : json['data'] as T?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data,
    };
  }
}
