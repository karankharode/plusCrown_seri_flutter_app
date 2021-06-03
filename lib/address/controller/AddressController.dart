import 'package:dio/dio.dart';
import 'package:seri_flutter_app/address/models/AddressData.dart';
import 'package:seri_flutter_app/common/shared_pref.dart';

import '../models/AddAddressData.dart';
import '../models/AddAddressResponse.dart';
import '../models/UpdateAddressData.dart';
import '../models/UpdateAddressResponse.dart';

class AddressController {
  static final _sharedPref = SharedPref.instance;
  final dio = Dio();

  Future<List<AddressData>> getAddress(String id) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/get_address/";

    List<AddressData> serverMsg = await _httpPostRequestForGetAddress(endPointUrl, id);
    return serverMsg;
  }

  Future<bool> addAddress(AddAddressData addAddressData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/add_address/";
    final parameters = addAddressData.getFormData(addAddressData);

    bool serverMsg = await _httpPostRequestForAddAddress(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> updateAddress(UpdateAddressData updateAddressData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/update_address/";
    final parameters = updateAddressData.getFormData(updateAddressData);

    bool serverMsg = await _httpPostRequestForUpdateAddress(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> removeAddress(RemoveAddressData removeAddressData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/remove_address/";
    final parameters = removeAddressData.getFormData(removeAddressData);

    bool serverMsg = await _httpPostRequestForRemoveAddress(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> _httpPostRequestForAddAddress(String url, FormData formData) async {
    AddAddressResponseData addAddressResponseData;

    bool isAdded = false;
    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        addAddressResponseData =
            AddAddressResponseData.getAddAddressResponseFromHttpResponse(response);
        if (response.data['status']) {
          isAdded = true;
        }
      }

      return isAdded;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<bool> _httpPostRequestForRemoveAddress(String url, FormData formData) async {
    AddAddressResponseData removeAddressResponseData;

    bool isRemoved = false;
    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        // removeAddressResponseData =
        //     AddAddressResponseData.getAddAddressResponseFromHttpResponse(response);

        if (response.data['msg'] == "Address Deleted") {
          isRemoved = true;
        }
      }

      return isRemoved;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<List<AddressData>> _httpPostRequestForGetAddress(String url, String id) async {
    List<AddressData> addressData;

    url = url + id;

    try {
      var response = await dio.get(url);

      if (response != null) {
        addressData = AddressData().getAddresses(response);
        if (addressData != null) {
          return addressData;
        } else {
          return null;
        }
      }
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<bool> _httpPostRequestForUpdateAddress(String url, FormData formData) async {
    bool updatedAddress = false;
    UpdateAddressResponse updateAddressResponse;

    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        updateAddressResponse =
            UpdateAddressResponse.getUpdateAddressResponseFromHttpResponse(response);
        if (response.data['status']) {
          updatedAddress = true;
        }
      }

      return updatedAddress;
    } catch (e) {
      throw new Exception('Error');
    }
  }
}
