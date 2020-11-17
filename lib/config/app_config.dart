import 'package:flutter/material.dart';
import 'package:ipm_p2/clients/imagga_client.dart';

class AppConfig extends InheritedWidget {
  AppConfig({this.client, this.title, this.breakPoint = 600, child})
      : super(child: child);

  final ImaggaClient client;
  final String title;
  final int breakPoint;

  static AppConfig of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppConfig>();

  @override
  bool updateShouldNotify(AppConfig old) => false;
}
