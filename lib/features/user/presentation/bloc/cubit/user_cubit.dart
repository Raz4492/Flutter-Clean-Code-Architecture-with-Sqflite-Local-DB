import 'package:cleanarchitecture/core/Dependencies/setupDependencies.dart';
import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
import 'package:cleanarchitecture/features/user/domain/usecases/get_all_users.dart';
import 'package:cleanarchitecture/features/user/domain/usecases/create_user.dart';
import 'package:cleanarchitecture/features/user/domain/usecases/delete_user.dart';
import 'package:cleanarchitecture/features/user/domain/usecases/sync_users.dart';
import 'package:cleanarchitecture/core/utils/network_info.dart';
import 'package:cleanarchitecture/features/user/domain/usecases/update_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
   final GetAllUsers getAllUsersUseCase = getIt<GetAllUsers>();
  final CreateUser createUserUseCase = getIt<CreateUser>();
  final DeleteUser deleteUserUseCase = getIt<DeleteUser>();
  final UpdateUser updateUserUseCase=getIt<UpdateUser>();
  final SyncUsers syncUsersUseCase = getIt<SyncUsers>();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();

  UserCubit() : super(UserLoading());

  List<UserModel> _users = [];  // Internal list to store users
  bool _isLoading = false;  // Track loading state
  String? _errorMessage;    // Track error message
  bool _isSynced = false;   // Track sync state (whether the data is synced)


  // Getters for accessing the data
  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSynced => _isSynced; // Getter for sync state

  // Helper methods to manage loading and error states
  void _setLoading(bool value) {
    _isLoading = value;
    if (_isLoading) {
      emit(UserLoading()); // Emit loading state when starting to load
    }
  }

  void _setError(String message) {
    _errorMessage = message;
    emit(UserError(_errorMessage!)); // Emit error state with message
  }

  void _setSyncStatus(bool value) {
    _isSynced = value;  // Set sync status
    emit(UserSyncStatusChanged(value));  // Emit sync status change
  }
Future<void> logDatabasePath() async {
  final dbPath = await getDatabasePath('app.db');
  print("Database Path: $dbPath");
}
  // Load all users
  Future<void> loadUsers() async {
    _setLoading(true);  // Set loading state to true
    //var path=logDatabasePath();
    //print(path.toString());
    final result = await getAllUsersUseCase();
    result.fold(
      (failure) {
        _setError('Failed to load users.');  // Set error state
      },
      (users) {
        _users = users;  // Store the users in the internal list
        emit(UserLoaded());  // Emit loaded state
        _setLoading(false);  // Set loading state to false
      },
    );
  }

  // Create a new user and save locally
  Future<void> createUser(UserModel user) async {
    print(user.toString());
    _setLoading(true);  // Set loading state to true
    final result = await createUserUseCase(user);
    result.fold(
      (failure) {
        _setError('Failed to create user.');  // Set error state
      },
      (_) {
        loadUsers();  // Reload the list after creating a user
      },
    );
    _setLoading(false);  // Set loading state to false
  }

// Inside UserCubit

// Update an existing user
Future<void> updateUser(UserModel user) async {
  _setLoading(true);  // Set loading state to true
  final result = await updateUserUseCase(user);  // Use the updateUserUseCase
  result.fold(
    (failure) {
      _setError('Failed to update user.');  // Set error state
    },
    (_) {
      loadUsers();  // Reload the list after updating a user
    },
  );
  _setLoading(false);  // Set loading state to false
}

  // Delete a user
  Future<void> deleteUser(String userId) async {
    _setLoading(true);  // Set loading state to true
    final result = await deleteUserUseCase(userId);
    result.fold(
      (failure) {
        _setError('Failed to delete user.');  // Set error state
      },
      (_) {
        loadUsers();  // Reload the list after deleting a user
      },
    );
    _setLoading(false);  // Set loading state to false
  }

  // Sync local data with the remote server
  Future<void> syncUsers() async {
    _setLoading(true);  // Set loading state to true
    final result = await syncUsersUseCase();
    result.fold(
      (failure) {
        _setError('Failed to sync users.');  // Set error state
        _setSyncStatus(false);  // Set sync status to false on failure
      },
      (_) {
        loadUsers();  // Reload users after syncing
        _setSyncStatus(true);  // Set sync status to true on success
      },
    );
    _setLoading(false);  // Set loading state to false
  }
}
