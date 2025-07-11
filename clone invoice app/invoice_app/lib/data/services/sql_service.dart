// import 'package:sqflite/sqflite.dart';

// class SqlService {
//   SqlService._();
//   static SqlService sql = SqlService._();
//   Database? database;

//   String userid = "id";
//   String userFName = "firstName";
//   String userLName = "lastName";
//   String userEmail = "email";
//   String userPass = "password";
//   String userToken = "accessToken";


//   Future<void> initDatabase() async {
//     String path = await getDatabasesPath();
//     String finalPath = "$path/userInfo.db";

//     database = await openDatabase(
//       finalPath,
//       version: 1,
//       onCreate: (db, version) async {
//         String q = ''' ''';
//       },
//     );
//   }
// }


