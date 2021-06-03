import 'package:dio/dio.dart';

class UpdateCustomerData {
  final String email;
  final String username;
  final String firstName;
  final String lastname;
  final int number;

  const UpdateCustomerData(
      {this.email, this.username, this.firstName, this.lastname, this.number});

  FormData getFormData(UpdateCustomerData updateCustomerData) {
    return FormData.fromMap({
      'email': updateCustomerData.email,
      'username': updateCustomerData.username,
      'fname': updateCustomerData.firstName,
      'lname': updateCustomerData.lastname,
      'number': updateCustomerData.number,
    });
  }

  FormData getTestFormData(UpdateCustomerData updateCustomerData) {
    return FormData.fromMap({
      'email': 'sabby@gmail.com',
      'username': 'swaraj1997',
      'fname': 'MayureshCheck',
      'lname': 'Test1Check',
      'number': '7756788067',
    });
  }
}
