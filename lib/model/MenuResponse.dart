/// RtnStatus : true
/// RtnMsg : "Menu Loaded Successfully."
/// RtnData : [{"SubMenuID":9,"SubMenu":"Dashboard","Controller":null,"ActionName":"/dashboard","MainMenuID":6,"MainMenu":"Menu\t","MenuOrder":1,"SubMenuOrder":1,"IsActive":true,"FaIcons":"bx bx-cog"},{"SubMenuID":10,"SubMenu":"Profixer","Controller":null,"ActionName":"/admin/Profixer","MainMenuID":7,"MainMenu":"Admin","MenuOrder":2,"SubMenuOrder":1,"IsActive":true,"FaIcons":"bx bx-cog"},{"SubMenuID":11,"SubMenu":"ServiceProvider","Controller":null,"ActionName":"/admin/serviceprovider","MainMenuID":7,"MainMenu":"Admin","MenuOrder":2,"SubMenuOrder":2,"IsActive":true,"FaIcons":"bx bx-cog"},{"SubMenuID":12,"SubMenu":"Technician","Controller":null,"ActionName":"/admin/Technician","MainMenuID":7,"MainMenu":"Admin","MenuOrder":2,"SubMenuOrder":3,"IsActive":true,"FaIcons":"bx bx-cog"},{"SubMenuID":13,"SubMenu":"Customer","Controller":null,"ActionName":"/admin/Customer","MainMenuID":7,"MainMenu":"Admin","MenuOrder":2,"SubMenuOrder":4,"IsActive":true,"FaIcons":"bx bx-cog"},{"SubMenuID":14,"SubMenu":"Holidays","Controller":null,"ActionName":"/admin/Holidays","MainMenuID":7,"MainMenu":"Admin","MenuOrder":2,"SubMenuOrder":5,"IsActive":true,"FaIcons":"bx bx-cog"},{"SubMenuID":15,"SubMenu":"Area","Controller":null,"ActionName":"/admin/Area","MainMenuID":7,"MainMenu":"Admin","MenuOrder":2,"SubMenuOrder":6,"IsActive":true,"FaIcons":"bx bx-cog"},{"SubMenuID":17,"SubMenu":"Services","Controller":null,"ActionName":"/admin/Services","MainMenuID":7,"MainMenu":"Admin","MenuOrder":2,"SubMenuOrder":7,"IsActive":true,"FaIcons":"bx bx-cog"},{"SubMenuID":18,"SubMenu":"Complaint","Controller":null,"ActionName":"/admin/Complaint","MainMenuID":7,"MainMenu":"Admin","MenuOrder":2,"SubMenuOrder":8,"IsActive":true,"FaIcons":"bx bx-cog"}]
/// OtherMsg : null
/// ID : null

class MenuResponse {
  MenuResponse(
      this.rtnStatus, 
      this.rtnMsg, 
      this.rtnData, 
      this.otherMsg, 
      this.id,);

  MenuResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMsg = json['RtnMsg'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(MenuData.fromJson(v));
      });
    }
    otherMsg = json['OtherMsg'];
    id = json['ID'];
  }
  late bool rtnStatus;
  late String rtnMsg;
  late List<MenuData> rtnData;
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

/// SubMenuID : 9
/// SubMenu : "Dashboard"
/// Controller : null
/// ActionName : "/dashboard"
/// MainMenuID : 6
/// MainMenu : "Menu\t"
/// MenuOrder : 1
/// SubMenuOrder : 1
/// IsActive : true
/// FaIcons : "bx bx-cog"

class MenuData {
  MenuData(
      this.subMenuID, 
      this.subMenu, 
      this.controller, 
      this.actionName, 
      this.mainMenuID, 
      this.mainMenu, 
      this.menuOrder, 
      this.subMenuOrder, 
      this.isActive, 
      this.faIcons,);

  MenuData.fromJson(dynamic json) {
    subMenuID = json['SubMenuID'];
    subMenu = json['SubMenu'];
    controller = json['Controller'];
    actionName = json['ActionName'];
    mainMenuID = json['MainMenuID'];
    mainMenu = json['MainMenu'];
    menuOrder = json['MenuOrder'];
    subMenuOrder = json['SubMenuOrder'];
    isActive = json['IsActive'];
    faIcons = json['FaIcons'];
  }

  late int subMenuID;
  late String subMenu;
  late dynamic controller;
  late String actionName;
  late int mainMenuID;
  late String mainMenu;
  late int menuOrder;
  late int subMenuOrder;
  late bool isActive;
  late String faIcons;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SubMenuID'] = subMenuID;
    map['SubMenu'] = subMenu;
    map['Controller'] = controller;
    map['ActionName'] = actionName;
    map['MainMenuID'] = mainMenuID;
    map['MainMenu'] = mainMenu;
    map['MenuOrder'] = menuOrder;
    map['SubMenuOrder'] = subMenuOrder;
    map['IsActive'] = isActive;
    map['FaIcons'] = faIcons;
    return map;
  }

}