import 'package:dio/dio.dart';

// ignore_for_file: non_constant_identifier_names
class AddressData {
  final int id;
  final String name;
  final String city;
  final String line1;
  final String line2;
  final String line3;
  final String addtype;
  final String addpincode;
  final int customer_id;
  final String status;
  final String msg;
  final bool isdeafault;

  AddressData(
      {this.isdeafault,
      this.id,
      this.name,
      this.city,
      this.line1,
      this.line2,
      this.line3,
      this.addtype,
      this.addpincode,
      this.customer_id,
      this.status,
      this.msg});

  FormData getFormData(AddressData addressData) {
    return FormData.fromMap({
      'customer_id': addressData.customer_id,
      'name': addressData.name ?? "",
      'city': addressData.city ?? "",
      'line1': addressData.line1 ?? "",
      'line2': addressData.line2 ?? "",
      'line3': addressData.line3 ?? "",
      'addtype': addressData.addtype ?? "",
      'addpincode': addressData.addpincode ?? "",
      'id': addressData.id,
      'status': addressData.status,
      'message': addressData.msg
    });
  }

  factory AddressData.getAddressResponseFromHttpResponse(Response<dynamic> response) {
    return AddressData(
        isdeafault: response.data["isdeafault"],
        id: response.data['id'],
        name: response.data['name'],
        city: response.data['city'],
        line1: response.data['line1'],
        line2: response.data['line2'],
        line3: response.data['line3'],
        addtype: response.data['addtype'],
        addpincode: response.data['addpincode'],
        customer_id: response.data['customer_id'],
        status: response.data['status'],
        msg: response.data['message']);
  }

  factory AddressData.getSingleAddress(dynamic data) {
    return AddressData(
        isdeafault: data["isdeafault"],
        id: data['id'],
        name: data['name'],
        city: data['city'],
        line1: data['line1'],
        line2: data['line2'],
        line3: data['line3'],
        addtype: data['addtype'],
        addpincode: data['addpincode'],
        customer_id: data['customer_id'],
        status: data['status'] ?? "",
        msg: data['message'] ?? "");
  }

  List<AddressData> getAddresses(Response<dynamic> response) {
    List<AddressData> addList = [];

    response.data.forEach((data) {
      AddressData addressData = AddressData.getSingleAddress(data);

      addList.add(addressData);
    });
    return addList;
  }
}
