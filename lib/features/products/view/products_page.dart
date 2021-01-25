import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:intensivevr_pub/features/home/elements/generic_list/bloc/bloc.dart';
import 'package:intensivevr_pub/features/products/view/products_list/products_list.dart';

class ProductsPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => GenericListBloc(
                  method: DataRepository.getProducts,
                  portion: 20,
                )..add(ReachedBottomOfList()),
            child: ProductsPage()));
  }

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
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
    return Scaffold(
      body: ProductsList(),
    );
  }
}
