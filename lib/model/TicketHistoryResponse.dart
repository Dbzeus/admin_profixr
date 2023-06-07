
class TicketHistoryResponse {
  TicketHistoryResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData,);

  TicketHistoryResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(TicketHistory.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMsg;
  late List<TicketHistory> rtnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMsg'] = rtnMsg;
    if (rtnData != null) {
      map['RtnData'] = rtnData.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TicketHistory {
  TicketHistory(
    this.ticketHistoryID,
    this.ticketStatusID,
    this.statusName,
    this.colorCode,
    this.statusImage,
    this.serviceProviderID,
    this.serviceProvider,
    this.assigneeID,
    this.technician,
    this.assignedDate,
    this.remarks,
    this.uploadImages,
    this.reason,
    this.remarks1,
    this.createdDate,);

  TicketHistory.fromJson(dynamic json) {
    ticketHistoryID = json['TicketHistoryID'];
    ticketStatusID = json['TicketStatusID'];
    statusName = json['StatusName'];
    colorCode = json['ColorCode'];
    statusImage = json['StatusImage'];
    serviceProviderID = json['ServiceProviderID'];
    serviceProvider = json['ServiceProvider'];
    assigneeID = json['AssigneeID'];
    technician = json['Technician'];
    assignedDate = json['AssignedDate'];
    remarks = json['Remarks'];
    uploadImages = json['UploadImages'];
    reason = json['Reason'];
    remarks1 = json['Remarks1'];
    createdDate = json['CreatedDate'];
  }
  late int ticketHistoryID;
  late int ticketStatusID;
  late String statusName;
  late String colorCode;
  late String statusImage;
  late int serviceProviderID;
  late String serviceProvider;
  late int assigneeID;
  late String technician;
  late String assignedDate;
  late String remarks;
  late String uploadImages;
  late String reason;
  late String remarks1;
  late String createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TicketHistoryID'] = ticketHistoryID;
    map['TicketStatusID'] = ticketStatusID;
    map['StatusName'] = statusName;
    map['ColorCode'] = colorCode;
    map['StatusImage'] = statusImage;
    map['ServiceProviderID'] = serviceProviderID;
    map['ServiceProvider'] = serviceProvider;
    map['AssigneeID'] = assigneeID;
    map['Technician'] = technician;
    map['AssignedDate'] = assignedDate;
    map['Remarks'] = remarks;
    map['UploadImages'] = uploadImages;
    map['Reason'] = reason;
    map['Remarks1'] = remarks1;
    map['CreatedDate'] = createdDate;
    return map;
  }

}