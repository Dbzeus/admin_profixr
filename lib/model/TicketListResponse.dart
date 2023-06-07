
class TicketListResponse {
  TicketListResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData,);

  TicketListResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(Ticket.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMsg;
  late List<Ticket> rtnData;

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

class Ticket {
  Ticket(
    this.ticketID,
    this.ticketNo,
    this.ticketStatus,
    this.statusName,
    this.statusImage,
    this.childStatusID,
    this.childStatus,
    this.statusColor,
    this.customerID,
    this.customerName,
    this.mobileNo,
    this.serviceID,
    this.serviceName,
    this.serviceImg,
    this.complaintNatureID,
    this.complientNatureName,
    this.complientNatureImg,
    this.priorityID,
    this.priorityName,
    this.serviceProviderID,
    this.serviceProviderName,
    this.techicianID,
    this.technician,
    this.assignedDate,
    this.timeSlotID,
    this.isTimerStart,
    this.timer,
    this.remarks,
    this.images,
    this.createdDate,);

  Ticket.fromJson(dynamic json) {
    ticketID = json['TicketID'];
    ticketNo = json['TicketNo'];
    ticketStatus = json['TicketStatus'];
    statusName = json['StatusName'];
    statusImage = json['StatusImage'];
    childStatusID = json['ChildStatusID'];
    if (json['ChildStatus'] != null) {
      childStatus = [];
      json['ChildStatus'].forEach((v) {
        childStatus.add(ChildStatus.fromJson(v));
      });
    }
    statusColor = json['StatusColor'];
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    mobileNo = json['MobileNo'];
    serviceID = json['ServiceID'];
    serviceName = json['ServiceName'];
    serviceImg = json['ServiceImg'];
    complaintNatureID = json['ComplaintNatureID'];
    complientNatureName = json['ComplientNatureName'];
    complientNatureImg = json['ComplientNatureImg'];
    priorityID = json['PriorityID'];
    priorityName = json['PriorityName'];
    serviceProviderID = json['ServiceProviderID'];
    serviceProviderName = json['ServiceProviderName'];
    techicianID = json['TechicianID'];
    technician = json['Technician'];
    assignedDate = json['AssignedDate'];
    timeSlotID = json['TimeSlotID'];
    isTimerStart = json['IsTimerStart'];
    timer = json['Timer'];
    remarks = json['Remarks'];
    images = json['Images'];
    createdDate = json['CreatedDate'];
  }
  late int ticketID;
  late String ticketNo;
  late int ticketStatus;
  late String statusName;
  late String statusImage;
  late String childStatusID;
  late List<ChildStatus> childStatus;
  late String statusColor;
  late int customerID;
  late String customerName;
  late String mobileNo;
  late int serviceID;
  late String serviceName;
  late String serviceImg;
  late int complaintNatureID;
  late String complientNatureName;
  late String complientNatureImg;
  late int priorityID;
  late String priorityName;
  late int serviceProviderID;
  late String serviceProviderName;
  late int techicianID;
  late String technician;
  late String assignedDate;
  late int timeSlotID;
  late bool isTimerStart;
  late int timer;
  late String remarks;
  late String images;
  late String createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TicketID'] = ticketID;
    map['TicketNo'] = ticketNo;
    map['TicketStatus'] = ticketStatus;
    map['StatusName'] = statusName;
    map['StatusImage'] = statusImage;
    map['ChildStatusID'] = childStatusID;
    if (childStatus != null) {
      map['ChildStatus'] = childStatus.map((v) => v.toJson()).toList();
    }
    map['StatusColor'] = statusColor;
    map['CustomerID'] = customerID;
    map['CustomerName'] = customerName;
    map['MobileNo'] = mobileNo;
    map['ServiceID'] = serviceID;
    map['ServiceName'] = serviceName;
    map['ServiceImg'] = serviceImg;
    map['ComplaintNatureID'] = complaintNatureID;
    map['ComplientNatureName'] = complientNatureName;
    map['ComplientNatureImg'] = complientNatureImg;
    map['PriorityID'] = priorityID;
    map['PriorityName'] = priorityName;
    map['ServiceProviderID'] = serviceProviderID;
    map['ServiceProviderName'] = serviceProviderName;
    map['TechicianID'] = techicianID;
    map['Technician'] = technician;
    map['AssignedDate'] = assignedDate;
    map['TimeSlotID'] = timeSlotID;
    map['IsTimerStart'] = isTimerStart;
    map['Timer'] = timer;
    map['Remarks'] = remarks;
    map['Images'] = images;
    map['CreatedDate'] = createdDate;
    return map;
  }

}

class ChildStatus {
  ChildStatus(
    this.ticketStatusID,
    this.childStatusId,
    this.childStatusName,
    this.statusImage,
    this.ticketAction,
    this.colorCode,
    this.ticketTypeID,);

  ChildStatus.fromJson(dynamic json) {
    ticketStatusID = json['TicketStatusID'];
    childStatusId = json['ChildStatusId'];
    childStatusName = json['ChildStatusName'];
    statusImage = json['StatusImage'];
    ticketAction = json['TicketAction'];
    colorCode = json['ColorCode'];
    ticketTypeID = json['TicketTypeID'];
  }
  late int ticketStatusID;
  late int childStatusId;
  late String childStatusName;
  late String statusImage;
  late String ticketAction;
  late String colorCode;
  late int ticketTypeID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TicketStatusID'] = ticketStatusID;
    map['ChildStatusId'] = childStatusId;
    map['ChildStatusName'] = childStatusName;
    map['StatusImage'] = statusImage;
    map['TicketAction'] = ticketAction;
    map['ColorCode'] = colorCode;
    map['TicketTypeID'] = ticketTypeID;
    return map;
  }

}