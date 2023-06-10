/// RtnStatus : true
/// RtnMsg : "Service Provider Details Loaded Successfully."
/// RtnData : [{"TechnicianID":5,"UserID":9,"ServiceProviderID":1,"ServiceProviderName":"Profixer Service Dept","FirstName":"Mohan","LastName":"Babu","MobileNumber":"9955663322","MailID":"mohan.babu@gmail.com","ContactAddress":"123, Sample Street, Ab sbi","PermanentAddress":"No Records","DOB":"2000-01-01T00:00:00","DOJ":"2023-01-01T00:00:00","ServiceIDs":"1,2","ServiceName":"AC Repair,House Keeping","AreaIDs":"1,2","AreaName":" Junction,Airport","IsActive":1,"UserNAme":"9955663325","Password":"9894"},{"TechnicianID":6,"UserID":12,"ServiceProviderID":2,"ServiceProviderName":"ABC Corporation","FirstName":"Technician1","LastName":"One","MobileNumber":"9842256562","MailID":"tech1@gmail.com","ContactAddress":"","PermanentAddress":"","DOB":"2023-05-23T00:00:00","DOJ":"2023-05-23T00:00:00","ServiceIDs":"1","ServiceName":"AC Repair","AreaIDs":"3,4","AreaName":"Airport,Pop Station","IsActive":1,"UserNAme":"9842256562","Password":"9842"}]
/// OtherMsg : null
/// ID : null

class TechnicianResponse {
  TechnicianResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData, 
      this.otherMsg, 
      this.id,);

  TechnicianResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(TechnicainData.fromJson(v));
      });
    }
    otherMsg = json['OtherMsg'];
    id = json['ID'];
  }
 late  bool rtnStatus;
 late  String rtnMsg;
 late  List<TechnicainData> rtnData;
 late  dynamic otherMsg;
 late  dynamic id;

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

/// TechnicianID : 5
/// UserID : 9
/// ServiceProviderID : 1
/// ServiceProviderName : "Profixer Service Dept"
/// FirstName : "Mohan"
/// LastName : "Babu"
/// MobileNumber : "9955663322"
/// MailID : "mohan.babu@gmail.com"
/// ContactAddress : "123, Sample Street, Ab sbi"
/// PermanentAddress : "No Records"
/// DOB : "2000-01-01T00:00:00"
/// DOJ : "2023-01-01T00:00:00"
/// ServiceIDs : "1,2"
/// ServiceName : "AC Repair,House Keeping"
/// AreaIDs : "1,2"
/// AreaName : " Junction,Airport"
/// IsActive : 1
/// UserNAme : "9955663325"
/// Password : "9894"

class TechnicainData {
  TechnicainData(
      this.technicianID, 
      this.userID, 
      this.serviceProviderID, 
      this.serviceProviderName, 
      this.firstName, 
      this.lastName, 
      this.mobileNumber, 
      this.mailID, 
      this.contactAddress, 
      this.permanentAddress, 
      this.dob, 
      this.doj, 
      this.serviceIDs, 
      this.serviceName, 
      this.areaIDs, 
      this.areaName, 
      this.isActive, 
      this.userNAme, 
      this.password,);

  TechnicainData.fromJson(dynamic json) {
    technicianID = json['TechnicianID'];
    userID = json['UserID'];
    serviceProviderID = json['ServiceProviderID'];
    serviceProviderName = json['ServiceProviderName'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    mobileNumber = json['MobileNumber'];
    mailID = json['MailID'];
    contactAddress = json['ContactAddress'];
    permanentAddress = json['PermanentAddress'];
    dob = json['DOB'];
    doj = json['DOJ'];
    serviceIDs = json['ServiceIDs'];
    serviceName = json['ServiceName'];
    areaIDs = json['AreaIDs'];
    areaName = json['AreaName'];
    isActive = json['IsActive'];
    userNAme = json['UserNAme'];
    password = json['Password'];
  }
  late int technicianID;
  late int userID;
  late int serviceProviderID;
  late String serviceProviderName;
  late String firstName;
  late String lastName;
  late String mobileNumber;
  late String mailID;
  late String contactAddress;
  late String permanentAddress;
  late String dob;
  late String doj;
  late String serviceIDs;
  late String serviceName;
  late String areaIDs;
  late String areaName;
  late int isActive;
  late String userNAme;
  late String password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TechnicianID'] = technicianID;
    map['UserID'] = userID;
    map['ServiceProviderID'] = serviceProviderID;
    map['ServiceProviderName'] = serviceProviderName;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['MobileNumber'] = mobileNumber;
    map['MailID'] = mailID;
    map['ContactAddress'] = contactAddress;
    map['PermanentAddress'] = permanentAddress;
    map['DOB'] = dob;
    map['DOJ'] = doj;
    map['ServiceIDs'] = serviceIDs;
    map['ServiceName'] = serviceName;
    map['AreaIDs'] = areaIDs;
    map['AreaName'] = areaName;
    map['IsActive'] = isActive;
    map['UserNAme'] = userNAme;
    map['Password'] = password;
    return map;
  }

}