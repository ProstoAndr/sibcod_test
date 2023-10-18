sealed class ProfileState {}

class Initial extends ProfileState {}

class Content extends ProfileState {
  final String? phoneNumber;

  Content(this.phoneNumber);
}

class Delete extends ProfileState {}