

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TicketController extends GetxController{
  TextEditingController searchController = TextEditingController();

  RxString dropDownValue = "InProgress".obs;
  var items = [
    'InProgress',
    'Cancelled',

  ];
}