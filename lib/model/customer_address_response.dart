
class CustomerAddressResponse {
  CustomerAddressResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData,);

  CustomerAddressResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(CustomerAddress.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMsg;
  late List<CustomerAddress> rtnData;

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

class CustomerAddress {
  CustomerAddress(
    this.addressID,
    this.customerID,
    this.firstName,
    this.addressTitle,
    this.doorNo,
    this.streetName,
    this.cityID,
    this.areaID,
    this.landMark,
    this.latitude,
    this.longitude,
    this.isActive,);

  CustomerAddress.fromJson(dynamic json) {
    addressID = json['AddressID'];
    customerID = json['CustomerID'];
    firstName = json['FirstName'];
    addressTitle = json['AddressTitle'];
    doorNo = json['DoorNo'];
    streetName = json['StreetName'];
    cityID = json['CityID'];
    areaID = json['AreaID'];
    landMark = json['LandMark'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    isActive = json['IsActive'];
  }
  late int addressID;
  late int customerID;
  late String firstName;
  late String addressTitle;
  late String doorNo;
  late String streetName;
  late int cityID;
  late int areaID;
  late String landMark;
  late String latitude;
  late String longitude;
  late bool isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AddressID'] = addressID;
    map['CustomerID'] = customerID;
    map['FirstName'] = firstName;
    map['AddressTitle'] = addressTitle;
    map['DoorNo'] = doorNo;
    map['StreetName'] = streetName;
    map['CityID'] = cityID;
    map['AreaID'] = areaID;
    map['LandMark'] = landMark;
    map['Latitude'] = latitude;
    map['Longitude'] = longitude;
    map['IsActive'] = isActive;
    return map;
  }

}