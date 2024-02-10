import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'end_checkin_page.dart';

class EndCheckinRouter extends FlutterGetItPageRouter {
  const EndCheckinRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [];

  @override
  String get routeName => '/end-checkin';

  @override
  WidgetBuilder get view => (context) => const EndCheckinPage();
}
