class CustomerResponse {
  CustomerResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData,);

  CustomerResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(Customer.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMsg;
  late List<Customer> rtnData;

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

class Customer {
  Customer(
    this.customerID,
    this.userID,
    this.firstName,
    this.lastNAme,
    this.mobileNo,
    this.emailID,
    this.currentAddress,
    this.dob,
    this.remarks,
    this.userName,
    this.password,);

  Customer.fromJson(dynamic json) {
    customerID = json['CustomerID'];
    userID = json['UserID'];
    firstName = json['FirstName'];
    lastNAme = json['LastNAme'];
    mobileNo = json['MobileNo'];
    emailID = json['EmailID'];
    currentAddress = json['CurrentAddress'];
    dob = json['DOB'];
    remarks = json['Remarks'];
    userName = json['UserName'];
    password = json['Password'];
  }
  late int customerID;
  late int userID;
  late String firstName;
  late String lastNAme;
  late String mobileNo;
  late String emailID;
  late String currentAddress;
  late String dob;
  late String remarks;
  late String userName;
  late String password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CustomerID'] = customerID;
    map['UserID'] = userID;
    map['FirstName'] = firstName;
    map['LastNAme'] = lastNAme;
    map['MobileNo'] = mobileNo;
    map['EmailID'] = emailID;
    map['CurrentAddress'] = currentAddress;
    map['DOB'] = dob;
    map['Remarks'] = remarks;
    map['UserName'] = userName;
    map['Password'] = password;
    return map;
  }

}