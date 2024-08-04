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
          //   "type": "service_account",
          //   "project_id": "kmart-2c7fd",
          //   "private_key_id": "30b00e23d99383fd54c15efcd50d26eed7328549",
          //   "private_key":
          //       "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCtWLUAxMwjc1Ly\npP2JN3mo/s9ePPgCWAqcU42O0bc8C3X65bLSgjFlPnHB2oz6rZFgTGgnqJJcWv6g\n2jtBE/7tUbpf1loBpCnZB5fTb7PS+FXeUlSy9vD6OpomsmxqwxkrF5ZaAc68Rlwb\nThM5MlFeIqs+Q++Jmazt80b0AxJlM+mr1CXX4/Ck9LDOHiDNa6qQw/h6KDDonotr\nuTGOJiLuM88bhlyzvlssIGHioBhH7gUcoC55GwE7PfAlhbXRPFqUy3geBlknRtuw\nM4H+dRidx+xXt2SOpkNbf2+kX3actzBLe6biYqT6K653NzORMzbWvu9mZ8s7NijB\n5bKkV2rNAgMBAAECggEANhDDT4yR4QKwndaA70G6s89ZrRpV/iEomg5jSea2AEfQ\n0eK/jfGmZ139DAnWy77D52WdXLUyhRSqc0/tiEQs0Ccb+pU3+GgT10mLfJpL22Ky\nIYfLPBBSI7GQb75Zm0jjejG+pq8GpGlLhAarbzz27OXiRCbbOK8SJRsqB6RHogF2\nFz0kZZxmSiuSUHAOlOWDK0bBAMu/3FfJ+qtsk8ajyQAgBGrbF2Djd+HvP3NcNyj0\nwTAr4sRZ/IAX5C3nmyHvv+hhCGhgTL93tPdCE9l22ucbzmKAWoUYJx13swY3fNdF\nbYGVcCONcyeXuEjw8fktVp0SXWM5o68MTnpQtl5xTwKBgQDVFPYMDeNNPB83pOtC\n5UATpbPTGyGhGgLILvpqKJzomOKGM4UUQuyNRTT12jV2pAJa8qj6W50YYKx5A1AC\nK3udovb6rF7tdjc84qQtsoNqgMvqmTrPcZTbz7EMFye4Z2kNsHUfz3cFU5amgrNk\nWnE2513mNujeSruY4WXuqI1vYwKBgQDQQuPkNr1g6vr6INjBWjhmokx3DzMjt1fL\n2SEaWqf2HMjb46RVuDntAJudz8Mcy9086fY9AHoGH+UKWGxSgN5j9mS7QNrRNGLO\na68dc7hixQJI+a2fw9vslmzYyLoxx8jUuhXTmzIjyMKSCq/XaxULI/tL0iCJcti7\nNDWB6PnMDwKBgBgjR7wV1qnpJaAoDn6FebzACJ7hc+3MBISozbU45I10xDRvoaOp\n8SIPtPAkx+moqpui4YF631DjoqYSuf2E73vr+g5reFVuDtPW2MJUdo6aCH+K3B6j\nvzknTecQuG8rR7tFQf9YgSMZVPeH1sqHdEvD6d8qWTbVQGsRHXrrnRoBAoGAaprC\n4s/ucsz1udHUgmz3T/omIA/EwrSYGX3ExyO+tGmZm41UUpih9iKIheiS3IuybPrq\nE+HJlJcA/CG1GSpkLFE00PFq0Qn6xeUzV2Uj7lMgT1CXQp/UVK/PecyOGutEbzft\n8kqQCOc8Sdt0lVV4CSLbAL3H7/O8417fQOeL7psCgYBc/bQLpcz/cr1wtRKPF96M\n/vk0YLgQgEfmP/NGQQkHSxIiyokKjAAWg/X8FFalZpyuC+dW5XK6w4ia4ASqGfMd\nxya81wm6/np6j+bZMG4BY3MABKV/BcV5Vov4nJMPvijITys7WJelyKv6gIyaHRBO\nZZNiQaCopfwa0TFATCAkqg==\n-----END PRIVATE KEY-----\n",
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
          }),
      scope,
    );

    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
