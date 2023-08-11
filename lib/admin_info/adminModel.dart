
class Admin{
  final String  id;
  final String email;
  final String password;
  final String fullName ;

  Admin(
        {
        required this.id,
        required this.email,
        required this.fullName,
        required this.password
      }
      );

  factory Admin.fromJson(Map<String,dynamic> json) =>Admin(
      id: json["varsityID"],
      password:  json["password"],
      email: json["email"],
      fullName: json["fullName"],
  );

  Map<String,dynamic>toJson()=>
      {
        "varsityID" : id,
        "password" : password,
        "email" : email,
        "fullName" : fullName,
      };


}