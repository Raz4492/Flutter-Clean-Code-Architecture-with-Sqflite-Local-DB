
abstract class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {}

class UserError extends UserState {
  final String errorMessage;

  UserError(this.errorMessage);
}

class UserSyncStatusChanged extends UserState {
  final bool isSynced;

  UserSyncStatusChanged(this.isSynced);
}
