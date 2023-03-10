import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:my_app/pages/home/home_page.dart';


class Main_screen extends StatefulWidget{
  const Main_screen({super.key});

  @override
  State<Main_screen> createState ()=> _Main_screen();
}

class _Main_screen extends State<Main_screen>{
  int _currentIndex = 0;
  List<Widget> _pageList = [];
  
  @override
  void initState(){
    appInit();
    super.initState();
  }

  void appInit(){
    _pageList = [HomePage()];
  }

  @override
  Widget build(BuildContext context){
    return Text('data');
  }
}