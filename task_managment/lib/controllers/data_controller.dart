// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';

// import '../services/service.dart';

// class DataController extends GetxController {
//   DataService dataService = DataService();

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   // alltask data list
//   List<dynamic> _myData = [];
//   List<dynamic> get myData => _myData;

//   // selected task data list
//   late Map<String, dynamic> _findData = {};
//   Map<String, dynamic> get findData => _findData;

//   Future<void> getData() async {
//     _isLoading = true;
//     Response response = await dataService.getData();

//     if (response.statusCode == 200) {
//       _myData = response.body;
//       print("we got a data");
//       update();
//     } else {
//       print("we did not get any data");
//     }
//   }

//   Future<void> postData(String taskName, String taskDetails) async {
//     _isLoading = true;
//     // pass the data using Json type
//     Response response = await dataService.postData({
//       "task_name": taskName,
//       "task_details": taskDetails,
//     });

//     if (response.statusCode == 200) {
//       update();
//       print("post data success");
//     } else {
//       print("post data faild");
//     }
//   }

//   Future<void> findTask(int id) async {
//     _isLoading = true;
//     // print("controller : " + id.toString());
//     // pass the data using Json type
//     Response response = await dataService.getTaskData(id);

//     if (response.statusCode == 200) {
//       // _findData = response.body;
//       _findData = jsonDecode(response.body);
//       update();
//       if (kDebugMode) {
//         // print(_findData['task_name']);
//       }

//       print("find task data success");
//     } else {
//       print("find task data faild ${response.statusCode}");
//     }
//   }

//   Future<void> updateTask(
//       String id, String taskName, String taskDetails) async {
//     _isLoading = true;
//     // print("controller : " + id.toString());
//     // pass the data using Json type
//     Response response = await dataService.updateTaskData(id, {
//       "task_name": taskName,
//       "task_details": taskDetails,
//     });

//     if (response.statusCode == 200) {
//       // _findData = response.body;
//       // _findData = jsonDecode(response.body);
//       update();
//       if (kDebugMode) {
//         // print(_findData['task_name']);
//       }

//       print("update task data success");
//     } else {
//       print("update task data faild");
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../services/service.dart';

class DataController extends GetxController {
  DataService dataService = DataService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // all task data list
  List<dynamic> _myData = [];
  List<dynamic> get myData => _myData;

  // selected task data
  late Map<String, dynamic> _findData = {};
  Map<String, dynamic> get findData => _findData;

  Future<void> getData() async {
    _isLoading = true;
    Response response = await dataService.getData();

    if (response.statusCode == 200) {
      _myData = response.body;
      print("we got a data");
      update();
    } else {
      print("we did not get any data");
    }
  }

  Future<void> postData(String taskName, String taskDetails) async {
    _isLoading = true;
    // pass the data using Json type
    Response response = await dataService.postData({
      "task_name": taskName,
      "task_details": taskDetails,
    });

    if (response.statusCode == 200) {
      update();
      print("post data success");
    } else {
      print("post data failed");
    }
  }

  Future<void> findTask(int id) async {
    _isLoading = true;
    Response response = await dataService.getTaskData(id);

    if (response.statusCode == 200) {
      _findData = jsonDecode(response.body);
      update();
      print("find task data success");
    } else {
      print("find task data failed ${response.statusCode}");
    }
  }

  Future<void> updateTask(
      String id, String taskName, String taskDetails) async {
    _isLoading = true;
    Response response = await dataService.updateTaskData(id, {
      "task_name": taskName,
      "task_details": taskDetails,
    });

    if (response.statusCode == 200) {
      update();
      print("update task data success");
    } else {
      print("update task data failed");
    }
  }

  // delete task data
  Future<void> deleteTaskData(int id) async {
    _isLoading = true;
    Response response = await dataService.deleteTaskData(id);

    if (response.statusCode == 200) {
      // Remove deleted task from _myData list
      _myData.removeWhere((task) => task['id'] == id);
      update();
      print("delete task data success");
    } else {
      print("delete task data failed ${response.statusCode}");
    }
  }
}
