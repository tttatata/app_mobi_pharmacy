import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('660ef83914ad5e8245fe')
    .setSelfSigned(status: true);
Account account =
    Account(client); // For self signed certificates, only use for development

Future<String> createUSer(String name, String email, String password) async {
  try {
    await account.create(userId: ID.unique(), email: email, password: password);
    return "success";
  } on AppwriteException catch (e) {
    return e.message.toString();
  }
}
