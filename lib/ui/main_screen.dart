import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:my_app/pages/home/home_page.dart';


class BarItemFormt{
  final String lable;
  final IconData icon;
  final Color color;

  BarItemFormt(this.lable, this.icon, this.color);
}

class Main_screen extends StatefulWidget{
  const Main_screen({super.key});

  @override
  State<Main_screen> createState ()=> _Main_screen();
}

class _Main_screen extends State<Main_screen>{
  final _pageControler = PageController();
  int _currentIndex = 0;
  List<Widget> _pageList = [];
  List<BarItemFormt> _itemList = [];


  @override
  void initState(){
    appInit();
    super.initState();
  }

  void appInit(){
    setState(() {
      _pageList = [];
      _pageList.add(const HomePage());
      _pageList.add(const Number("asd"));
      _pageList.add(const Number("q"));

      _itemList = [];
      _itemList.add(BarItemFormt('首頁', Icons.home, Colors.green));
      _itemList.add(BarItemFormt('page1', Icons.pages, Colors.blue));
      _itemList.add(BarItemFormt('page2', Icons.pages, Colors.red));
    });
    _currentIndex = 0;
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: ButtomBar(barItems: _itemList, 
        changeTo: (int index){
          _pageControler.animateToPage(index,duration: Duration(seconds: 1), curve: Curves.linear);
          setState(() {
            _currentIndex = index;
          });
        },
      )
      ,
      body: 
        PageView(
          controller: _pageControler,
          children: _pageList,
      ),
    );
  }
}

class ButtomBar extends StatefulWidget{
  final List<BarItemFormt> barItems;
  final void Function(int index) changeTo;

  const ButtomBar({
    super.key,
    required this.barItems,
    required this.changeTo
  });

  @override
  State<ButtomBar> createState() => _ButtomBarState();
}

class _ButtomBarState extends State<ButtomBar>{
  int selected_index = 0;

  @override
  Widget build(BuildContext context){
    return Material(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildBarItems()),
      ),
    );
  }

  List<Widget> _buildBarItems(){
    List<Widget> itemList = [];
    for (int i = 0; i < widget.barItems.length; i++) {
      BarItemFormt item = widget.barItems[i];
      bool isSelected = selected_index == i;
      itemList.add(_customBarItem(i, isSelected, item));
    }
    return itemList;
  }

  InkWell _customBarItem(int i, bool isSelect, BarItemFormt format){
      return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
            selected_index = i;
            widget.changeTo(i);
        });
      },
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        duration:const Duration(microseconds: 100),
        decoration: BoxDecoration(
            color: isSelect ? format.color.withOpacity(0.15) : Colors.transparent,
            borderRadius:const BorderRadius.all(Radius.circular(30.0))),
        child: Row(
          children: <Widget>[
            Icon(
              format.icon,
              color: isSelect ? format.color : Colors.black,
              size: 32,
            ),
            SizedBox(width: 10.0),
            AnimatedSize(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Text(
                isSelect ? format.lable : "",
                style: TextStyle(
                    color: format.color,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );

  }
}


class Number extends StatelessWidget{
  const Number(this.num, {super.key});

  final String num;
  
  @override
  Widget build(BuildContext context){
    return Center(
      child: Text(num), 
    );
  }

}

