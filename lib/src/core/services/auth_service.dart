import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/widgets.dart';

import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/logger.dart';
import '../models/avatar.dart';

enum AuthStatus { uninitialized, unauthenticated, authenticated }

class AuthService extends ChangeNotifier {
  Client client = Client();

  late final Account account;

  late User _currentUser;

  AuthStatus _status = AuthStatus.uninitialized;

  // Getter methods
  User get currentUser => _currentUser;
  AuthStatus get status => _status;
  String? get username => _currentUser.name;
  String? get email => _currentUser.email;
  String? get userid => _currentUser.$id;
  String? get phoneNumber => _currentUser.phone;

  //Constructor
  AuthService() {
    initClient();
    loadUser();
  }

  initClient() {
    client
        .setEndpoint(APPWRITE_URL)
        .setProject(APPWRITE_PROJECT_ID)
        .setSelfSigned();
    account = Account(client);
  }

  loadUser() async {
    try {
      final user = await account.get();
      _status = AuthStatus.authenticated;
      _currentUser = user;
    } catch (error) {
      logger.e("Error loading user: $error");
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  Future<User> createAccount(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final user = await account.create(
          userId: ID.unique(),
          email: email,
          password: password,
          name: username);
      return user;
    } catch (error) {
      logger.e("Error creating account: $error");
    } finally {
      notifyListeners();
    }
    throw '';
  }

  Future<Session> createEmailSession(
      {required String email, required String password}) async {
    try {
      final session =
          await account.createEmailSession(email: email, password: password);
      _currentUser = await account.get();
      _status = AuthStatus.authenticated;
      return session;
    } catch (error) {
      logger.e("Error creating email session: $error");
    } finally {
      notifyListeners();
    }
    throw '';
  }

  signInWithProvider({required String provider}) async {
    try {
      final session = await account.createOAuth2Session(provider: provider);
      _currentUser = await account.get();
      _status = AuthStatus.authenticated;
      return session;
    } catch (error) {
      logger.e("Error signing in with $provider: $error");
    } finally {
      notifyListeners();
    }
  }

  signOut() async {
    try {
      await account.deleteSession(sessionId: 'current');
      _status = AuthStatus.unauthenticated;
    } catch (error) {
      logger.e("Error signing out: $error");
    } finally {
      notifyListeners();
    }
  }

  updateUsername({required String username}) async =>
      await account.updateName(name: username);

  updatePassword({required String password}) async =>
      await account.updatePassword(password: password);

  updateEmail({required String email, required String password}) async =>
      await account.updateEmail(email: email, password: password);

  updatePhoneNumber({required String phone, required String password}) async =>
      await account.updatePhone(phone: phone, password: password);

  blockAccount() async => await account.updateStatus();

  Future<Preferences> getAccountPreferences() async => await account.getPrefs();

  updateAccountPreferences(
      [DateTime? birthday,
      Country? region,
      String? bio,
      Avatar? avatar,
      UserRole? userRole,
      bool? isPaidAccount,
      NativeLanguage? nativeLanguage,
      List<TargetLanguage>? targetLanguages,
      LanguageLevel? languageLevel]) async {
    getAccountPreferences().then((oldPrefs) => {
          if (userRole == null) {userRole = oldPrefs.data['userRole']},
          if (birthday == null) {birthday = oldPrefs.data['birthday']},
          if (region == null) {region = oldPrefs.data['region']},
          if (bio == null) {bio = oldPrefs.data['bio']},
          if (avatar == null) {avatar = oldPrefs.data['avatarURL']},
          if (isPaidAccount == null)
            {isPaidAccount = oldPrefs.data['isPaidAccount']},
          if (nativeLanguage == null)
            {nativeLanguage = oldPrefs.data['nativeLanguage']},
          if (targetLanguages == null)
            {targetLanguages = oldPrefs.data['targetLanguages']},
          if (languageLevel == null)
            {languageLevel = oldPrefs.data['languageLevel']}
        });
    return account.updatePrefs(prefs: {
      'userRole': userRole,
      'birthday': birthday,
      'region': region,
      'bio': bio,
      'avatarURL': avatar?.getFilePath,
      'isPaidAccount': isPaidAccount,
      'nativeLanguage': nativeLanguage,
      'targetLanguages': targetLanguages,
      'languageLevel': languageLevel
    });
  }
}
