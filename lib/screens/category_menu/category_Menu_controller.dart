import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class CategoryMenuController extends GetxController {
  List menu = [
    {
      "title": "Add Categories",
      "imagePath": 'assets/icon/menu/plusicon.svg',
      "path": Routes.addCategory,
    },
    {
      "title": "Plumbing",
      "imagePath": 'assets/icon/menu/waterdrop.svg',
    },
    {
      "title": "AC Repair",
      "imagePath": 'assets/icon/menu/ac.svg',
    },
    {
      "title": "Painting",
      "imagePath": 'assets/icon/menu/ac.svg',
    },
  ];
}
