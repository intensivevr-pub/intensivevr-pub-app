import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/core/models/models.dart';
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ListError) {
          return Center(
            child: Text('lists.list_load_error'
                .tr(namedArgs: {'name': 'lists.products'.tr()})),
          );
        }
        if (state is ListLoaded) {
          if (state.items.isEmpty) {
            return Center(
              child: Text('lists.empty_list'
                  .tr(namedArgs: {'name': 'lists.products'.tr()})),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (index >= state.items.length) {
                return BottomLoader();
              } else {
                return ProductsListTile(
                  product: state.items[index] as Product,
                );
              }
            },
            itemCount: state.hasReachedMax
                ? state.items.length
                : state.items.length + 1,
            controller: _mainScrollController,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
