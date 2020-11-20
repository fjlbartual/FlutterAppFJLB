import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ipm_p2/config/app_config.dart';
import 'package:ipm_p2/widgets/main_screen.dart';
import 'package:ipm_p2/widgets/face_data.dart';
import 'package:ipm_p2/widgets/master_and_detail_screen.dart';


class MasterDetailBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          int breakPoint = AppConfig.of(context).breakPoint;
          bool chooseMasterAndDetail = constraints.smallest.longestSide > breakPoint &&
              MediaQuery.of(context).orientation == Orientation.landscape;
          return chooseMasterAndDetail ? MasterAndDetailScreen() : MainScreen();
        }
    );
  }
}

class MasterDetailFaces extends StatelessWidget {
  final String imagePath;

  MasterDetailFaces({this.imagePath}) : super(key: ValueKey(imagePath));



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          int breakPoint = AppConfig.of(context).breakPoint;
          bool chooseMasterAndDetail = constraints.smallest.longestSide > breakPoint &&
              MediaQuery.of(context).orientation == Orientation.landscape;
          return chooseMasterAndDetail ? MasterAndDetailScreenFaces(imagePath: imagePath) : FaceData(imagePath: imagePath);
        }
    );
  }
}
