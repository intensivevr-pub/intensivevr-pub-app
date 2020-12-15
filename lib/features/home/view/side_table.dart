import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/features/home/elements/elements_list/elements_list.dart';

import 'discount_panel.dart';

enum PanelType { prize, product, event, game, discounts }

class SideTable extends StatefulWidget {
  final String title;
  final Color color;
  final PanelType type;
  const SideTable({Key key, this.title, this.color, this.type}) : super(key: key);

  @override
  _SideTableState createState() => _SideTableState();
}

class _SideTableState extends State<SideTable> {
  ElementsListBloc _elementsListBloc;
  final _mainScrollController = ScrollController();

  @override
  void initState() {
    _elementsListBloc = BlocProvider.of<ElementsListBloc>(context);

    _mainScrollController.addListener(_onMainScroll);
    super.initState();
  }

  void _onMainScroll() {
    if (_mainScrollController.offset >=
        _mainScrollController.position.maxScrollExtent &&
        !_mainScrollController.position.outOfRange) {
      print("loaduje more");
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
          )
        ),
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
              child:  BlocBuilder<ElementsListBloc, ElementsListState>(
                builder: (BuildContext context, ElementsListState state) {
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
                          switch (widget.type) {
                            case PanelType.prize:
                              return ItemWidget();
                            case PanelType.product:
                              return ItemWidget();
                            case PanelType.event:
                              return ItemWidget();
                            case PanelType.game:
                              return ItemWidget();
                            case PanelType.discounts:
                              return DiscountPanel(
                                  discount: state.items[index]);
                            default:
                              return Container();
                          }
                        }
                      },
                      itemCount: state.hasReachedMax ? state.items.length: state.items.length + 1,
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
class ItemWidget extends StatelessWidget { //TODO placeholder do wyrzucenia
  ItemWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("KURWA CHUJ"),
    );
  }
}

class SideLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
