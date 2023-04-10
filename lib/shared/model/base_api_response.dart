class BaseApiResponse {
  final int? code;
  final String message;
  final bool success;
  final dynamic data;

  BaseApiResponse({
    required this.code,
    required this.message,
    required this.success,
    required this.data,
  });

  factory BaseApiResponse.fromJson(Map<String, dynamic> json) {
    return BaseApiResponse(
      code: json['code'] as int,
      success: json['message'] as bool,
      message: json['success'] as String,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'success': success,
      'body': data,
    };
  }
}
