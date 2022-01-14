import 'dart:typed_data';
import 'package:fg_task/Model/Components/inspection_item.dart';
import 'package:fg_task/Model/Database/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class MainScreenViewModel with ChangeNotifier
{
  final DBHelper _dbHelper = DBHelper();

  Uint8List? takenImage;

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

  void pickImageFromCamera () async
  {
    ImagePicker _picker = ImagePicker();
    XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    takenImage = await photo!.readAsBytes();

    notifyListeners();
  }

  /// DONE
  void insertInspectionItemsTest (List <InspectionItem> items) async
  {
    for (InspectionItem itr in items)
    {
      InspectionItem i = await _dbHelper.insertInspectionItem(itr);
      print("the item ${i.title} is ${i.id}");
    }

    // notifyListeners();
  }

  void getInspectionItems () async
  {
    _inspectionItems = await _dbHelper.getAllInspectionItems();
    notifyListeners();
  }

  void addInspectionItem (String title, String description, BuildContext context) async
  {
    if (takenImage == null)
    {
      var snackBar = const SnackBar(content: Text('You should pick an image'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    InspectionItem item = InspectionItem(
      title: title,
      description: description,
      picture: String.fromCharCodes(takenImage!),
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