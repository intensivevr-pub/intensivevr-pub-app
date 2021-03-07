import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intensivevr_pub/color_consts.dart';
import 'package:intensivevr_pub/core/models/game.dart';
import 'package:intensivevr_pub/features/leaderboard/leaderboard.dart';

class GamePage extends StatelessWidget {
  final Game game;

  const GamePage({Key key, this.game}) : super(key: key);

  static Route route(Game game) {
    return MaterialPageRoute<void>(
        builder: (_) => GamePage(
              game: game,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPurpleGradientColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            title: Text(
              game.name,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: game.id,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    autoPlayInterval: const Duration(seconds: 12),
                    autoPlay: true,
                  ),
                  items: pictures(),
                ),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: Material(
                      color: Theme.of(context).toggleButtonsTheme.color,
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45)),
                        onTap: () {
                          Navigator.push(context, LeaderboardPage.route(game));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: const Border.fromBorderSide(
                                  BorderSide(width: 0.6)),
                              borderRadius: BorderRadius.circular(45)),
                          width: 200,
                          height: 60,
                          child: Center(
                              child: Text(
                            'leaderboard'.plural(1),
                            style: const TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Image> pictures() {
    final List<Image> out = [];
    for (int i = 0; i < game.pictures.length; i++) {
      out.add(Image(image: NetworkImage(game.pictures[i])));
    }
    return out;
  }

  String formatType() {
    switch (game.type) {
      case GameType.vr:
        return 'game.game'.tr(namedArgs: {'type': 'game.vr'.tr()});
      case GameType.console:
        return 'game.game'.tr(namedArgs: {'type': 'game.console'.tr()});
      case GameType.board:
        return 'game.game'.tr(namedArgs: {'type': 'game.board'.tr()});
      default:
        return 'game.undefined'.tr();
    }
  }
}
