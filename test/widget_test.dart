// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String imagePath = "/Users/hao/HaoApp/Flutter/flutter_wanandroid/assets/images";

String projectPackageName = "flutter_wanandroid";
String projectCodeDir = "/Users/hao/HaoApp/Flutter/flutter_wanandroid/lib/";

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // generateImageName(imagePath);
    generateExport("page");
  });
}

void generateImageName() {
  try {
    var directory = new Directory(imagePath);
    List<FileSystemEntity> files = directory.listSync();
    for (var f in files) {
      if (f.path.endsWith("DS_Store")) {
        continue;
      }
      String name = f.path.split("/").last;
      print("static final String ${under2Hump(name)} = \"$name\";");
    }
  } catch (e) {
    print(e);
  }
}

void generateExport(String path) {
  try {
    var directory = new Directory("$projectCodeDir/$path");
    List<FileSystemEntity> files = directory.listSync();
    for (var f in files) {
      if (f.path.endsWith("DS_Store")) {
        continue;
      }
      print(
          "export 'package:$projectPackageName/$path/${f.path.split("/").last}';");
    }
  } catch (e) {
    print(e);
  }
}

String under2Hump(String under) {
  if (!under.contains("_")) {
    return under;
  }
  String hump = "";
  List<String> arr =
      under.substring(0, under.indexOf(".")).toLowerCase().split("_");
  for (int i = 0; i < arr.length; i++) {
    if (i == 0) {
      hump += arr[i];
    } else {
      String w = arr[i].substring(0, 1).toUpperCase() + arr[i].substring(1);
      hump += w;
    }
  }

  return hump;
}
