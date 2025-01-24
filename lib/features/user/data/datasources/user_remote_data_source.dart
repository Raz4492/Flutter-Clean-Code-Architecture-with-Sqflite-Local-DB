import 'package:cleanarchitecture/core/utils/constants.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/api_client.dart';
import '../models/user_model.dart';

class UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSource(this.apiClient);

  /// Syncs the user data to the remote server.
  Future<Response> syncUser(UserModel user) async {
     final response =await apiClient.post(Constants.usersEndpoint, user.toJson());
      return response;

  }

  /// Retrieves a user by username from the remote server.
  Future<Response> getUserByUserName(String userName) async {
    final response = await apiClient.get('${Constants.usersEndpoint}/$userName');
    return response;
  }

  /// Retrieves a user by ID from the remote server.
  Future<Response> getUserById(String userId) async {
    final response = await apiClient.get('${Constants.usersEndpoint}/$userId');
    return response;
  }
}
