import 'dart:io';
import 'package:fg_task/Model/Components/inspection_item.dart';
import 'package:fg_task/Model/Database/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MainScreenViewModel with ChangeNotifier
{
  final DBHelper _dbHelper = DBHelper();

  String? takenImagePath;

  InspectionItem? _selectedItem;
  int? _selectedItemIndex;

  List <InspectionItem> _inspectionItems = [];

  List <InspectionItem> get inspectionItems => _inspectionItems;

  void selectInspectionItem (InspectionItem item, int idx)
  {
    _selectedItem = item;
    _selectedItemIndex = idx;
  }

  InspectionItem get selectedItem => _selectedItem!;

  String formatDate(DateTime dateTime)
  {
    /// yMMMMEEEEd -> Tuesday 11 Jan 2022
    var formatter = DateFormat.yMMMMEEEEd().add_jm();
    String formatted = formatter.format(dateTime);

    return formatted;
  }

  void pickImageAndSaveToLocalStorage (String fileName) async
  {
    PickedFile? myImage = await _pickImageFromCamera();
    // takenImagePath = await _saveFile(fileName, myImage!);

    notifyListeners();
  }

  Future <PickedFile?> _pickImageFromCamera () async
  {
    ImagePicker _picker = ImagePicker();
    return await _picker.getImage(source: ImageSource.camera);
  }

  Future <String> _saveFile(String fileName, PickedFile image) async
  {
    String imagePath = await _getFilePath(fileName);
    File file = File(imagePath);
    file.writeAsBytes(await image.readAsBytes());

    return imagePath;
  }

  Future<String> _getFilePath(String fileName) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/$fileName';

    return filePath;
  }

  void getInspectionItems () async
  {
    _inspectionItems = await _dbHelper.getAllInspectionItems();
    notifyListeners();
  }

  void addInspectionItem (String title, String description, BuildContext context) async
  {
    if (takenImagePath!.isEmpty)
    {
      var snackBar = const SnackBar(content: Text('You should pick an image'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    InspectionItem item = InspectionItem(
      title: title,
      description: description,
      picture: takenImagePath,
      dateTime: DateTime.now(),
      status: true
    );

    _inspectionItems.add(await _dbHelper.insertInspectionItem(item));

    notifyListeners();
  }

  void deleteInspectionItem (int id, int idx) async
  {
    int status = await _dbHelper.deleteInspectionItem(id);
    if (status == 1) _inspectionItems.removeAt(idx);

    notifyListeners();
  }

  void updateInspectionItem (InspectionItem item) async
  {
    int status = await _dbHelper.updateInspectionItem(item);
    if (status == 1) _inspectionItems[_selectedItemIndex!] = item;

    notifyListeners();
  }

}