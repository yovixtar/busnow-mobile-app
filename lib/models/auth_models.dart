class TokenPenggunaModel {
  String? token;

  TokenPenggunaModel({
    this.token,
  });

  TokenPenggunaModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
