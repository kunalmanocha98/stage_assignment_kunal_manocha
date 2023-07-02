class UserCollection {
  String? name;
  String? email;
  String? uId;

  UserCollection({this.name, this.email, this.uId});

  UserCollection.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['uId'] = uId;
    return data;
  }
}