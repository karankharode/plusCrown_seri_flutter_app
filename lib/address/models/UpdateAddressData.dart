import 'package:dio/dio.dart';

class UpdateAddressData {
  final int id;
  final int customer_id;
  final String name;
  final String city;
  final String line1;
  final String line2;
  final String line3;
  final String addType;
  final String addPincode;

  UpdateAddressData(
      {this.id,
      this.customer_id,
      this.name,
      this.city,
      this.line1,
      this.line2,
      this.line3,
      this.addType,
      this.addPincode});

  FormData getFormData(UpdateAddressData updateAddressData) {
    return FormData.fromMap({
      'customer_id': updateAddressData.customer_id,
      'name': updateAddressData.name ?? "",
      'city': updateAddressData.city ?? "",
      'line1': updateAddressData.line1 ?? "",
      'line2': updateAddressData.line2 ?? "",
      'line3': updateAddressData.line3 ?? "",
      'addtype': updateAddressData.addType ?? "",
      'addpincode': updateAddressData.addPincode ?? ""
    });
  }
}

class RemoveAddressData {
  final String add_id;

  RemoveAddressData({
    this.add_id,
  });

  FormData getFormData(RemoveAddressData removeAddressData) {
    return FormData.fromMap({
      'add_id': removeAddressData.add_id,
    });
  }
}
