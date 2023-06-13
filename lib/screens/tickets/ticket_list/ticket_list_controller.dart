import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/TicketListResponse.dart';
import 'package:profixer_admin/model/ticket_count_response.dart';

import '../../../helpers/constant_widgets.dart';
import '../../../helpers/custom_dialog.dart';
import '../../main/main_controller.dart';
import '../ticket_details/updation/ticket_updation.dart';
import '../ticket_details/updation/tikcet_updation_controller.dart';

class TicketListController extends GetxController {
  TextEditingController searchController = TextEditingController();

  TicketCount data = Get.arguments['data'];
  var startDate = Get.arguments['startDate'];
  var endDate = Get.arguments['endDate'];

  final box = GetStorage();

  RxList<Ticket> ticketList = RxList();
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getTicketList();
  }

  getTicketList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getTicketList(
          box.read(Session.userId), data.ticketStatusID, startDate, endDate);
      if (response != null) {
        if (response.rtnStatus) {
          ticketList(response.rtnData);
        } else {
          toast(response.rtnMsg);
        }
      }
      isLoading(false);
    }
  }

  ticketUpdate(Ticket ticket, ChildStatus status) async {
    var res = await ticketUpdationDialog(
        Get.context!, getUpdationType(status.ticketTypeID));
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

        var param = {
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
          "CUID": box.read(Session.userId)
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
              getTicketList();
            }
          }, isDismissable: false);
        }
      } catch (e) {
        isLoading(false);
      }
    }
  }
}
