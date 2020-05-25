import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newapp/pages/login.dart';
import 'package:newapp/pages/memberpage.dart';
import 'package:newapp/pages/register.dart';
import 'package:newapp/pages/Home.dart';
void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/Home',
    routes: {
        '/': (BuildContext context) => LoginPage(),
        '/memberpage': (BuildContext context) => MemberPage(),
        '/register': (BuildContext context) => Register(),
        '/Home': (BuildContext context) => Home(),
      },
  )
);
