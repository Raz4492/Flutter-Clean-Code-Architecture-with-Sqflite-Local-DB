import 'package:cleanarchitecture/core/utils/ConversionHelper.dart';
import 'package:cleanarchitecture/features/user/domain/entities/user.dart';

class UserModel extends User {
   UserModel({
    super.syncStatus,
    required super.name,
    required super.email,
    required super.birthDate,
    required super.userName,
    required super.isActive,
  });

  // Factory constructor to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: ConversionHelper.convertToString(json['name']),
      email: ConversionHelper.convertToString(json['email']),
      birthDate: ConversionHelper.convertToString(json['birth_date']),
      userName: ConversionHelper.convertToString(json['userName']),
      isActive: ConversionHelper.convertToString(json['is_active']),
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'birth_date': ConversionHelper.convertToDateTime(birthDate)?.toIso8601String() ?? '',
      'userName': userName,
      'is_active': isActive,
    };
  }
}
