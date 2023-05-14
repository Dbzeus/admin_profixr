

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BookedTicketController extends GetxController{
  TextEditingController searchController = TextEditingController();

  RxString dropDownValue = "InProgress".obs;


  var ticketList= [
    {
      "no" : "#1224678299399",
      "place" : "Madurai",
      "techName" : "surya",
      "role" : "AC Mechanic",
      "cusName" : "Ram",
      "cusNo" : "9876453241",
      "issue" : "Ac full Service",
      "date" : "01/05/2023 09.00 ",
      "ticket" : "open",
    },
    {
      "no" : "#1535378393933",
      "place" : "Madurai",
      "techName" : "Dinesh",
      "role" : "Plumber",
      "cusName" : "Sathish",
      "cusNo" : "6789012435",
      "issue" : "Tap Fixing",
      "date" : "25/04/2023 12.00 ",
    "ticket" : "closed",
    },
    {
      "no" : "#567890235678",
      "place" : "Madurai",
      "techName" : "Saravanan",
      "role" : "Electrician",
      "cusName" : "Sid",
      "cusNo" : "8765438789",
      "issue" : "Meter box complaint",
      "date" : "01/05/2023 09.00 ",
      "ticket" : "Assign",
    },
    {
      "no" : "#3456789111",
      "place" : "Madurai",
      "techName" : "Vaasu",
      "role" : "Plumber",
      "cusName" : "Chrishtopher",
      "cusNo" : "8892992999",
      "issue" : "Borewell service",
      "date" : "01/05/2023 09.00 ",
    "ticket" : "open",
    },
    {
      "no" : "#1535378393933",
      "place" : "Madurai",
      "techName" : "Dinesh",
      "role" : "Plumber",
      "cusName" : "Sathish",
      "cusNo" : "6789012435",
      "issue" : "Tap Fixing",
      "date" : "25/04/2023 12.00 ",
      "ticket" : "open",
    },
    {
      "no" : "#1224678299399",
      "place" : "Madurai",
      "techName" : "Santhosh",
      "role" : "AC Mechanic",
      "cusName" : "Ram",
      "cusNo" : "9876453241",
      "issue" : "Ac Replacement",
      "date" : "01/05/2023 09.00 ",
      "ticket" : "open",
    },
    {
      "no" : "#1224678299399",
      "place" : "Madurai",
      "techName" : "Sam",
      "role" : "Electrician",
      "cusName" : "Ram",
      "cusNo" : "9645256363",
      "issue" : "New meter connection",
      "date" : "01/05/2023 09.00 ",
      "ticket" : "open",
    },
  ];
}