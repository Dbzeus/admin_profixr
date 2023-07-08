/// RtnStatus : true
/// RtnMsg : "Service Provider Details Loaded Successfully."
/// RtnData : [{"ServiceProviderUserID":1,"ServiceProviderName":"Profixer Service Dept","UserID":2,"ServiceProviderID":1,"FirstName":"Mohan","LastName":"Babu","MobileNumber":"9955663322","MailID":"mohan.babu@gmail.com","ContactAddress":"123, Sample Street, Ab sbi","PermanentAddress":"No Records","DOB":"2000-01-01T00:00:00","DOJ":"2023-01-01T00:00:00","IsActive":1,"UserNAme":"9955663322","Password":"9894"}]
/// OtherMsg : null
/// ID : null

class AdminResponse {
  AdminResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData, 
      this.otherMsg, 
      this.id,);

  AdminResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(AdminData.fromJson(v));
      });
    }
    otherMsg = json['OtherMsg'];
    id = json['ID'];
  }
  late bool rtnStatus;
  late String rtnMsg;
  late List<AdminData> rtnData;
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

/// ServiceProviderUserID : 1
/// ServiceProviderName : "Profixer Service Dept"
/// UserID : 2
/// ServiceProviderID : 1
/// FirstName : "Mohan"
/// LastName : "Babu"
/// MobileNumber : "9955663322"
/// MailID : "mohan.babu@gmail.com"
/// ContactAddress : "123, Sample Street, Ab sbi"
/// PermanentAddress : "No Records"
/// DOB : "2000-01-01T00:00:00"
/// DOJ : "2023-01-01T00:00:00"
/// IsActive : 1
/// UserNAme : "9955663322"
/// Password : "9894"

class AdminData {
  AdminData(
      this.serviceProviderUserID, 
      this.serviceProviderName, 
      this.userID, 
      this.serviceProviderID, 
      this.firstName, 
      this.lastName, 
      this.mobileNumber, 
      this.mailID, 
      this.contactAddress, 
      this.permanentAddress,
      this.nationalId,
      this.dob, 
      this.doj, 
      this.isActive, 
      this.userNAme, 
      this.password,);

  AdminData.fromJson(dynamic json) {
    serviceProviderUserID = json['ServiceProviderUserID'];
    serviceProviderName = json['ServiceProviderName'];
    userID = json['UserID'];
    serviceProviderID = json['ServiceProviderID'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    mobileNumber = json['MobileNumber'];
    mailID = json['MailID'];
    contactAddress = json['ContactAddress'];
    permanentAddress = json['PermanentAddress'];
    nationalId = json['NationalID'];
    dob = json['DOB'];
    doj = json['DOJ'];
    isActive = json['IsActive'];
    userNAme = json['UserNAme'];
    password = json['Password'];
  }
late  int serviceProviderUserID;
late  String serviceProviderName;
late  int userID;
late  int serviceProviderID;
late  String firstName;
late  String lastName;
late  String mobileNumber;
late  String mailID;
late  String contactAddress;
late  String permanentAddress;
late String nationalId;
late  String dob;
late  String doj;
late  bool isActive;
late  String userNAme;
late  String password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ServiceProviderUserID'] = serviceProviderUserID;
    map['ServiceProviderName'] = serviceProviderName;
    map['UserID'] = userID;
    map['ServiceProviderID'] = serviceProviderID;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['MobileNumber'] = mobileNumber;
    map['MailID'] = mailID;
    map['ContactAddress'] = contactAddress;
    map['PermanentAddress'] = permanentAddress;
    map['NationalID'] = nationalId;
    map['DOB'] = dob;
    map['DOJ'] = doj;
    map['IsActive'] = isActive;
    map['UserNAme'] = userNAme;
    map['Password'] = password;
    return map;
  }

}