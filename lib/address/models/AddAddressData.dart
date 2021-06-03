import 'package:dio/dio.dart';

class AddAddressData {
  final int customer_id;
  final String name;
  final String city;
  final String line1;
  final String line2;
  final String line3;
  final String addType;
  final String addPincode;

  AddAddressData(
      {this.customer_id,
      this.name,
      this.city,
      this.line1,
      this.line2,
      this.line3,
      this.addType,
      this.addPincode});

  FormData getFormData(AddAddressData addAddressData) {
    return FormData.fromMap({
      'customer_id': addAddressData.customer_id,
      'name': addAddressData.name ?? "",
      'city': addAddressData.city ?? "",
      'line1': addAddressData.line1 ?? "",
      'line2': addAddressData.line2 ?? "",
      'line3': addAddressData.line3 ?? "",
      'addtype': addAddressData.addType ?? "",
      'addpincode': addAddressData.addPincode ?? ""
    });
  }
}
