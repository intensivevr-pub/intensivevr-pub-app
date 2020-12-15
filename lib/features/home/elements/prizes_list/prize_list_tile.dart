import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/core/models/prize.dart';
import 'package:intensivevr_pub/features/user_data/bloc/bloc.dart';

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
  PrizeBloc prizeBloc;

  @override
  void initState() {
    prizeBloc = BlocProvider.of<PrizeBloc>(context);
    super.initState();
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
        color: active
            ? PrizeListTile.activeColorBackground
            : PrizeListTile
                .inactiveColorBackground, //TODO odjebać magię żeby to działało
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
                Text(widget.prize.name),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image(
                    image: NetworkImage(widget.prize.picture),
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
                color: active
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
                      if(state is PrizeCollected){
                        BlocProvider.of<UserDataBloc>(context).add(AddActiveReward());
                      }
                    },
                    cubit: prizeBloc,
                    builder: (BuildContext context, state) {
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
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : Text(
                                        "Odbierz ponownie",
                                        style: TextStyle(color: Colors.black),
                                      ),
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
