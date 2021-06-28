import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heros/services/remote_services.dart';

class DetailPage extends StatefulWidget {
  String idHero;

  DetailPage(this.idHero);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  RemoteService _remoteService = new RemoteService();
  var urlIdHero;
  var imgHero;
  String nameHero = 'Nome';
  String genderHero = 'gênero';
  String heightHero = 'altura';
  String weightHero = 'peso';
  String raceHero = 'raça';
  int power = 0;
  int intelig = 0;
  int strength = 0;
  int velocidade = 0;
  int resistencia = 0;
  int combate = 0;

  final nameHeroTextStyle = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 20,
    height: 1,
  );

  final descHeroTextStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.w600,
    fontFamily: 'Arial Black',
    letterSpacing: 0.5,
    fontSize: 20,
    height: 1,
  );

  final descDefaultTextStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.w600,
    fontFamily: 'Arial',
    letterSpacing: 0.5,
    fontSize: 14,
    height: 1,
  );


  Future<Map> searchDetails(String url) async {
    final json = await _remoteService.getDetailHero(url);
    setState(() {
      nameHero = json['name'];
      genderHero = json['appearance']['gender'];
      heightHero = json['appearance']['height'][1];
      weightHero = json['appearance']['weight'][1];
      raceHero = json['appearance']['race'];
      imgHero = json['images']['sm'];
      power = json['powerstats']['power'].toInt();
      intelig = json['powerstats']['intelligence'].toInt();
      strength = json['powerstats']['strength'].toInt();
      velocidade = json['powerstats']['speed'].toInt();
      resistencia = json['powerstats']['durability'].toInt();
      combate = json['powerstats']['combat'].toInt();
    });
  }

  @override
  void initState() {
    urlIdHero = 'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/id/${widget.idHero}.json';
    setState(() {
      searchDetails(urlIdHero);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Detalhes do personagem'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                  width: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.4,
                  width: MediaQuery.of(context).size.height / 1.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: (
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(nameHero.toString(),
                                  style: nameHeroTextStyle,
                                ),
                              ),
                              Divider(color: Colors.blue),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text('Aparência', style: descHeroTextStyle),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('Gênero:',style: descDefaultTextStyle,),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(genderHero.toString()),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Raça:',style: descDefaultTextStyle,),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(raceHero.toString()),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text('Altura:',style: descDefaultTextStyle,),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(heightHero.toString()),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text('Peso:',style: descDefaultTextStyle,),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(weightHero.toString()),
                                        ],
                                      ),
                                    ]
                                  ),
                                  Divider(color: Colors.blue),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                                        child: Text('Status', style: descHeroTextStyle),
                                      ),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text('Inteligência:',style: descDefaultTextStyle,),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(intelig.toString()),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('Poder:',style: descDefaultTextStyle,),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(power.toString()),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('Força:',style: descDefaultTextStyle,),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(strength.toString()),
                                              ],
                                            ),
                                          ]
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                                          ),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text('Veloc.:',style: descDefaultTextStyle,),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(velocidade.toString()),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text('Resistência:',style: descDefaultTextStyle,),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(resistencia.toString()),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text('Combate:',style: descDefaultTextStyle,),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(combate.toString()),
                                                  ],
                                                ),
                                              ]
                                          ),
                                          Divider(color: Colors.blue),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 4 ,
                  width: MediaQuery.of(context).size.height / 4 ,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 25.0,
                        spreadRadius: 0.1,
                      )
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      placeholder: (context,url) => CircularProgressIndicator(),
                      errorWidget: (context,url,error) => Icon(Icons.person),
                      imageUrl: imgHero,
                      height: 150.0,
                      width: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
  


 