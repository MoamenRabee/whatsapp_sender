import 'dart:async';
import 'package:dio/dio.dart';
import 'constants/endpoints.dart';
import 'models/whatsapp_response.dart';
import 'models/otp_data.dart';

class WhatsAppSender {
  final String _apiKey;
  final Dio _dio = Dio();

  WhatsAppSender(this._apiKey);

  /// Sends a message and returns either:
  /// - a [WhatsAppResponse] if the API returned JSON with `status: true`,
  /// - a `String` message when `status` is false or on error.
  Future<WhatsAppResponse> sendMessage(String phoneNumber, String message) async {
    final url = Endpoints.whatsappApi + Endpoints.sendMessage;
    try {
      final response = await _dio.post(url, data: {'api_key': _apiKey, 'phone_number': phoneNumber, 'message': message});

      if (response.statusCode == 200) {
        final responseData = response.data;
        final whatsappResponse = WhatsAppResponse.fromJson(Map<String, dynamic>.from(responseData));

        if (whatsappResponse.status) {
          return whatsappResponse;
        } else {
          return WhatsAppResponse(
            status: false,
            statusCode: whatsappResponse.statusCode,
            data: null,
            message: 'Failed to send message: ${whatsappResponse.message}',
          );
        }
      } else {
        return WhatsAppResponse(
          status: false,
          statusCode: response.statusCode ?? 0,
          data: null,
          message: 'HTTP Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return WhatsAppResponse(status: false, statusCode: 0, data: null, message: 'Error sending message: $e');
    }
  }

  /// Sends OTP to the specified phone number
  /// Returns [WhatsAppResponse] with [OtpData] in the data field
  Future<WhatsAppResponse> sendOtp(String phone, {int otpLength = 4, int expiryMinutes = 1}) async {
    final url = Endpoints.whatsappApi + Endpoints.sendOtp;
    try {
      final response = await _dio.post(
        url,
        data: {'api_key': _apiKey, 'phone': phone, 'otp_length': otpLength, 'expiry_minutes': expiryMinutes},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final whatsappResponse = WhatsAppResponse.fromJson(Map<String, dynamic>.from(responseData));

        if (whatsappResponse.status && whatsappResponse.data != null) {
          final otpData = OtpData.fromJson(Map<String, dynamic>.from(whatsappResponse.data));
          return WhatsAppResponse(
            status: whatsappResponse.status,
            statusCode: whatsappResponse.statusCode,
            data: otpData,
            message: whatsappResponse.message,
          );
        } else {
          return WhatsAppResponse(
            status: false,
            statusCode: whatsappResponse.statusCode,
            data: null,
            message: 'Failed to send OTP: ${whatsappResponse.message}',
          );
        }
      } else {
        return WhatsAppResponse(
          status: false,
          statusCode: response.statusCode ?? 0,
          data: null,
          message: 'HTTP Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return WhatsAppResponse(status: false, statusCode: 0, data: null, message: 'Error sending OTP: $e');
    }
  }

  /// Verifies OTP code
  /// Returns [WhatsAppResponse] with [OtpData] in the data field
  Future<WhatsAppResponse> verifyOtp(String phone, String otpCode) async {
    final url = Endpoints.whatsappApi + Endpoints.verifyOtp;
    try {
      final response = await _dio.post(url, data: {'api_key': _apiKey, 'phone': phone, 'otp_code': otpCode});

      if (response.statusCode == 200) {
        final responseData = response.data;
        final whatsappResponse = WhatsAppResponse.fromJson(Map<String, dynamic>.from(responseData));

        if (whatsappResponse.status && whatsappResponse.data != null) {
          final otpData = OtpData.fromJson(Map<String, dynamic>.from(whatsappResponse.data));
          return WhatsAppResponse(
            status: whatsappResponse.status,
            statusCode: whatsappResponse.statusCode,
            data: otpData,
            message: whatsappResponse.message,
          );
        } else {
          return WhatsAppResponse(
            status: false,
            statusCode: whatsappResponse.statusCode,
            data: null,
            message: whatsappResponse.message,
          );
        }
      } else {
        return WhatsAppResponse(
          status: false,
          statusCode: response.statusCode ?? 0,
          data: null,
          message: 'HTTP Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return WhatsAppResponse(status: false, statusCode: 0, data: null, message: 'Error verifying OTP: $e');
    }
  }

  /// Creates OTP without sending it
  /// Returns [WhatsAppResponse] with [OtpData] in the data field
  Future<WhatsAppResponse> createOtp(String phone, {int otpLength = 4, int expiryMinutes = 1}) async {
    final url = Endpoints.whatsappApi + Endpoints.createOtp;
    try {
      final response = await _dio.post(
        url,
        data: {'api_key': _apiKey, 'phone': phone, 'otp_length': otpLength, 'expiry_minutes': expiryMinutes},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final whatsappResponse = WhatsAppResponse.fromJson(Map<String, dynamic>.from(responseData));

        if (whatsappResponse.status && whatsappResponse.data != null) {
          final otpData = OtpData.fromJson(Map<String, dynamic>.from(whatsappResponse.data));
          return WhatsAppResponse(
            status: whatsappResponse.status,
            statusCode: whatsappResponse.statusCode,
            data: otpData,
            message: whatsappResponse.message,
          );
        } else {
          return WhatsAppResponse(
            status: false,
            statusCode: whatsappResponse.statusCode,
            data: null,
            message: 'Failed to create OTP: ${whatsappResponse.message}',
          );
        }
      } else {
        return WhatsAppResponse(
          status: false,
          statusCode: response.statusCode ?? 0,
          data: null,
          message: 'HTTP Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return WhatsAppResponse(status: false, statusCode: 0, data: null, message: 'Error creating OTP: $e');
    }
  }

  /// Checks OTP status with a single request
  /// Returns [WhatsAppResponse] with [OtpData] in the data field
  Future<WhatsAppResponse> checkOtpStatus(String phone, String otpCode) async {
    final url = Endpoints.whatsappApi + Endpoints.checkOtpStatus;
    try {
      final response = await _dio.get(
        url,
        data: {'api_key': _apiKey, 'phone': phone, 'otp_code': otpCode},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final whatsappResponse = WhatsAppResponse.fromJson(Map<String, dynamic>.from(responseData));

        if (whatsappResponse.status && whatsappResponse.data != null) {
          final otpData = OtpData.fromJson(Map<String, dynamic>.from(whatsappResponse.data));
          return WhatsAppResponse(
            status: whatsappResponse.status,
            statusCode: whatsappResponse.statusCode,
            data: otpData,
            message: whatsappResponse.message,
          );
        } else {
          return WhatsAppResponse(
            status: false,
            statusCode: whatsappResponse.statusCode,
            data: null,
            message: whatsappResponse.message,
          );
        }
      } else {
        return WhatsAppResponse(
          status: false,
          statusCode: response.statusCode ?? 0,
          data: null,
          message: 'HTTP Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return WhatsAppResponse(status: false, statusCode: 0, data: null, message: 'Error checking OTP status: $e');
    }
  }

  /// Checks OTP status continuously every 5 seconds as a stream
  /// Returns a [Stream] of [WhatsAppResponse] with [OtpData] in the data field
  /// The stream will continue until cancelled by the caller
  Stream<WhatsAppResponse> checkOtpStatusStream(String phone, String otpCode) async* {
    while (true) {
      yield await checkOtpStatus(phone, otpCode);
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}
