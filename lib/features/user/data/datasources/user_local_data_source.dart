import 'package:cleanarchitecture/core/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';

class UserLocalDataSource {
  final Database database;

  UserLocalDataSource(this.database);

  /// Initializes the local database by creating the `users` table if it doesn't exist.
  Future<void> initDatabase() async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS ${Constants.usersTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        birth_date TEXT,
        userName TEXT UNIQUE NOT NULL,
        is_Active TEXT,
        sync_status TEXT NOT NULL DEFAULT 'pending'
      )
    ''');
  }

  /// Fetches all users from the local database.
  Future<List<UserModel>> getAllUsers() async {
    final maps = await database.query(Constants.usersTable);
    return maps.map((e) => UserModel.fromJson(e)).toList();
  }

  /// Fetches a user by their ID from the local database.
  Future<UserModel?> getUserById(int id) async {
    final maps = await database.query(
      Constants.usersTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null; // Returns null if no user is found.
  }

  /// Fetches a user by their `userName` from the local database.
  Future<UserModel?> getUserByUserName(String userName) async {
    final maps = await database.query(
      Constants.usersTable,
      where: 'userName = ?',
      whereArgs: [userName],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null; // Returns null if no user is found.
  }

  /// Inserts a new user into the local database based on `userName`.
  Future<void> createUser(UserModel user) async {
      print("Inserting user: ${user.userName}");

    final result =await database.insert(
      Constants.usersTable,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Ensures unique `userName`
    );
      print("Insert result: $result"); // Log the result to ensure insertion.

  }

  /// Updates a user's data in the local database using `userName`.
  Future<void> updateUser(UserModel user) async {
    await database.update(
      Constants.usersTable,
      user.toJson(),
      where: 'userName = ?',
      whereArgs: [user.userName],
    );
  }

  /// Deletes a user from the local database using `userName`.
  Future<void> deleteUser(String userName) async {
    await database.delete(
      Constants.usersTable,
      where: 'userName = ?',
      whereArgs: [userName],
    );
  }

  /// Marks a user as pending sync in the local database using `userName`.
  Future<void> markUserPendingSync(String userName) async {
    await database.update(
      Constants.usersTable,
      {'sync_status': 'pending'},
      where: 'userName = ?',
      whereArgs: [userName],
    );
  }

  /// Fetches all users marked as pending sync.
  Future<List<UserModel>> getPendingSyncUsers() async {
    final maps = await database.query(
      Constants.usersTable,
      where: 'sync_status = ?',
      whereArgs: ['pending'],
    );
    return maps.map((e) => UserModel.fromJson(e)).toList();
  }

  /// Marks a user as synced in the local database using `userName`.
  Future<void> markUserSynced(String userName) async {
    await database.update(
      Constants.usersTable,
      {'sync_status': 'synced'},
      where: 'userName = ?',
      whereArgs: [userName],
    );
  }
}
