import 'package:cleanarchitecture/features/user/presentation/getx/controller/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
import 'package:cleanarchitecture/features/user/presentation/screens/UserForm.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController()); // Initialize the controller

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: userController.syncUsers, // Sync users with the server
          ),
        ],
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userController.errorMessage.isNotEmpty) {
          return Center(child: Text(userController.errorMessage.value));
        }

        if (userController.users.isEmpty) {
          return const Center(child: Text('No users available.'));
        }

        return ListView.builder(
          itemCount: userController.users.length,
          itemBuilder: (context, index) {
            final user = userController.users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditUserForm(context, user),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => userController.deleteUser(user.userName),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditUserForm(BuildContext context, UserModel user) {
    showModalBottomSheet(
      context: context,
      builder: (_) => UserForm(user: user),
    );
  }

  void _showUserForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const UserForm(),
    );
  }
}


// import 'package:cleanarchitecture/core/Dependencies/setupDependencies.dart';
// import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
// import 'package:cleanarchitecture/features/user/presentation/bloc/cubit/user_cubit.dart';
// import 'package:cleanarchitecture/features/user/presentation/bloc/cubit/user_state.dart';
// import 'package:cleanarchitecture/features/user/presentation/screens/UserForm.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UserScreen extends StatelessWidget {
//   const UserScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = getIt<UserCubit>();
//     //cubit.loadUsers();
//     print("object"); // Access the UserCubit from get_it
//     print(cubit.toString());
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Users'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.sync),
//             onPressed: () {
//               cubit.syncUsers(); // Sync users with the server
//             },
//           ),
//         ],
//       ),
//       body: BlocProvider(
//         create: (context) => cubit..loadUsers(), // Load users when screen is built
//         child: BlocBuilder<UserCubit, UserState>(
//           builder: (context, state) {
//             if (state is UserLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is UserError) {
//               return Center(child: Text(state.errorMessage));
//             } else if (state is UserLoaded) {
//               if (cubit.users.isEmpty) {
//                 return const Center(child: Text('No users available.'));
//               }

//               return ListView.builder(
//                 itemCount: cubit.users.length,
//                 itemBuilder: (context, index) {
//                   final user = cubit.users[index];
//                   return ListTile(
//                     title: Text(user.name),
//                     subtitle: Text(user.email),
//                     trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               _showEditUserForm(context, user);  // Open the edit form
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: () {
//               cubit.deleteUser(user.userName);  // Delete user
//             },
//           ),
//         ],
//       ),
//                   );
//                 },
//               );
//             } else if (state is UserSyncStatusChanged) {
//               if (state.isSynced) {
//                 return const Center(child: Text('Data is synced!'));
//               } else {
//                 return const Center(child: Text('Data sync failed.'));
//               }
//             }

//             return const Center(child: Text('No users available.'));
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showUserForm(context), // Show the user creation form
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// // Inside UserScreen

// // Show the edit user form in a bottom sheet
// void _showEditUserForm(BuildContext context, UserModel user) {
//   showModalBottomSheet(
//     context: context,
//     builder: (_) => BlocProvider.value(
//       value: getIt<UserCubit>(), // Provide UserCubit using get_it
//       child: UserForm(user: user),  // Pass the user to the form for editing
//     ),
//   );
// }

//   // Show the user form in a bottom sheet
//   void _showUserForm(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) => BlocProvider.value(
//         value: getIt<UserCubit>(), // Provide UserCubit using get_it
//         child: const UserForm(),
//       ),
//     );
//   }
// }
