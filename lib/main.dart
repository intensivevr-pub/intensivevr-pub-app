import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:intensivevr_pub/app.dart';

void main() {
  runApp((App(
    authenticationRepository: AuthenticationRepository(),
  )));
}
