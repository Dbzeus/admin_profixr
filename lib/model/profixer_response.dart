/// RtnStatus : true
/// RtnMsg : "Profixer user's Details Loaded Successfully."
/// RtnData : [{"AdminID":1,"UserID":1,"FirstName":"Admin","LastName":"Profixer","Desigination":"Controller","DOB":"2000-01-01T00:00:00","DOJ":"2022-01-01T00:00:00","MobileNo":"9894407062","CurrentAddress":"","PermanentAddress":"","IsRelived":false,"RelivedDate":null,"RelivedReason":null,"IsActive":true,"CUID":1,"CUDate":"2023-05-18T09:41:42.797","MUID":1,"MUDate":"2023-05-23T09:51:30.27","EmailId":"saktheeswaran.a@dbzeus.com","UserNAme":"9894407062","Password":"9894"}]
/// OtherMsg : null
/// ID : null

class ProfixerResponse {
  ProfixerResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData, 
      this.otherMsg, 
      this.id,);

  ProfixerResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(ProfixerData.fromJson(v));
      });
    }
    otherMsg = json['OtherMsg'];
    id = json['ID'];
  }
 late bool rtnStatus;
 late String rtnMsg;
 late List<ProfixerData> rtnData;
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

/// AdminID : 1
/// UserID : 1
/// FirstName : "Admin"
/// LastName : "Profixer"
/// Desigination : "Controller"
/// DOB : "2000-01-01T00:00:00"
/// DOJ : "2022-01-01T00:00:00"
/// MobileNo : "9894407062"
/// CurrentAddress : ""
/// PermanentAddress : ""
/// IsRelived : false
/// RelivedDate : null
/// RelivedReason : null
/// IsActive : true
/// CUID : 1
/// CUDate : "2023-05-18T09:41:42.797"
/// MUID : 1
/// MUDate : "2023-05-23T09:51:30.27"
/// EmailId : "saktheeswaran.a@dbzeus.com"
/// UserNAme : "9894407062"
/// Password : "9894"

class ProfixerData {
  ProfixerData(
      this.adminID, 
      this.userID, 
      this.firstName, 
      this.lastName, 
      this.desigination, 
      this.dob, 
      this.doj, 
      this.mobileNo, 
      this.currentAddress, 
      this.permanentAddress, 
      this.isRelived, 
      this.relivedDate, 
      this.relivedReason, 
      this.isActive, 
      this.cuid, 
      this.cUDate, 
      this.muid, 
      this.mUDate, 
      this.emailId, 
      this.userNAme, 
      this.password,);

  ProfixerData.fromJson(dynamic json) {
    adminID = json['AdminID'];
    userID = json['UserID'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    desigination = json['Desigination'];
    dob = json['DOB'];
    doj = json['DOJ'];
    mobileNo = json['MobileNo'];
    currentAddress = json['CurrentAddress'];
    permanentAddress = json['PermanentAddress'];
    isRelived = json['IsRelived'];
    relivedDate = json['RelivedDate'];
    relivedReason = json['RelivedReason'];
    isActive = json['IsActive'];
    cuid = json['CUID'];
    cUDate = json['CUDate'];
    muid = json['MUID'];
    mUDate = json['MUDate'];
    emailId = json['EmailId'];
    userNAme = json['UserNAme'];
    password = json['Password'];
  }
  late int adminID;
  late int userID;
  late String firstName;
  late String lastName;
  late String desigination;
  late String dob;
  late String doj;
  late String mobileNo;
  late String currentAddress;
  late String permanentAddress;
  late bool isRelived;
  late dynamic relivedDate;
  late dynamic relivedReason;
  late bool isActive;
  late int cuid;
  late String cUDate;
  late int muid;
  late String mUDate;
  late String emailId;
  late String userNAme;
  late String password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AdminID'] = adminID;
    map['UserID'] = userID;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['Desigination'] = desigination;
    map['DOB'] = dob;
    map['DOJ'] = doj;
    map['MobileNo'] = mobileNo;
    map['CurrentAddress'] = currentAddress;
    map['PermanentAddress'] = permanentAddress;
    map['IsRelived'] = isRelived;
    map['RelivedDate'] = relivedDate;
    map['RelivedReason'] = relivedReason;
    map['IsActive'] = isActive;
    map['CUID'] = cuid;
    map['CUDate'] = cUDate;
    map['MUID'] = muid;
    map['MUDate'] = mUDate;
    map['EmailId'] = emailId;
    map['UserNAme'] = userNAme;
    map['Password'] = password;
    return map;
  }

}