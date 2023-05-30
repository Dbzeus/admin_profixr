class TicketCountResponse {
  TicketCountResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData,
      this.otherMsg,
      this.id,);

  TicketCountResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(TicketCount.fromJson(v));
      });
      otherMsg = json['OtherMsg'];
      id = json['ID'];
    }
  }
  late bool rtnStatus;
  late String rtnMsg;
  late List<TicketCount> rtnData;
  late dynamic otherMsg;
  late dynamic id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMsg'] = rtnMsg;
    if (rtnData != null) {
      map['RtnData'] = rtnData.map((v) => v.toJson()).toList();
    }
    map['OtherMsg'] = otherMsg;
    map['ID'] = id;
    return map;
  }

}

class TicketCount {
  TicketCount(
    this.ticketStatusID,
    this.statusName,
    this.statusImage,
    this.colorCode,
    this.colorCode2,
    this.ticketCount,
    this.statusOrder,);

  TicketCount.fromJson(dynamic json) {
    ticketStatusID = json['TicketStatusID'];
    statusName = json['StatusName'];
    statusImage = json['StatusImage'];
    colorCode = json['ColorCode'];
    colorCode2 = json['ColorCode2'];
    ticketCount = json['TicketCount'];
    statusOrder = json['StatusOrder'];
  }
  late int ticketStatusID;
  late String statusName;
  late String statusImage;
  late String colorCode;
  late String colorCode2;
  late int ticketCount;
  late int statusOrder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TicketStatusID'] = ticketStatusID;
    map['StatusName'] = statusName;
    map['StatusImage'] = statusImage;
    map['ColorCode'] = colorCode;
    map['ColorCode2'] = colorCode2;
    map['TicketCount'] = ticketCount;
    map['StatusOrder'] = statusOrder;
    return map;
  }

}