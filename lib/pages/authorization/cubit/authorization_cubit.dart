import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sibcode_test/pages/authorization/cubit/authorization_state.dart';
import 'package:sibcode_test/route_names.dart';
import 'package:sibcode_test/storage/shared_preferences_user.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit() : super(Initial());

  void authorization(String phoneNumber, BuildContext context) {
    savePhoneNumber(phoneNumber);
    emit(Content(phoneNumber));
    context.goNamed(RouteNames.listNews);
  }
}