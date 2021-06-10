import 'dart:io';

import 'package:dio/dio.dart';

class RequestedBook {
  final String bookName;
  final String bookType;
  final String bookRealtedTo;
  final String description;
  // final File imageFile;
  final String reqDays;
  final String customerName;
  final String customerNumber;
  final String customerEmail;
  final bool ispriority;
  final String authorName;

  RequestedBook(
      this.bookName,
      this.bookType,
      this.bookRealtedTo,
      this.description,
      //  this.imageFile,
      this.reqDays,
      this.customerName,
      this.customerNumber,
      this.customerEmail,
      this.ispriority, this.authorName);
  FormData getFormData(RequestedBook requestedBook) {
    return FormData.fromMap({
      "book_name": requestedBook.bookName,
      "book_type": requestedBook.bookType,
      "book_relatedto": requestedBook.bookRealtedTo,
      "book_desp": requestedBook.description,
      "book_required": requestedBook.reqDays,
      "customer_name": requestedBook.customerName,
      "customer_phone": requestedBook.customerNumber,
      "customer_mail_id": requestedBook.customerEmail,
      "ispriority": requestedBook.ispriority,
      "author_name": requestedBook.authorName,
      // "book_img": requestedBook.imageFile
    });
  }
}

Map relatedToMap = {
  "State Board": "1",
  "CBSE Board": "2",
  "ICSE Board": "3",
  "Entrance Exams": "4",
  "For Book Readers": "5",
  "Others": "6",
};
Map bookTypeMap = {
  "TextBook": '1',
  "Reference Book": '2',
  "Study Material": '3',
  "Novel": '4',
  "Story Books / Biography Books": '5',
  "Others": '6',
};
