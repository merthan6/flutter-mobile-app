import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newapp/pages/login.dart';
import 'package:newapp/pages/memberpage.dart';
import 'package:newapp/pages/register.dart';
import 'package:newapp/pages/Home.dart';
import 'package:newapp/pages/pairs.dart';
import 'package:newapp/pages/profile.dart';
void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
        '/': (BuildContext context) => LoginPage(),
        '/memberpage': (BuildContext context) => MemberPage(),
        '/register': (BuildContext context) => Register(),
        '/home': (BuildContext context) => Home(),
        '/pairs': (BuildContext context) => Pairs(),
        '/profile': (BuildContext context) => ProfilePage(),
      },
  )
);
