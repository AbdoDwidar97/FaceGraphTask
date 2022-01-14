import 'package:fg_task/Model/Components/inspection_item.dart';
import 'package:fg_task/ViewModel/main_screen_view_model.dart';
import 'package:fg_task/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InsertionUpdateScreen extends StatelessWidget
{
  late MainScreenViewModel _mainScreenViewModel;
  double widthUnit = 0, heightUnit = 0;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool creationMode = true;

  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context)
  {
    widthUnit = MediaQuery.of(context).size.width / 50;
    heightUnit = MediaQuery.of(context).size.height / 50;

    _mainScreenViewModel = Provider.of<MainScreenViewModel>(context);

    _buildContext = context;

    return Scaffold(
      appBar: AppBar(
        title: Text("Inspection Item Info", style: TextStyle(color: Colors.white, fontSize: heightUnit * widthUnit * 0.18)),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: widthUnit * 50,
          // height: heightUnit * 50,
          padding: EdgeInsets.only(left: widthUnit * 2, right: widthUnit * 2),
          child: Column(
            children: [

              AppTextField(
                  width: widthUnit * 50,
                  labelFontSize: widthUnit * heightUnit * 0.14,
                  textFontSize: widthUnit * heightUnit * 0.14,
                  labelText: "Title",
                  controller: titleController,
                  validate: (String val) => (val.isEmpty) ? "Required Field" : null
              ),

              SizedBox(height: heightUnit),

              AppTextAreaField(
                  width: widthUnit * 50,
                  labelFontSize: widthUnit * heightUnit * 0.14,
                  textFontSize: widthUnit * heightUnit * 0.14,
                  labelText: "Description",
                  controller: descriptionController,
                  validate: (String val) => (val.isEmpty) ? "Required Field" : null
              ),

              SizedBox(height: heightUnit),

              AppButton(
                  width: widthUnit * 50,
                  height: heightUnit * 3,
                  buttonColor: Colors.black,
                  buttonTextWidget: Text("Open camera to picture", style: TextStyle(fontSize: widthUnit * heightUnit * 0.14, color: Colors.white)),
                  onClick: () => btnPicture()
              ),

              SizedBox(height: heightUnit),

              Consumer <MainScreenViewModel>(
                  builder: (context, viewModel, child) => (viewModel.takenImage == null) ? const SizedBox() : Image.memory(viewModel.takenImage!)
              ),

              SizedBox(height: heightUnit),

              AppButton(
                  width: widthUnit * 50,
                  height: heightUnit * 3,
                  buttonColor: Colors.green[800]!,
                  buttonTextWidget: Text("Save", style: TextStyle(fontSize: widthUnit * heightUnit * 0.14, color: Colors.white)),
                  onClick: () => btnSave()
              ),

              SizedBox(height: heightUnit * 2),

            ],
          ),
        ),
      ),
    );
  }

  void btnPicture () async
  {
    _mainScreenViewModel.pickImageFromCamera();
  }

  void btnSave ()
  {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();

    bool status = false;

    if (creationMode) {
      _mainScreenViewModel.addInspectionItem(title, description, _buildContext);
    }
    else {
      InspectionItem item = InspectionItem(
        id: _mainScreenViewModel.selectedItem.id,
        picture: String.fromCharCodes(_mainScreenViewModel.takenImage!),
        dateTime: _mainScreenViewModel.selectedItem.dateTime,
        status: status,
        title: title,
        description: description
      );

      _mainScreenViewModel.updateInspectionItem(item);
    }

  }

}