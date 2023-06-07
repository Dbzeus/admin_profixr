

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/TicketListResponse.dart';
import 'package:profixer_admin/model/ticket_count_response.dart';

import '../../../helpers/constant_widgets.dart';

class BookedTicketController extends GetxController{
  TextEditingController searchController = TextEditingController();

  TicketCount data=Get.arguments['data'];
  var startDate = Get.arguments['startDate'];
  var endDate = Get.arguments['endDate'];

  final box=GetStorage();

  RxList<Ticket> ticketList=RxList();
  RxBool isLoading=true.obs;

  @override
  void onInit() {
    super.onInit();
    getTicketList();
  }

  getTicketList()async{
    if(await isNetConnected()){
      isLoading(true);
      var response=await ApiCall().getTicketList(box.read(Session.userId), data.ticketStatusID, startDate, endDate);
      if(response!=null){
        if(response.rtnStatus){
          ticketList(response.rtnData);
        }else{
          toast(response.rtnMsg);
        }
      }
      isLoading(false);
    }
  }

}

