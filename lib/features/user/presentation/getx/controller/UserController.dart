import 'package:cleanarchitecture/core/Dependencies/setupDependencies.dart';
import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
import 'package:cleanarchitecture/features/user/domain/usecases/get_all_users.dart';
import 'package:cleanarchitecture/features/user/domain/usecases/create_user.dart';
import 'package:cleanarchitecture/features/user/domain/usecases/delete_user.dart';
import 'package:cleanarchitecture/features/user/domain/usecases/update_user.dart';
import 'package:cleanarchitecture/features/user/domain/usecases/sync_users.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserController extends GetxController {
  final GetAllUsers _getAllUsers = getIt<GetAllUsers>();
  final CreateUser _createUser = getIt<CreateUser>();
  final DeleteUser _deleteUser = getIt<DeleteUser>();
  final UpdateUser _updateUser = getIt<UpdateUser>();
  final SyncUsers _syncUsers = getIt<SyncUsers>();

  var users = <UserModel>[].obs; // Observable list of users
  var isLoading = false.obs; // Observable loading state
  var errorMessage = ''.obs; // Observable error message
  var isSynced = false.obs; // Observable sync status

  @override
  void onInit() {
    super.onInit();
    loadUsers(); // Automatically load users when the controller is initialized
  }

  Future<void> loadUsers() async {
    isLoading.value = true; // Set loading to true
    final result = await _getAllUsers();
    result.fold(
      (failure) {
        errorMessage.value = 'Failed to load users.';
        isLoading.value = false;
      },
      (data) {
        users.value = data;
        isLoading.value = false;
      },
    );
  }
Future<void> createUser(UserModel user) async {
  isLoading.value = true;
  final result = await _createUser(user);
  result.fold(
    (failure) => errorMessage.value = 'Failed to create user.',
    (_) {
      loadUsers(); // Reload users
      Get.back(); // Close the form after successful creation
    },
  );
  isLoading.value = false;
}

Future<void> updateUser(UserModel user) async {
  isLoading.value = true;
  final result = await _updateUser(user);
  result.fold(
    (failure) => errorMessage.value = 'Failed to update user.',
    (_) {
      loadUsers(); // Reload users
      Get.back(); // Close the form after successful update
    },
  );
  isLoading.value = false;
}


  Future<void> deleteUser(String userId) async {
    isLoading.value = true;
    final result = await _deleteUser(userId);
    result.fold(
      (failure) => errorMessage.value = 'Failed to delete user.',
      (_) => loadUsers(),
    );
    isLoading.value = false;
  }

  Future<void> syncUsers() async {
    isLoading.value = true;
    final result = await _syncUsers();
    result.fold(
      (failure) {
        errorMessage.value = 'Failed to sync users.';
        isSynced.value = false;
      },
      (_) {
        isSynced.value = true;
        loadUsers();
      },
    );
    isLoading.value = false;
  }
}
