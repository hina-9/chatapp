import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class RegistrationProvider extends ChangeNotifier {
  String _email = "", _password = "", _name = "", _confirmPassword = "";
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  TextEditingController get emailcontroller => _emailController;
  TextEditingController get namecontroller => _nameController;
  TextEditingController get passcontroller => _passController;
  TextEditingController get confirmpasscontroller => _confirmPassController;
  String get email => _email;
  String get password => _password;
  String get name => _name;
  String get confirmpass => _confirmPassword;

  final userFormKey = GlobalKey<FormState>();

  void saveCredentials() {
    _email = emailcontroller.text;
    _name = namecontroller.text;
    _password = passcontroller.text;
    _confirmPassword = confirmpasscontroller.text;
    notifyListeners();
  }

  void matchCredentials() {
    _email = emailcontroller.text;

    _password = passcontroller.text;

    notifyListeners();
  }
}
