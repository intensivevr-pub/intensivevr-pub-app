import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final bool value;

  const ThemeChanged({@required this.value}) : assert(value != null);

  @override
  List<Object> get props => [value];
}

class ThemeLoadStarted extends ThemeEvent {}
