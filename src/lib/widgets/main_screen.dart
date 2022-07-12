import 'package:camera/camera.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:ipm_p2/config/app_config.dart';
import 'package:ipm_p2/locale/localization.i18n.dart';
import 'package:ipm_p2/widgets/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ipm_p2/widgets/alert_dialog_box.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return I18n(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppConfig.of(context).title),
        ),
        body: Center(child: buildColumn()),
      ),
    );
  }

  Widget buildColumn() => Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Push the down button to take a photo, upload it and...'.i18n,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center),
        Text('Freak out with the advanced facial recognition!'.i18n,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center),
        CheckboxWidget(),
        ButtonWidget(),
      ],),
  );
}

class LinkedLabelCheckbox extends StatelessWidget {
  const LinkedLabelCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Checkbox(
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchPrivacyURL(context);
                  },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchPrivacyURL(BuildContext context) async {
    const url = 'https://imagga.com/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showAlertDialog(context, "Url couldn't be opened: ".i18n + url, 1);
    }
  }
}

class CheckboxWidget extends StatefulWidget {
  CheckboxWidget({Key key}) : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  static bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return LinkedLabelCheckbox(
      label: 'I have read and accept the Privacy Policy'.i18n,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      },
    );
  }
}

class ButtonWidget extends StatelessWidget {
  ButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ButtonTheme(
            minWidth: 300.0,
            height: 200.0,
            child: RaisedButton(
              shape: CircleBorder(side: BorderSide(color: Colors.blue)),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                doPhoto(context);
              },
              child: Text('Surprise me!'.i18n, style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  doPhoto(BuildContext context) async {
    if (!_CheckboxWidgetState._isSelected) {
      showAlertDialog(context, "You must accept our Privacy Policy.".i18n, 1);
    } else if (!(await Permission.camera.request().isGranted)) {
      showAlertDialog(context, "Camera permissions are needed.".i18n, 1);
    } else if (!(await DataConnectionChecker().hasConnection)) {
      showAlertDialog(context, "You must be connected to Internet.".i18n, 1);
    } else {
      WidgetsFlutterBinding.ensureInitialized();

      final cameras = await availableCameras();

      final firstCamera = cameras.first;

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(camera: firstCamera)),
      );
    }
  }
}
