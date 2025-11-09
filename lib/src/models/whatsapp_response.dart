class WhatsAppResponse {
  final bool status;
  final int statusCode;
  final dynamic data;
  final String message;

  WhatsAppResponse({required this.status, required this.statusCode, this.data, required this.message});

  factory WhatsAppResponse.fromJson(Map<String, dynamic> json) {
    return WhatsAppResponse(
      status: json['status'] as bool? ?? false,
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : (json['status_code'] is int ? json['status_code'] as int : 0),
      data: json['data'],
      message: json['message']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'statusCode': statusCode, 'data': data, 'message': message};
}
