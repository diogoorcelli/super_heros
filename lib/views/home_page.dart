import 'dart:math';
import 'package:flutter/material.dart';
import 'package:heros/components/slide_tile.dart';
import 'package:heros/services/remote_services.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget{

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RemoteService _remoteService = new RemoteService();

  final PageController _pageController = PageController(viewportFraction: 0.8);

  String _urlAll = 'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json';

  List heroList;
  String hintMessage = '';
  String searchString = '';
  bool isSearch = false;
  int typeSearch = 1;
  int selectedIndex;
  int currentPage = 0;
  int itemCount;
  int randomHero;

  List<IconData> data = [
    Icons.all_inclusive_rounded,
    Icons.group_rounded,
    Icons.male_rounded,
    Icons.female_rounded,
    Icons.person_off
  ];

  List<String> hints = [
    'Personagens aleatórios',
    'Todos os personagens',
    'Personagens masculinos',
    'Personagens femininos',
    'Personagens indefinidos',
    'Pesquisar por nome',
    'Carregando...'
  ];

  void randomNumberHero() {
    Random random = new Random();
    setState(() => randomHero = random.nextInt(itemCount)+1);
  }

  @override
  void initState(){
    _pageController.addListener(() {
      int next = _pageController.page.round();
      if(currentPage != next){
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: !isSearch
            ? Text(hints[1])
            : TextField(
          style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,),
                hintText: hints[5]
            ),
            onChanged: (value) {
              setState(() {
                searchString = value;
              });
            }
        ),

        actions: <Widget> [
          isSearch
              ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () => setState(() {
              this.typeSearch = 1;
              this.isSearch = false;
            }),
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: () => setState(() {
              this.isSearch = true;
            }),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget> [
             Expanded(
               child: FutureBuilder<List>(
                 future: _remoteService.getHeros(_urlAll),
                 builder: (context, snapshot){
                   if(snapshot.data == null){
                     return Container(
                       child: Center(
                         child: Text(hints[6]),
                       ),
                     );
                   } else {
                     switch (typeSearch){
                       case 1:
                         heroList = snapshot.data.toList();
                         break;
                       case 2:
                         heroList = snapshot.data.where((i) => i.appearance.gender == 'Male').toList();
                         break;
                       case 3:
                         heroList = snapshot.data.where((i) => i.appearance.gender == 'Female').toList();
                         break;
                       case 4:
                         heroList = snapshot.data.where((i) => i.appearance.gender == '-').toList();
                         break;
                     }
                     if(isSearch==true){
                       heroList = snapshot.data.where((i) => i.name.toLowerCase().contains(searchString.toLowerCase())).toList();
                     }
                     itemCount = heroList.length;
                     return PageView.builder(
                         itemCount: itemCount,
                         controller: _pageController,
                         itemBuilder: (BuildContext context, int currentIndex) {
                           bool _activePage = currentIndex == currentPage;
                           return SlideTile(
                             id: heroList[currentIndex].id,
                             nome: heroList[currentIndex].name,
                             imagem: heroList[currentIndex].images.md,
                             activePage: _activePage,
                           );
                         }
                     );
                   }
                 },
               ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
          child: Container(
            height: 70,
            width: double.infinity,
            child: ListView.builder(
                itemCount: data.length,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      hintMessage = hints[i];
                      isSearch = false;
                      selectedIndex = i;
                      typeSearch = selectedIndex;
                      showToast(hintMessage.toString(), duration: Toast.LENGTH_LONG);
                      if(typeSearch==0) {
                        randomNumberHero();
                        _pageController.jumpToPage(randomHero);
                        currentPage = randomHero;
                        hintMessage = hints[0];
                      }
                    }),
                    child: AnimatedContainer(
                      duration: Duration(
                        milliseconds: 250
                      ),
                      width: 35,
                      decoration: BoxDecoration(
                        border: i == selectedIndex ? Border(top: BorderSide(
                              width: 3.0, color: Colors.white))
                        :null,
                      gradient: i == selectedIndex ? LinearGradient(
                        colors: [
                          Colors.grey.shade800,
                          Colors.blue
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)
                      :null),
                      child: Icon(
                        data[i],
                        size: 35,
                        color: i == selectedIndex
                        ? Colors.white
                        : Colors.grey.shade800,
                      ),
                    ),
                  ),
                ),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
    );
  }
}