import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class LoginProvider extends ChangeNotifier {
  String _email = "", _password = "";
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passController = TextEditingController();

  TextEditingController get emailcontroller => _emailController;

  TextEditingController get passcontroller => _passController;

  String get email => _email;
  String get password => _password;

  final userFormKey = GlobalKey<FormState>();

  void matchCredentials() {
    _email = emailcontroller.text;

    _password = passcontroller.text;
    print('saved');
    notifyListeners();
  }
}
