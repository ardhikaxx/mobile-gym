// import 'package:json_annotation/json_annotation.dart';

// part 'user.g.dart';

// @JsonSerializable()
// class UserData {
//   final String email;
//   @JsonKey(name: 'nama_lengkap')
//   final String namaLengkap;
//   @JsonKey(name: 'jenis_kelamin')
//   final String? jenisKelamin;
//   @JsonKey(name: 'tinggi_badan')
//   final String? tinggiBadan;
//   @JsonKey(name: 'berat_badan')
//   final String? beratBadan;
//   @JsonKey(name: 'alergi')
//   final String? alergi;
//   @JsonKey(name: 'golongan_darah')
//   final String? golonganDarah;
//   @JsonKey(name: 'created_at')
//   final String? createdAt;
//   @JsonKey(name: 'updated_at')
//   final String? updatedAt;

//   UserData({
//     required this.email,
//     required this.namaLengkap,
//     this.jenisKelamin,
//     this.tinggiBadan,
//     this.beratBadan,
//     this.alergi,
//     this.golonganDarah,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
//   Map<String, dynamic> toJson() => _$UserDataToJson(this);
// }

// @JsonSerializable()
// class UserResponse {
//   final String message;
//   final UserData user;

//   UserResponse({
//     required this.message,
//     required this.user,
//   });

//   factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$UserResponseToJson(this);
// }
