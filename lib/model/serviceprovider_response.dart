/// RtnStatus : true
/// RtnMsg : "Service Provider Details Loaded Successfully."
/// RtnData : [{"ServiceProviderID":1,"ServiceProviderName":"Profixer Service Dept","ContactPerson":"Madhan","ContactNumber":"9874563210","ContactMailID":"Service@profixer.com","ContactAddress":"Service Dept","TaxDetails":"GST No.8989898989 / VAT No. 787878ACS","BankDetails":"HDFC Bank, AC.No: 789654123000","ServiceIDs":"0","ServiceName":null,"AreaIDs":"1,2,3,4","AreaName":" Junction,Airport,Airport,Pop Station","ContractStartDate":"2023-01-01T00:00:00","ContractEndDate":"2024-12-31T00:00:00","IsActive":true},{"ServiceProviderID":2,"ServiceProviderName":"ABC Corporation","ContactPerson":"Sakthi","ContactNumber":"9898454512","ContactMailID":"saktheeswaran.a@dbzeus.com","ContactAddress":"Madurai","TaxDetails":"No Tax","BankDetails":"No Bank","ServiceIDs":"1,2","ServiceName":"AC Repair,House Keeping","AreaIDs":"3,4","AreaName":"Airport,Pop Station","ContractStartDate":"2023-05-21T00:00:00","ContractEndDate":"2023-05-21T00:00:00","IsActive":true},{"ServiceProviderID":3,"ServiceProviderName":"XZY Corporation","ContactPerson":"Saktheeswaran","ContactNumber":"9898454512","ContactMailID":"saktheeswaran.a@dbzeus.com","ContactAddress":"Madurai","TaxDetails":"No Tax","BankDetails":"No Bank","ServiceIDs":"1,2","ServiceName":"AC Repair,House Keeping","AreaIDs":"3,4","AreaName":"Airport,Pop Station","ContractStartDate":"2023-05-21T00:00:00","ContractEndDate":"2023-05-21T00:00:00","IsActive":true}]
/// OtherMsg : null
/// ID : null

class ServiceproviderResponse {
  ServiceproviderResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData, 
      this.otherMsg, 
      this.id,);

  ServiceproviderResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(ServiceProviderData.fromJson(v));
      });
    }
    otherMsg = json['OtherMsg'];
    id = json['ID'];
  }
 late bool rtnStatus;
 late String rtnMsg;
 late List<ServiceProviderData> rtnData;
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

/// ServiceProviderID : 1
/// ServiceProviderName : "Profixer Service Dept"
/// ContactPerson : "Madhan"
/// ContactNumber : "9874563210"
/// ContactMailID : "Service@profixer.com"
/// ContactAddress : "Service Dept"
/// TaxDetails : "GST No.8989898989 / VAT No. 787878ACS"
/// BankDetails : "HDFC Bank, AC.No: 789654123000"
/// ServiceIDs : "0"
/// ServiceName : null
/// AreaIDs : "1,2,3,4"
/// AreaName : " Junction,Airport,Airport,Pop Station"
/// ContractStartDate : "2023-01-01T00:00:00"
/// ContractEndDate : "2024-12-31T00:00:00"
/// IsActive : true

class ServiceProviderData {
  ServiceProviderData(
      this.serviceProviderID, 
      this.serviceProviderName, 
      this.contactPerson, 
      this.contactNumber, 
      this.contactMailID, 
      this.contactAddress, 
      this.taxDetails, 
      this.bankDetails, 
      this.serviceIDs, 
      this.serviceName, 
      this.areaIDs, 
      this.areaName, 
      this.contractStartDate, 
      this.contractEndDate, 
      this.isActive,);

  ServiceProviderData.fromJson(dynamic json) {
    serviceProviderID = json['ServiceProviderID'];
    serviceProviderName = json['ServiceProviderName'];
    contactPerson = json['ContactPerson'];
    contactNumber = json['ContactNumber'];
    contactMailID = json['ContactMailID'];
    contactAddress = json['ContactAddress'];
    taxDetails = json['TaxDetails'];
    bankDetails = json['BankDetails'];
    serviceIDs = json['ServiceIDs'];
    serviceName = json['ServiceName'];
    areaIDs = json['AreaIDs'];
    areaName = json['AreaName'];
    contractStartDate = json['ContractStartDate'];
    contractEndDate = json['ContractEndDate'];
    isActive = json['IsActive'];
  }
 late  int serviceProviderID;
 late  String serviceProviderName;
 late  String contactPerson;
 late  String contactNumber;
 late  String contactMailID;
 late  String contactAddress;
 late  String taxDetails;
 late  String bankDetails;
 late  String serviceIDs;
 late  dynamic? serviceName;
 late  String areaIDs;
 late  String? areaName;
 late  String contractStartDate;
 late  String contractEndDate;
 late  bool isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ServiceProviderID'] = serviceProviderID;
    map['ServiceProviderName'] = serviceProviderName;
    map['ContactPerson'] = contactPerson;
    map['ContactNumber'] = contactNumber;
    map['ContactMailID'] = contactMailID;
    map['ContactAddress'] = contactAddress;
    map['TaxDetails'] = taxDetails;
    map['BankDetails'] = bankDetails;
    map['ServiceIDs'] = serviceIDs;
    map['ServiceName'] = serviceName;
    map['AreaIDs'] = areaIDs;
    map['AreaName'] = areaName;
    map['ContractStartDate'] = contractStartDate;
    map['ContractEndDate'] = contractEndDate;
    map['IsActive'] = isActive;
    return map;
  }

}