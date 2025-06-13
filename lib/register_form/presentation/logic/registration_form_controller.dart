import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoxton/register_form/domain/usecase/register_user_usecase.dart';

class RegistrationFormController extends ChangeNotifier {
  final RegisterUserUsecase registerUserUsecase;
  final BuildContext context;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  bool isRegisteringUser = false;

  RegistrationFormController({
    required this.context,
    required this.registerUserUsecase,
  });

  Future<void> registerUser() async {
    try {
      if (isRegisteringUser) {
        return;
      }

      isRegisteringUser = true;
      notifyListeners();
      Map<String, dynamic> userData = {
        "email": emailController.text.trim(),
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "password": passwordController.text.trim(),
        "mobileNumber": mobileNumberController.text.trim(),
      };

      if (userData.values.any((value) => value.isEmpty)) {
        SnackBar snackBar = const SnackBar(
          content: Text("All fields are required"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      // / dartz

      final result = await registerUserUsecase(userData);
      result.fold(
        (failure) {
          // Handle failure
          log("Registration failed: $failure");
          SnackBar snackBar = const SnackBar(
            content: Text("Registration failed"),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        (successMessage) {
          // Handle success
          log("Registration successful: $successMessage");
          SnackBar snackBar = SnackBar(
            content: Text(successMessage),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      );
    } catch (e) {
      // Handle any exceptions that might occur during registration
      log("Error during registration: $e");
      SnackBar snackBar = SnackBar(
        content: Text("Error during registration: ${e.toString()}"),
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } finally {
      isRegisteringUser = false;
      notifyListeners();
    }
  }

  Future<void> clearAllFields() async {
    firstNameController.clear();
    lastNameController.clear();
    mobileNumberController.clear();
    emailController.clear();
    passwordController.clear();
    isRegisteringUser = false;
    notifyListeners();
  }
}
