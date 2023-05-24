/// RtnStatus : true
/// RtnMsg : "Login Successfully."
/// RtnData : {"UserID":1,"FirstName":"Admin","LastName":"Profixer","UserName":"9894407062","Password":"OTg5NA==","MobileNo":"9894407062","MailID":"saktheeswaran.a@dbzeus.com","ImagePath":null,"RoleID":2,"RoleName":"Admin","Designation":"Controller","CurrentAddress":"","PermanentAddress":"","WebToken":"string","MobileToken":"string","LastLogin":"24-05-2023 07:16","IsRelived":false,"RtnStatus":true,"RtnMsg":"Login Successfully.","IsActive":true,"CUID":0}
/// OtherMsg : null
/// ID : null

class UserDataResponse {
  UserDataResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData, 
      this.otherMsg, 
      this.id,);

  UserDataResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    rtnData = (json['RtnData'] != null ? UserData.fromJson(json['RtnData']) : null)!;
    otherMsg = json['OtherMsg'];
    id = json['ID'];
  }
  late bool rtnStatus;
  late String rtnMsg;
  late UserData rtnData;
  late dynamic otherMsg;
  late dynamic id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMsg'] = rtnMsg;
    if (rtnData != null) {
      map['RtnData'] = rtnData.toJson();
    }
    map['OtherMsg'] = otherMsg;
    map['ID'] = id;
    return map;
  }

}

/// UserID : 1
/// FirstName : "Admin"
/// LastName : "Profixer"
/// UserName : "9894407062"
/// Password : "OTg5NA=="
/// MobileNo : "9894407062"
/// MailID : "saktheeswaran.a@dbzeus.com"
/// ImagePath : null
/// RoleID : 2
/// RoleName : "Admin"
/// Designation : "Controller"
/// CurrentAddress : ""
/// PermanentAddress : ""
/// WebToken : "string"
/// MobileToken : "string"
/// LastLogin : "24-05-2023 07:16"
/// IsRelived : false
/// RtnStatus : true
/// RtnMsg : "Login Successfully."
/// IsActive : true
/// CUID : 0

class UserData {
  UserData(
      this.userID, 
      this.firstName, 
      this.lastName, 
      this.userName, 
      this.password, 
      this.mobileNo, 
      this.mailID, 
      this.imagePath, 
      this.roleID, 
      this.roleName, 
      this.designation, 
      this.currentAddress, 
      this.permanentAddress, 
      this.webToken, 
      this.mobileToken, 
      this.lastLogin, 
      this.isRelived, 
      this.rtnStatus, 
      this.rtnMsg, 
      this.isActive, 
      this.cuid,);

  UserData.fromJson(dynamic json) {
    userID = json['UserID'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userName = json['UserName'];
    password = json['Password'];
    mobileNo = json['MobileNo'];
    mailID = json['MailID'];
    imagePath = json['ImagePath'];
    roleID = json['RoleID'];
    roleName = json['RoleName'];
    designation = json['Designation'];
    currentAddress = json['CurrentAddress'];
    permanentAddress = json['PermanentAddress'];
    webToken = json['WebToken'];
    mobileToken = json['MobileToken'];
    lastLogin = json['LastLogin'];
    isRelived = json['IsRelived'];
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    isActive = json['IsActive'];
    cuid = json['CUID'];
  }
  late int userID;
 late  String firstName;
 late  String lastName;
 late  String userName;
 late  String password;
 late  String mobileNo;
 late  String mailID;
 late  dynamic imagePath;
 late  int roleID;
 late  String roleName;
 late  String designation;
 late  String currentAddress;
 late  String permanentAddress;
 late  String webToken;
 late  String mobileToken;
 late  String lastLogin;
 late  bool isRelived;
 late  bool rtnStatus;
 late  String rtnMsg;
 late  bool isActive;
 late  int cuid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserID'] = userID;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['UserName'] = userName;
    map['Password'] = password;
    map['MobileNo'] = mobileNo;
    map['MailID'] = mailID;
    map['ImagePath'] = imagePath;
    map['RoleID'] = roleID;
    map['RoleName'] = roleName;
    map['Designation'] = designation;
    map['CurrentAddress'] = currentAddress;
    map['PermanentAddress'] = permanentAddress;
    map['WebToken'] = webToken;
    map['MobileToken'] = mobileToken;
    map['LastLogin'] = lastLogin;
    map['IsRelived'] = isRelived;
    map['RtnStatus'] = rtnStatus;
    map['RtnMsg'] = rtnMsg;
    map['IsActive'] = isActive;
    map['CUID'] = cuid;
    return map;
  }

}