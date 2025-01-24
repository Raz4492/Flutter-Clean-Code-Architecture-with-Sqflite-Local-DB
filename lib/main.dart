import 'package:cleanarchitecture/core/Dependencies/setupDependencies.dart';
import 'package:cleanarchitecture/features/user/data/datasources/user_local_data_source.dart';
import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sqflite/sqflite.dart';
import 'features/user/presentation/screens/user_screen.dart';

Future<void> insertExampleData(UserLocalDataSource userLocalDataSource) async {
  // Example user data
  final exampleUsers = [
    UserModel(
     
      name: 'taj',
      email: 'john.doe@example.com',
      birthDate: '1990-01-01',
      userName: 'johndoe',
      isActive: 'true',
      syncStatus: 'pending',
    ),
    UserModel(
    
      name: 'raz',
      email: 'jane.doe@example.com',
      birthDate: '1992-05-10',
      userName: 'janedoe',
      isActive: 'true',
      syncStatus: 'pending',
    ),
  ];

  // Insert each user into the database
  for (var user in exampleUsers) {
    await userLocalDataSource.createUser(user);
  }

  print('Example users inserted.');
}
Future<void> resetDatabase(Database database) async {
  await database.execute('DROP TABLE IF EXISTS users');
  await database.execute('''
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL,
      birth_date TEXT,
      userName TEXT UNIQUE NOT NULL,
      is_active TEXT,
      sync_status TEXT NOT NULL DEFAULT 'pending'
    )
  ''');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies(); // Ensure dependencies are set up

  // Get the database and userLocalDataSource from GetIt
  //final database = getIt<Database>();
  //await resetDatabase(database); // Reset for development only

  final userLocalDataSource = getIt<UserLocalDataSource>();
  await userLocalDataSource.initDatabase();
  //await insertExampleData(userLocalDataSource); // Insert example data

  // Log table data
  await logUsersTableData();
  
  runApp(
    MyApp(),
    // BlocProvider(
    //   create: (_) => getIt<UserCubit>(), // Provide the UserCubit here
     //  child: const MyApp(),
    // ),
  );
}
  

Future<void> logUsersTableData() async {
  final dbPath = await getDatabasesPath();
  final db = await openDatabase('$dbPath/app.db');

  // Log all tables
  final tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
  print('Tables in the database: $tables');

  // Query data from the "users" table
  final usersData = await db.rawQuery('SELECT * FROM users');
  print('Data in the users table: $usersData');
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  UserScreen(),
    );
  }
}
