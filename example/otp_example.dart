import 'package:whatsapp_sender/whatsapp_sender.dart';

void main() async {
  final whatsappSender = WhatsAppSender('sk_hcothYHuGHiFd3xSwPBAKNBvouO07977MpFIcDtHs0VZk91B');

  // Example 1: Send OTP
  print('=== Send OTP ===');
  final sendOtpResponse = await whatsappSender.sendOtp('+201273308123', otpLength: 4, expiryMinutes: 1);
  print('Status: ${sendOtpResponse.status}');
  print('Message: ${sendOtpResponse.message}');
  if (sendOtpResponse.data != null) {
    final otpData = sendOtpResponse.data as OtpData;
    print('OTP ID: ${otpData.otpId}');
    print('Phone: ${otpData.phone}');
    print('Expires at: ${otpData.expiresAt}');
  }
  print('');

  // Example 2: Create OTP (without sending)
  print('=== Create OTP ===');
  final createOtpResponse = await whatsappSender.createOtp('+201273308123', otpLength: 4, expiryMinutes: 1);
  print('Status: ${createOtpResponse.status}');
  print('Message: ${createOtpResponse.message}');
  if (createOtpResponse.data != null) {
    final otpData = createOtpResponse.data as OtpData;
    print('OTP ID: ${otpData.otpId}');
    print('OTP Code: ${otpData.otpCode}');
    print('Phone: ${otpData.phone}');
    print('Expires at: ${otpData.expiresAt}');
    print('Message to customer: ${otpData.message}');
  }
  print('');

  // Example 3: Verify OTP
  print('=== Verify OTP ===');
  final verifyOtpResponse = await whatsappSender.verifyOtp('+201273308123', '6239');
  print('Status: ${verifyOtpResponse.status}');
  print('Message: ${verifyOtpResponse.message}');
  if (verifyOtpResponse.data != null) {
    final otpData = verifyOtpResponse.data as OtpData;
    print('OTP ID: ${otpData.otpId}');
    print('Phone: ${otpData.phone}');
    print('Verified at: ${otpData.verifiedAt}');
  }
  print('');

  // Example 4: Check OTP Status (single check)
  print('=== Check OTP Status (single) ===');
  final statusResponse = await whatsappSender.checkOtpStatus('+201273308123', '6511');
  print('Status: ${statusResponse.status}');
  print('Message: ${statusResponse.message}');
  if (statusResponse.data != null) {
    final otpData = statusResponse.data as OtpData;
    print('OTP ID: ${otpData.otpId}');
    print('Phone: ${otpData.phone}');
    print('OTP Code: ${otpData.otpCode}');
    print('Is Verified: ${otpData.isVerified}');
    print('Is Expired: ${otpData.isExpired}');
    print('Verified at: ${otpData.verifiedAt}');
    print('Expires at: ${otpData.expiresAt}');
  }
  print('');

  // Example 5: Check OTP Status as Stream (every 5 seconds)
  print('=== Check OTP Status Stream (every 5 seconds) ===');
  print('Listening for 30 seconds...');

  final stream = whatsappSender.checkOtpStatusStream('+201273308123', '6511');

  // Listen to the stream for 30 seconds then cancel
  final subscription = stream.listen((response) {
    print('---');
    print('Time: ${DateTime.now()}');
    print('Status: ${response.status}');
    print('Message: ${response.message}');
    if (response.data != null) {
      final otpData = response.data as OtpData;
      print('Is Verified: ${otpData.isVerified}');
      print('Is Expired: ${otpData.isExpired}');

      // If verified, you can cancel the stream
      if (otpData.isVerified == true) {
        print('OTP Verified! Stopping stream...');
        // Note: In real usage, you would call subscription.cancel() here
      }
    }
  });

  // Cancel after 30 seconds
  await Future.delayed(const Duration(seconds: 30));
  await subscription.cancel();
  print('Stream cancelled after 30 seconds');
}
