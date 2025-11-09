class OtpData {
  final int? otpId;
  final String? phone;
  final String? expiresAt;
  final String? otpCode;
  final String? message;
  final bool? isVerified;
  final String? verifiedAt;
  final bool? isExpired;

  OtpData({this.otpId, this.phone, this.expiresAt, this.otpCode, this.message, this.isVerified, this.verifiedAt, this.isExpired});

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      otpId: json['otp_id'] as int?,
      phone: json['phone'] as String?,
      expiresAt: json['expires_at'] as String?,
      otpCode: json['otp_code'] as String?,
      message: json['message'] as String?,
      isVerified: json['is_verified'] as bool?,
      verifiedAt: json['verified_at'] as String?,
      isExpired: json['is_expired'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'otp_id': otpId,
    'phone': phone,
    'expires_at': expiresAt,
    'otp_code': otpCode,
    'message': message,
    'is_verified': isVerified,
    'verified_at': verifiedAt,
    'is_expired': isExpired,
  };
}
