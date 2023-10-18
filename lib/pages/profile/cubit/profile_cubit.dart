import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sibcode_test/pages/profile/cubit/profile_state.dart';
import 'package:sibcode_test/route_names.dart';
import 'package:sibcode_test/storage/shared_preferences_user.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(Initial());

  void loading() async {
    final phoneNumber = await loadPhoneNumber();
    emit(Content(phoneNumber));
  }

  void delete(BuildContext context) {
    resetPhoneNumber();
    context.goNamed(RouteNames.authorization);
  }
}