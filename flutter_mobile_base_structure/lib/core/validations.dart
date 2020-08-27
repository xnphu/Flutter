import 'dart:async';

final cardNumberRegex = r'^[0-9]{15,18}$';
final cvvRegex = r"^[0-9]{3,4}$";
final expiredDateRegex = r"^[0-9]{2}/[0-9]{4}$";
final emailRegex = r"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
final phoneNumberRegex =
    r"^[+]{1}[1-9]{2}([0-9]+){9,}$|^0([0-9]+){9,}$|^([+]{0,1}([0-9]+-[0-9]+)+[0-9]+$|^[+]{0,1}([0-9]+ [0-9]+)+[0-9]+){9,}$";
final userNameRegex = ".+"; //r"^[a-zA-Z0-9_\\-\\.]+$";
final passwordRegex = ".+"; //r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([^\\s])+$";
final searchPhoneRegex = r"^[0-9\\s]+$";
final residentIdRegex = r"^[0-9]{8,12}$";
final bankAccountRegex = r"^[0-9]{8,15}$";
final userIdInputRegex = r"^[a-zA-Z0-9]*$";
final onlyNumbersRegex = r'[^\d]';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    RegExp regex = new RegExp(emailRegex);
    if (regex.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
//      handleData: (password, sink) {
//    RegExp regex = new RegExp(passwordRegex);
//    if (regex.hasMatch(password)) {
//      print('password valid');
//      sink.add(password);
//    } else {
//      print('password error');
//      sink.addError('Password must be at least 8 characters');
//    }
//  }
  );

  final validateUsername = StreamTransformer<String, String>.fromHandlers(
//      handleData: (username, sink) {
//    RegExp regex = new RegExp(userNameRegex);
//    if (regex.hasMatch(username)) {
//      print('username valid');
//      sink.add(username);
//    } else {
//      print('username error');
//      sink.addError('Username not valid');
//    }
//  }
  );

  final validOnlyNumber =
      StreamTransformer<String, String>.fromHandlers(handleData: (input, sink) {
    var cleanedText = (input?.isNotEmpty ?? false)
        ? input.replaceAll(RegExp(onlyNumbersRegex), '')
        : '0.0';
    var newValue = double.tryParse(cleanedText).toString() ?? '0';
    print(' validNumber input $input cleanedText $newValue');
    sink.add(newValue);
  });
}
