import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newapp/pages/login.dart';
import 'package:newapp/pages/memberpage.dart';
import 'package:newapp/pages/register.dart';
void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
        '/': (BuildContext context) => LoginPage(),
        '/memberpage': (BuildContext context) => MemberPage(username: username,),
        '/register': (BuildContext context) => Register(),
      },
  )
);
