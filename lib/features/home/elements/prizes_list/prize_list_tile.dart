import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/core/models/prize.dart';
import 'package:intensivevr_pub/features/user_data/bloc/bloc.dart';
import 'package:palette_generator/palette_generator.dart';

import 'bloc/prize_bloc.dart';

class PrizeListTile extends StatefulWidget {
  final Prize prize;

  static Color activeColorButton = Colors.green; // color palette
  static Color inactiveColorButton = Colors.grey[700]; // color palette
  static Color activeColorBackground = Colors.blue;
  static Color inactiveColorBackground = Colors.blueGrey;

  const PrizeListTile({Key key, this.prize}) : super(key: key);

  @override
  _PrizeListTileState createState() => _PrizeListTileState();
}

class _PrizeListTileState extends State<PrizeListTile> {
  bool active = false;
  bool loaded = false;
  Color backgroundColor;
  Color textColor;
  PaletteGenerator paletteGenerator;
  PrizeBloc prizeBloc;

  @override
  void initState() {
    prizeBloc = BlocProvider.of<PrizeBloc>(context);
    getColors();
    super.initState();
  }

  void getColors() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.prize.thumbnail),
    );
    if (paletteGenerator.lightMutedColor != null) {
      backgroundColor = paletteGenerator.lightMutedColor.color;
      textColor = paletteGenerator.lightMutedColor.bodyTextColor;
    } else {
      backgroundColor = Colors.grey[200];
      textColor = Colors.black;
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  void dispose() {
    prizeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
        color: loaded
            ? backgroundColor
            : active
                ? PrizeListTile.activeColorBackground
                : PrizeListTile.inactiveColorBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            bottomSheet(context);
          },
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Text(
                  widget.prize.name,
                  style: TextStyle(color: loaded ? textColor : Colors.black),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image(
                    image: NetworkImage(widget.prize.thumbnail),
                    height: 100,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void bottomSheet(context) {
    showBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: loaded
                    ? backgroundColor
                    : active
                        ? PrizeListTile.activeColorBackground
                        : PrizeListTile.inactiveColorBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.prize.name),
                  Image(
                    image: NetworkImage(widget.prize.picture),
                    height: 230,
                  ),
                  Text("koszt: " + widget.prize.cost.toString() + " punktów"),
                  BlocConsumer<PrizeBloc, PrizeState>(
                    listener: (context, state) {
                      if (state is PrizeCollected) {
                        BlocProvider.of<UserDataBloc>(context)
                            .add(RefreshPointsAndRewards());
                      }
                    },
                    cubit: prizeBloc,
                    builder: (BuildContext context, state) {
                      return BlocBuilder<UserDataBloc, UserDataState>(
                        builder: (context, state) {
                          if (!state.isDemoUser) {
                            return RaisedButton(
                              onPressed: () =>
                                  prizeBloc.add(CollectPrizeButtonPressed()),
                              child: state is InitialPrizeState
                                  ? Text(
                                      "Wybierz nagrodę",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : state is LoadingPrizeRealization
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : state is PrizeCollectionError
                                          ? Text(
                                              "Error",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          : Text(
                                              "Wybierz nagrodę",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                            );
                          } else {
                            return Container(
                              width: 250,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.green),
                              child: Center(
                                child: Text(
                                  "Tutaj będziesz mógł odebrać nagrodę",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                  if (widget.prize.isLimited)
                    Text("Nagroda dostępna do: " +
                        formatDate(widget.prize.deadline))
                  else
                    Text("Nagroda dostępna zawsze"),
                ],
              ));
        });
  }
}

String formatDate(DateTime date) {
  if (date != null) return date.month.toString() + '.' + date.day.toString();
  return "XX.XX";
}
//WelcomeButton(
//                         onPress: () => BlocProvider.of<PrizeBloc>(context)
//                             .add(CollectPrizeButtonPressed()),
//                         border: Border.all(),
//                         padding: EdgeInsets.all(16),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         color: active
//                             ? PrizeListTile.activeColorButton
//                             : PrizeListTile.inactiveColorButton,
//                         splashColor: Colors.purple,
//                         text: Text(
//                           "Wybierz nagrodę",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       );
