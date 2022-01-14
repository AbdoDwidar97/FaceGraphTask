import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class AppTextField extends StatefulWidget
{
  double width, labelFontSize, textFontSize;
  String labelText;
  TextEditingController controller;
  TextInputType textInputType;
  Function validate;

  AppTextField({
    required this.width,
    required this.labelFontSize,
    required this.textFontSize,
    required this.labelText,
    required this.controller,
    this.textInputType = TextInputType.text,
    required this.validate,
  });

  @override
  State<StatefulWidget> createState() => AppTextFieldState();
}

class AppTextFieldState extends State <AppTextField>
{
  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: widget.width,
      height: MediaQuery.of(context).size.height / 50 * 5,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(fontSize: widget.labelFontSize, fontFamily: "Cairo", height: 1),
        ),
        style: TextStyle(fontSize: widget.textFontSize, color: Colors.black, fontFamily: "Cairo", height: 1),
        validator: (val) => widget.validate(val),
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      ),
    );

  }

}

/// --------------------------------------------------------------

// ignore: must_be_immutable
class AppTextAreaField extends StatefulWidget
{
  double width, labelFontSize, textFontSize;
  String labelText;
  TextEditingController controller;
  TextInputType textInputType;
  Function validate;

  AppTextAreaField({
    required this.width,
    required this.labelFontSize,
    required this.textFontSize,
    required this.labelText,
    required this.controller,
    this.textInputType = TextInputType.text,
    required this.validate,
  });

  @override
  State<StatefulWidget> createState() => AppTextAreaFieldState();
}

class AppTextAreaFieldState extends State <AppTextAreaField>
{
  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: widget.width,
      height: MediaQuery.of(context).size.height / 50 * 5,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(fontSize: widget.labelFontSize, fontFamily: "Cairo", height: 1),
        ),
        style: TextStyle(fontSize: widget.textFontSize, color: Colors.black, fontFamily: "Cairo", height: 1),
        validator: (val) => widget.validate(val),
      ),
    );

  }

}

/// --------------------------------------------------------------

// ignore: must_be_immutable
class AppButton extends StatelessWidget
{
  double width, height;
  Widget buttonTextWidget;
  Color buttonColor;
  Function onClick;

  AppButton({
    required this.width,
    required this.height,
    required this.buttonColor,
    required this.buttonTextWidget,
    required this.onClick
  });

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () => onClick(),
        child: buttonTextWidget,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)
          )),
          backgroundColor: MaterialStateProperty.all(buttonColor),
        ),
      ),
    );
  }

}


/// -----------------------------------------------------------------------------------

// ignore: must_be_immutable
class AppConfirmedDialog extends StatelessWidget
{
  double widthUnit = 0, heightUnit = 0;
  String _dialogText, _svgDialogImage;

  AppConfirmedDialog({
    required String dialogText,
    required String svgDialogImage
  }) :
        _dialogText = dialogText,
        _svgDialogImage = svgDialogImage;


  @override
  Widget build(BuildContext context)
  {
    widthUnit = MediaQuery.of(context).size.width / 50;
    heightUnit = MediaQuery.of(context).size.height / 50;

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });

    return Dialog(
      insetPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: widthUnit * 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: widthUnit * 2,
                  right: widthUnit * 2
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: heightUnit * 2),

                  SvgPicture.asset(_svgDialogImage),

                  SizedBox(height: heightUnit * 1),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_dialogText + " ",
                          style: TextStyle(fontSize: heightUnit * 1.1, color: Colors.black, fontWeight: FontWeight.bold,
                              fontFamily: "Cairo", height: 1.5)),

                      Icon(Icons.check_circle, color: Colors.green, size: widthUnit * heightUnit * 0.2),
                    ],
                  ),

                  SizedBox(height: heightUnit * 2),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

}