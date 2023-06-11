import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/model/TicketListResponse.dart';
import 'package:profixer_admin/screens/tickets/booked_ticket/booked_ticket_controller.dart';
import 'package:profixer_admin/screens/tickets/ticket_details/updation/ticket_updation.dart';
import 'package:profixer_admin/screens/tickets/ticket_details/updation/tikcet_updation_controller.dart';

import '../../../helpers/custom_dialog.dart';
import '../../../helpers/utils.dart';
import '../../../model/TicketHistoryResponse.dart';
import '../../main/main_controller.dart';

class TicketDetailsController extends GetxController {
  Ticket ticket = Get.arguments;
  RxBool isHistoryLoading = false.obs;
  RxBool isLoading = false.obs;
  final _box = GetStorage();

  RxList<TicketHistory> histories = RxList();

  @override
  void onInit() {
    super.onInit();
    getTicketHistory();
  }

  getTicketHistory() async {
    if (await isNetConnected()) {
      isHistoryLoading(true);
      var response = await ApiCall()
          .getTicketHistory(_box.read(Session.userId), ticket.ticketID);
      isHistoryLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          histories(response.rtnData);
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  ticketUpdate(ChildStatus status) async {
    var res = await ticketUpdationDialog(Get.context!, getUpdationType(status.ticketTypeID));
    // debugPrint(res);
    Get.delete<TicketUpdationController>();
    if (res != null) {
      try {
        isLoading(true);

        var image = "";
        if (res['image'].isNotEmpty) {
          //upload Image
          var response = await ApiCall().uploadAttachment([res['image'].value]);
          if (response != null) {
            if (response['RtnStatus']) {
              image = response['RtnMsg'];
            } else {
              toast('${response['RtnMsg']}');
            }
          }
        }

        var data = {
          "TicketID": ticket.ticketID,
          "TicketStatusID": status.childStatusId,
          "CustomerID": ticket.customerID,
          "CustomerAddressID": ticket.customerID,
          "ServiceID": ticket.serviceID,
          "ComplaintNatureID": ticket.complaintNatureID,
          "ServiceTypeID": ticket.serviceID,
          "ServiceProviderID": res['providerId'],
          "TechnicianID": res['techId'],
          "AppoinmentDate": "2023-06-10T09:02:28.850Z",
          "TimeSlotID": ticket.timeSlotID,
          "Reason": res['reason'],
          "Remarks": res['remark'],
          "Images": image,
          "CUID": _box.read(Session.userId)
        };

        var response = await ApiCall().updateATicket(data);
        isLoading(false);

        if (response != null) {
          customDialog(
              Get.context,
              response['RtnStatus']
                  ? "Updated Successful!"
                  : "Updated Unsuccessful!",
              "${response['RtnMsg']}", () {
            if (response['RtnStatus']) {
              final con = Get.find<MainController>();
              con.getTicketCounts();
              final cont = Get.find<BookedTicketController>();
              cont.getTicketList();
              Get.back();
            }
          }, isDismissable: false);
        }
      } catch (e) {
        isLoading(false);
      }
    }
  }
}
