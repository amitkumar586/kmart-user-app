class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scope = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    return "";
  }
}
