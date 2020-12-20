import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/features/home/elements/generic_list/bloc/bloc.dart';
import 'package:intensivevr_pub/features/products/view/products_list/products_list_tile.dart';

class ProductsList extends StatefulWidget {
  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
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
    return BlocBuilder<GenericListBloc, GenericListState>(
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
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (index >= state.items.length) {
                return BottomLoader();
              } else {
                return ProductsListTile(
                  product: state.items[index],
                );
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
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
