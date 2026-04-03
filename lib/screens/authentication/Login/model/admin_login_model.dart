class AdminLoginModel {
  AdminLoginModel({
     this.status = 0,
     this.message = "",
     this.username = "",
     this.email = "",
     this.jwtToken = "",
  });

  final int status ;
  final String message;
  final String username;
  final String email;
  final String jwtToken;

  factory AdminLoginModel.fromJson(Map<String, dynamic> json){
    return AdminLoginModel(
      status: json["status"] ?? 0,
      message: json["message"] ?? "",
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      jwtToken: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": jwtToken,
    "username": username,
    "email": email,
  };
}

/*
{
	"status": 1,
	"message": "Login successful",
	"username": "harshil",
	"email": "admin@gmail.com"
}*/