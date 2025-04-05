class UserModel {
  String? userId, email, name, phoneNumber, role, address, pic;

  UserModel({
    this.userId,
    this.email,
    this.name,
    this.phoneNumber,
    this.role,
    this.address,
    this.pic,
  });

  // Hàm khởi tạo từ json
  UserModel.fromjson(Map<dynamic, dynamic> Map) {
    if (Map == null) return;

    userId = Map["uid"]; // 'uid' được thay thế cho 'userId'
    email = Map["email"];
    name = Map["name"];
    phoneNumber = Map["phone_number"]; // Sửa thành 'phone_number'
    role = Map["role"];
    address = Map["address"]; // Sửa thành 'address'
    pic = Map["pic"];
  }

  // Hàm chuyển đối tượng thành json
  tojson() {
    return {
      'uid': userId, // 'userId' là 'uid' trong json
      'email': email,
      'name': name,
      'phone_number': phoneNumber, // Sửa thành 'phone_number'
      'role': role,
      'address': address, // Sửa thành 'address'
      'pic': pic,
    };
  }
}
