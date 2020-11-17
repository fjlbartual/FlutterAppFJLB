// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:ipm_p2/clients/imagga_client.dart';
import 'package:ipm_p2/config/app_config.dart';
import 'package:ipm_p2/widgets/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class IIPhotoFace extends StatelessWidget {
  final ImaggaClient client;
  final String title;

  IIPhotoFace({
    this.title = "iIPhotoFace",
    this.client = const ImaggaClient(),
  });

  @override
  Widget build(BuildContext context) {
    return AppConfig(
      client: client,
      title: title,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', "US"),
          const Locale('es', "ES"),
        ],
        title: 'iIPhotoFace',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}
