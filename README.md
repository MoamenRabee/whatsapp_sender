# WhatsApp Sender

A Dart package for sending WhatsApp messages and managing OTP (One-Time Password) functionality via the Softeks WhatsApp API.

## Features

✅ **Send WhatsApp Messages** - Send text messages to any WhatsApp number  
✅ **Send OTP** - Send One-Time Password codes via WhatsApp  
✅ **Create OTP** - Generate OTP codes without sending them  
✅ **Verify OTP** - Verify OTP codes entered by users  
✅ **Check OTP Status** - Check if OTP is verified or expired  
✅ **Real-time OTP Monitoring** - Stream-based OTP status checking every 5 seconds  

## Getting started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  whatsapp_sender: ^1.0.0
```

Then run:
```bash
dart pub get
```

## Usage

### Initialize the WhatsApp Sender

```dart
import 'package:whatsapp_sender/whatsapp_sender.dart';

final whatsapp = WhatsAppSender('your_api_key_here');
```

### Send WhatsApp Message

```dart
final response = await whatsapp.sendMessage('+201234567890', 'Hello from Dart!');

if (response.status) {
  print('Message sent successfully: ${response.message}');
} else {
  print('Error: ${response.message}');
}
```

### Send OTP

```dart
final response = await whatsapp.sendOtp(
  '+201234567890',
  otpLength: 4,
  expiryMinutes: 5,
);

if (response.status) {
  final otpData = response.data as OtpData;
  print('OTP sent! ID: ${otpData.otpId}');
  print('Expires at: ${otpData.expiresAt}');
}
```

### Create OTP (Without Sending)

```dart
final response = await whatsapp.createOtp(
  '+201234567890',
  otpLength: 6,
  expiryMinutes: 10,
);

if (response.status) {
  final otpData = response.data as OtpData;
  print('OTP Code: ${otpData.otpCode}');
  print('Message: ${otpData.message}');
}
```

### Verify OTP

```dart
final response = await whatsapp.verifyOtp('+201234567890', '1234');

if (response.status) {
  final otpData = response.data as OtpData;
  print('OTP verified at: ${otpData.verifiedAt}');
} else {
  print('Verification failed: ${response.message}');
}
```

### Check OTP Status (Single Check)

```dart
final response = await whatsapp.checkOtpStatus('+201234567890', '1234');

if (response.status) {
  final otpData = response.data as OtpData;
  print('Is Verified: ${otpData.isVerified}');
  print('Is Expired: ${otpData.isExpired}');
}
```

### Monitor OTP Status (Real-time Stream)

```dart
// Check OTP status every 5 seconds
final stream = whatsapp.checkOtpStatusStream('+201234567890', '1234');

final subscription = stream.listen((response) {
  if (response.status && response.data != null) {
    final otpData = response.data as OtpData;
    
    if (otpData.isVerified == true) {
      print('OTP Verified!');
      subscription.cancel(); // Stop monitoring
    } else if (otpData.isExpired == true) {
      print('OTP Expired!');
      subscription.cancel();
    }
  }
});

// Cancel after 60 seconds if needed
Future.delayed(Duration(seconds: 60), () => subscription.cancel());
```

## API Response

All methods return a `WhatsAppResponse` object:

```dart
class WhatsAppResponse {
  final bool status;        // Success or failure
  final int statusCode;     // HTTP status code
  final dynamic data;       // Response data (MessageData or OtpData)
  final String message;     // Response message
}
```

## Additional information

- **API Documentation**: Visit [Softeks API](https://softeks.org)
- **Issues**: Report issues on [GitHub](https://github.com/MoamenRabee/whatsapp_sender/issues)
- **Repository**: [GitHub Repository](https://github.com/MoamenRabee/whatsapp_sender)
- **License**: MIT

For more examples, check the `/example` folder in the repository.
