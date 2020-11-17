import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ipm_p2/clients/imagga_client.dart';
import 'package:ipm_p2/config/app_config.dart';
import 'package:ipm_p2/locale/localization.i18n.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:ipm_p2/models/models.dart';
import 'package:ipm_p2/widgets/alert_dialog_box.dart';

class FaceData extends StatefulWidget {
  final String imagePath;

  FaceData({this.imagePath}) : super(key: ValueKey(imagePath));

  @override
  _FaceDataState createState() => _FaceDataState();
}

class _FaceDataState extends State<FaceData> {
  Future<List<Faces>> _face;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Faces>>(
      future: _face,
      builder: (BuildContext context, AsyncSnapshot<List<Faces>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return new Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(AppConfig.of(context).title + ': Result'.i18n),
            ),
            body: Center(child: buildColumn(snapshot.data)),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showAlertDialog(context, snapshot.error.toString(), 2);
            });
          }
          return new Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(AppConfig.of(context).title + ': Loading...'.i18n),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                  child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.blue,
                      width: 10,
                    ),
                  ),
                  child: Image.file(File(widget.imagePath),
                      height: 300, width: 300),
                ),
                Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Column(children: [
                    Text(
                      "Creating the magic...".i18n,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    CircularProgressIndicator(),
                  ]),
                ),
              ])),
            ),
          );
        }
      },
    );
  }

  Widget buildColumn(List<Faces> faces) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.blue,
                width: 10,
              ),
            ),
            child: Image.file(File(widget.imagePath), height: 300, width: 300),
          ),
          Expanded(
            child: Container(
              color: Colors.lightBlueAccent,
              child: ListView(
                children: <Widget>[
                  for (int i = 0; i < (faces.length); i++) ...[
                    SizedBox(height: 10),
                    Text('Face Nº '.i18n + (i + 1).toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                    for (int j = 0; j < (faces[i].attributes.length); j++) ...[
                      Text(
                          StringUtils.capitalize(
                                  faces[i].attributes[j].type.i18n) +
                              ': ' +
                              StringUtils.capitalize(
                                  faces[i].attributes[j].label.i18n),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center),
                    ],
                    SizedBox(height: 10),
                    Divider(color: Colors.white60),
                  ]
                ],
              ),
            ),
          ),
        ],
      );

  void _reload() {
    ImaggaClient client = AppConfig.of(context).client;
    setState(() {
      _face = client.loadFaceDataURL(widget.imagePath);
    });
  }
}
