import 'dart:io';
import 'package:fg_task/Constants/app_colors.dart';
import 'package:fg_task/View/insertion_update_screen.dart';
import 'package:fg_task/ViewModel/main_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State <MainScreen>
{
  double widthUnit = 0, heightUnit = 0;

  late MainScreenViewModel _mainScreenViewModel;

  @override
  void initState()
  {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_)
    {
      Provider.of<MainScreenViewModel>(context, listen: false).getInspectionItems();
    });

  }

  @override
  Widget build(BuildContext context)
  {
    widthUnit = MediaQuery.of(context).size.width / 50;
    heightUnit = MediaQuery.of(context).size.height / 50;

    _mainScreenViewModel = Provider.of<MainScreenViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        centerTitle: true,
        title: Text("FaceGraph Task", style: TextStyle(color: Colors.white, fontSize: heightUnit * widthUnit * 0.18)),
      ),
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: SizedBox(
        width: widthUnit * 6,
        height: heightUnit * 6,
        child: FloatingActionButton(
          onPressed: () => floatingBtnAction(),
          backgroundColor: Colors.green[800],
          child: Icon(Icons.add, size: widthUnit * heightUnit * 0.2),
        ),
      ),
      body: SizedBox(
        width: widthUnit * 50,
        height: heightUnit * 50,
        child: Consumer <MainScreenViewModel>(
          builder: (context, mainActivityViewModel, child)
          {
            return ListView.separated(
              itemCount: _mainScreenViewModel.inspectionItems.length,
              separatorBuilder: (context, itemIndex)
              {
                return SizedBox(height: heightUnit * 0.2);
              },
              itemBuilder: (context, itemIndex)
              {
                return Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: heightUnit,
                        bottom: heightUnit,
                        left: widthUnit * 1.5,
                        right: widthUnit * 1.5
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [

                            Text(
                              "${mainActivityViewModel.inspectionItems[itemIndex].id.toString()} - ",
                                style: TextStyle(fontSize: widthUnit * heightUnit * 0.16, color: Colors.black, fontWeight: FontWeight.bold),
                            ),

                            Text(
                              mainActivityViewModel.inspectionItems[itemIndex].title,
                              style: TextStyle(fontSize: widthUnit * heightUnit * 0.16, color: Colors.black, fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),

                        SizedBox(height: heightUnit),

                        Image.file(File(mainActivityViewModel.inspectionItems[itemIndex].picture)),

                        SizedBox(height: heightUnit),

                        Text(
                          mainActivityViewModel.inspectionItems[itemIndex].description,
                          style: TextStyle(fontSize: widthUnit * heightUnit * 0.14, color: Colors.black),
                        ),

                        SizedBox(height: heightUnit),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                              mainActivityViewModel.formatDate(mainActivityViewModel.inspectionItems[itemIndex].dateTime),
                              style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, color: Colors.grey[800]),
                            ),

                            Text(
                              (mainActivityViewModel.inspectionItems[itemIndex].status) ? "Open" : "Closed",
                              style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, color: Colors.blue[700], fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }

  void floatingBtnAction ()
  {
    Navigator.of(context).push(MaterialPageRoute( builder: (context) => InsertionUpdateScreen()));
  }

}