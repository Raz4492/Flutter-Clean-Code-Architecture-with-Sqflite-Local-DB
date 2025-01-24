// import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
// import 'package:cleanarchitecture/features/user/presentation/bloc/cubit/user_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UserForm extends StatefulWidget {
//   final UserModel? user; // Pass the user for editing, or null for creating

//   const UserForm({super.key, this.user});

//   @override
//   _UserFormState createState() => _UserFormState();
// }

// class _UserFormState extends State<UserForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _userNameController = TextEditingController();
//   final _birthDateController = TextEditingController();
//   bool _isActive = true;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.user != null) {
//       // Populate the form fields if the user is being edited
//       _nameController.text = widget.user!.name;
//       _emailController.text = widget.user!.email;
//       _userNameController.text = widget.user!.userName;
//       _birthDateController.text = widget.user!.birthDate;
//       _isActive = widget.user!.isActive == 'true'; // Assuming isActive is a string
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<UserCubit>();

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a name';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _userNameController,
//               decoration: const InputDecoration(labelText: 'User Name'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a user name';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter an email';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _birthDateController,
//               decoration: const InputDecoration(labelText: 'Birth Date (dd-mm-yyyy)'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a birth date';
//                 }
//                 return null;
//               },
//             ),
//             // Switch widget for 'isActive' field
//             Row(
//               children: [
//                 const Text('Is Active'),
//                 Switch(
//                   value: _isActive,
//                   onChanged: (value) {
//                     setState(() {
//                       _isActive = value;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState?.validate() ?? false) {
//                   final user = UserModel(
//                     name: _nameController.text,
//                     email: _emailController.text,
//                     birthDate: _birthDateController.text,
//                     userName: _userNameController.text,
//                     syncStatus: 'pending',
//                     isActive: _isActive.toString(), // Convert bool to string
//                   );

//                   if (widget.user != null) {
//                     cubit.updateUser(user); // Update the user if editing
//                   } else {
//                     cubit.createUser(user); // Create new user if not editing
//                   }

//                   Navigator.of(context).pop(); // Close the bottom sheet
//                 }
//               },
//               child: Text(widget.user != null ? 'Update User' : 'Create User'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cleanarchitecture/features/user/presentation/getx/controller/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cleanarchitecture/features/user/data/models/user_model.dart';

class UserForm extends StatefulWidget {
  final UserModel? user; // Pass the user for editing, or null for creating

  const UserForm({Key? key, this.user}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  bool _isActive = true;

  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      // Populate the form fields if editing a user
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
      _userNameController.text = widget.user!.userName;
      _birthDateController.text = widget.user!.birthDate;
      _isActive =
          widget.user!.isActive == 'true'; // Assuming `isActive` is a string
    }
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    _nameController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _handleFormSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final user = UserModel(
        name: _nameController.text,
        email: _emailController.text,
        birthDate: _birthDateController.text,
        userName: _userNameController.text,
        syncStatus: 'pending',
        isActive: _isActive.toString(),
      );

      if (widget.user != null) {
        // Update existing user
        userController.updateUser(user);
      } else {
        // Create a new user
        userController.createUser(user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: 'User Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a user name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _birthDateController,
              decoration:
                  const InputDecoration(labelText: 'Birth Date (dd-mm-yyyy)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a birth date';
                }
                return null;
              },
            ),
            Row(
              children: [
                const Text('Is Active'),
                Switch(
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Obx(() {
              return userController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _handleFormSubmit,
                      child: Text(
                          widget.user != null ? 'Update User' : 'Create User'),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
