import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intensivevr_pub/core/models/game.dart';

class GamePage extends StatelessWidget {
  final Game game;

  const GamePage({Key key, this.game}) : super(key: key);

  static Route route(game) {
    return MaterialPageRoute<void>(
        builder: (_) => GamePage(
              game: game,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(game.name),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlayInterval: Duration(seconds: 12),
                autoPlay: true,
              ) ,
              items: pictures(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(formatType()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(game.description),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () {},   //TODO: link leader boards
                  child: Text("Leaderboards"),
                ),
              ),
            )
          ],
      )),
    );
  }

  List<Image> pictures() {
    List<Image> out = [];
    for (int i = 0; i < game.pictures.length; i++) {
      out.add(Image(image: NetworkImage(game.pictures[i])));
    }
    print(out);
    return out;
  }

  String formatType(){
    switch(game.type) {
      case GameType.vr:
        return "Gra VR";
      case GameType.console:
        return "Gra konsolowa";
      case GameType.board:
        return "Gra planszowa";
      default:
        return "Nie wiadomo co tak na prawdę";
    }
  }
}
