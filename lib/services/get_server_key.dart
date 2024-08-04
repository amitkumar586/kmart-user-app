import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    await dotenv.load(fileName: '.env');
    final scope = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(
          // {
          //   "client_email":
          //       "firebase-adminsdk-ypsie@kmart-2c7fd.iam.gserviceaccount.com",
          //   "client_id": "112655609082587507785",
          //   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          //   "token_uri": "https://oauth2.googleapis.com/token",
          //   "auth_provider_x509_cert_url":
          //       "https://www.googleapis.com/oauth2/v1/certs",
          //   "client_x509_cert_url":
          //       "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-ypsie%40kmart-2c7fd.iam.gserviceaccount.com",
          //   "universe_domain": "googleapis.com"
          // },
          {
            "type": dotenv.env['TYPE'],
            "project_id": dotenv.env["PROJECT_ID"],
            "private_key_id": dotenv.env["PRIVATE_KEY_ID"],
            "private_key": dotenv.env["PRIVATE_KEY"]
          }),
      scope,
    );

    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
