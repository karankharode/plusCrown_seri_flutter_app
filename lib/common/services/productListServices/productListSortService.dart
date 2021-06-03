import 'package:seri_flutter_app/homescreen/models/product_class.dart';

List<ProductData> getNewArrivalsList(allDataList) {
  List<ProductData> sendinglist = [];
  for (ProductData prod in allDataList) {
    if (prod.instock == true) {
      sendinglist.add(prod);
    }
  }
  return sendinglist;
}

List<ProductData> getDealsOftheDayList(allDataList) {
  List<ProductData> sendinglist = [];
  for (ProductData prod in allDataList) {
    if (prod.isDealoftheday == true) {
      sendinglist.add(prod);
    }
  }
  return sendinglist;
}

List<ProductData> getBestSellersList(allDataList) {
  List<ProductData> sendinglist = [];
  for (ProductData prod in allDataList) {
    if (prod.isBestSeller == true) {
      sendinglist.add(prod);
    }
  }
  return sendinglist;
}

List<ProductData> getRecentlyViewedList(allDataList) {
  List<ProductData> sendinglist = [];
  for (ProductData prod in allDataList) {
    if (prod.isExchnageable == true) {
      sendinglist.add(prod);
    }
  }
  return sendinglist;
}
