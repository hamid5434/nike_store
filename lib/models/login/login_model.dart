class AuthInfo {
  String? tokenType;
  int? expiresIn;
  String? accessToken;
  String? refreshToken;

  AuthInfo(
      {this.tokenType, this.expiresIn, this.accessToken, this.refreshToken});

  AuthInfo.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}
