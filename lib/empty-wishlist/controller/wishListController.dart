import 'package:dio/dio.dart';
import 'package:seri_flutter_app/common/shared_pref.dart';
import 'package:seri_flutter_app/empty-wishlist/models/AddtoWishlistData.dart';
import 'package:seri_flutter_app/empty-wishlist/models/WishListData.dart';

class WishlistController {
  static final _sharedPref = SharedPref.instance;
  final dio = Dio();

  Future<bool> addToWishlist(AddToWishlistData addToWishlistData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/add_to_wishlist/";
    final parameters = addToWishlistData.getFormData(addToWishlistData);

    bool serverMsg = await _httpRequestForAddWishlistData(endPointUrl, parameters);
    return serverMsg;
  }

  Future<WishlistData> getWishlistDetails(GetWishlistData getWishlistData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/get_Wishlist_details/";
    final parameters = getWishlistData.getFormData(getWishlistData);

    WishlistData serverMsg = await _httpRequestForGetWishlistData(endPointUrl, parameters);
    return serverMsg;
  }

  // Future<bool> removeFromWishlist(DeleteFromWishlistData deleteFromWishlistData) async {
  //   const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/remove_from_Wishlist/";
  //   final parameters = deleteFromWishlistData.getFormData(deleteFromWishlistData);

  //   bool serverMsg = await _httpRequestForRemoveWishlistData(endPointUrl, parameters);
  //   return serverMsg;
  // }

  Future<bool> _httpRequestForAddWishlistData(String url, FormData formData) async {
    // AddToWishlistResponse addToWishlistResponse;
    bool addedToWishlist;
    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        // addToWishlistResponse = AddToWishlistResponse.getWishlistResponseFromHttpResponse(response);
        if (response.data['msg'] == "Item added to the Wishlist") {
          addedToWishlist = true;
        }
      }

      return addedToWishlist;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<WishlistData> _httpRequestForGetWishlistData(String url, FormData formData) async {
    WishlistData cardData;
    bool addedToWishlist;
    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        cardData = WishlistData.fromJson(response);
      }

      return cardData;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<bool> _httpRequestForRemoveWishlistData(String url, FormData formData) async {
    // DeleteFromWishlistResponse deleteFromWishlistResponse;
    bool removeFromWishlist;
    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        // deleteFromWishlistResponse =
        // DeleteFromWishlistResponse.getRemoveWishlistResponseFromHttpResponse(response);
        if (response.data['msg'] == "Item Deleted") {
          removeFromWishlist = true;
        }
      }

      return removeFromWishlist;
    } catch (e) {
      throw new Exception('Error');
    }
  }
}
