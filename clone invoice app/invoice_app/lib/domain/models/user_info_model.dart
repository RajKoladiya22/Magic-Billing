class UserInfoModel {
  int? status;
  bool? success;
  String? message;
  Data? dataModel;

  UserInfoModel({this.dataModel, this.message, this.status, this.success});

  factory UserInfoModel.mapToModel(Map m)
  {
    return UserInfoModel(
      dataModel: Data.mapToModel(m['data']),
      message: m['message'],
      status: m['status'],
      success: m['success']
    );
  }
}

class Data {
  User? userModel;
  Tokens? tokenModel;

  Data({this.tokenModel, this.userModel});

  factory Data.mapToModel(Map m) {
    return Data(
        tokenModel: Tokens.mapToModel(m['tokens']),
        userModel: User.mapToModel(m['user']));
  }
}

class User {
  String? id, firstName, lastName, email, role;
  bool? isActive, isVerified;
  User(
      {this.email,
      this.firstName,
      this.id,
      this.isActive,
      this.isVerified,
      this.lastName,
      this.role});

  factory User.mapToModel(Map m) {
    return User(
        email: m['email'],
        firstName: m['firstName'],
        id: m['id'],
        isActive: m['isActive'],
        isVerified: m['isVerified'],
        lastName: m['lastName'],
        role: m['role']);
  }
}

class Tokens {
  String? accessToken;
  Tokens({this.accessToken});

  factory Tokens.mapToModel(Map m) {
    return Tokens(accessToken: m['accessToken']);
  }
}
/*
{
    "status": 201,
    "success": true,
    "message": "User registered successfully.",
    "data": {
        "user": {
            "id": "a9b930f7-4c61-409a-a2bc-e9c3467a30a6",
            "firstName": "short",
            "lastName": "Koladiya",
            "email": "yraj295000@gmail.com",
            "role": "USER",
            "isActive": true,
            "isVerified": false
        },
        "tokens": {
            "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE5YjkzMGY3LTRjNjEtNDA5YS1hMmJjLWU5YzM0NjdhMzBhNiIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNzUyMTM4MjM1LCJleHAiOjE3NTIyMjQ2MzV9.rKjaQUW9Nee3r9N0ls6UZLPPgGBa_5fwpKAEj3dMrws"
        }
    }
}

 */
