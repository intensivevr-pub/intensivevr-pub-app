import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/features/home/elements/discounts_list/discounts_list.dart';
import 'package:intensivevr_pub/features/home/elements/events_list/event_list_tile.dart';
import 'package:intensivevr_pub/features/home/elements/games_list/game_list_tile.dart';
import 'package:intensivevr_pub/features/home/elements/generic_list/bloc/bloc.dart';
import 'package:intensivevr_pub/features/home/elements/prizes_list/prize_list_tile.dart';

enum PanelType { prize, event, game, discounts }

class GenericPanel extends StatefulWidget {
  final String title;
  final Color color;
  final PanelType type;

  const GenericPanel({Key key, this.title, this.color, this.type})
      : super(key: key);

  @override
  _GenericPanelState createState() => _GenericPanelState();
}

class _GenericPanelState extends State<GenericPanel> {
  GenericListBloc _elementsListBloc;
  final _mainScrollController = ScrollController();

  @override
  void initState() {
    _elementsListBloc = BlocProvider.of<GenericListBloc>(context);

    _mainScrollController.addListener(_onMainScroll);
    super.initState();
  }

  void _onMainScroll() {
    if (_mainScrollController.offset >=
            _mainScrollController.position.maxScrollExtent &&
        !_mainScrollController.position.outOfRange) {
      _elementsListBloc.add(ReachedBottomOfList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [widget.color, widget.color.withAlpha(0)],
          stops: [.35, 1],
        )),
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 200,
              child: BlocBuilder<GenericListBloc, GenericListState>(
                builder: (BuildContext context, GenericListState state) {
                  if (state is InitialListState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ListError) {
                    return Center(
                      child: Text("Nie można wczytać czegoś"),
                    );
                  }
                  if (state is ListLoaded) {
                    if (state.items.isEmpty) {
                      return Center(
                        child: Text('Brak czegoś'),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= state.items.length) {
                          return SideLoader();
                        } else {
                          var item = state.items[index];
                          switch (widget.type) {
                            case PanelType.prize:
                              return PrizeListTile(prize: item);
                            case PanelType.event:
                              return EventListTile(event: item);
                            case PanelType.game:
                              return GameListTile(game: item);
                            case PanelType.discounts:
                              return DiscountListTile(discount: item);
                            default:
                              return Container(color: Colors.red,);
                          }
                        }
                      },
                      itemCount: state.hasReachedMax
                          ? state.items.length
                          : state.items.length + 1,
                      controller: _mainScrollController,
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SideLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
