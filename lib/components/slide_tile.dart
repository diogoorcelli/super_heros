import 'package:flutter/material.dart';
import 'package:heros/views/details_page.dart';

class SlideTile extends StatefulWidget{

  final bool activePage;
  final int id;
  final String nome;
  final String imagem;

  const SlideTile({Key key, this.imagem, this.activePage, this.nome, this.id}) : super(key: key);

  @override
  _SlideTileState createState() => _SlideTileState();
}

class _SlideTileState extends State<SlideTile> {

  void ShowDetailPage(String idHero){
    setState(() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailPage(idHero)
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final double _top = this.widget.activePage ? 50 : 150;
    final double _blur = this.widget.activePage ? 30 : 0;
    final double _offset = this.widget.activePage ? 20 : 0;

    return AnimatedContainer(
      curve: Curves.easeOutQuint,
      duration: Duration(microseconds: 1500),
      margin: EdgeInsets.only(top: _top, bottom: 80, right: 20),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                      this.widget.imagem,
                    ),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black87,
                        blurRadius: _blur,
                        offset: Offset(_offset,_offset)
                    )
                  ]
              ),
              child: Text(this.widget.nome.toString() ?? Text('Carregando...'),
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ),
            onTap: (){
              ShowDetailPage(this.widget.id.toString());
            },
          )

        ],
      ),
    );
  }
}