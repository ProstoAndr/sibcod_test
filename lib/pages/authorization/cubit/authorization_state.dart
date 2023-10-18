sealed class AuthorizationState {}

class Initial extends AuthorizationState {}

class Content extends AuthorizationState {
  final String phoneNumber;

  Content(this.phoneNumber);
}