import '../../utils/enums.dart';
import 'package:uuid/uuid.dart';
import './avatar.dart';

/// The basic user class.
/// Requires a username, password, and email to be initialized.
class User {
  final String _userId = const Uuid().v4();
  final DateTime _dateJoined = DateTime.now();
  String _username;
  String _password;
  String _email;
  String? _nickname;
  String? _region;
  DateTime? _birthday;
  String? _phoneNumber;
  String? _personalBio;
  Avatar? _avatar;
  bool _isPaidAccount = false;
  bool _isEmailVerified = false;
  bool _isPhoneVerified = false;
  dynamic _nativeLanguage;
  dynamic _targetLanguage;
  dynamic _languageLevel;
  dynamic userRole;

  ///Basic User constructor
  User(this._username, this._password, this._email,
      {this.userRole = UserRole.member});

  //Full User constructor
  User.full(this._username, this._password, this._email,
      [this._nickname,
      this._birthday,
      this._phoneNumber,
      this._region,
      this._personalBio,
      this._avatar,
      this._isPaidAccount = false,
      this._isEmailVerified = false,
      this._isPhoneVerified = false,
      this._nativeLanguage = NativeLanguage.english,
      this._targetLanguage = TargetLanguage.chinese,
      this._languageLevel = LanguageLevel.brandNew,
      this.userRole = UserRole.member]);

  /// Sets the current user as an admin and pushes new admin to the database.
  /// If the user is already an admin, no changes are made.
  void setAsAdmin() {
    if (!userRole.admin) {
      var admin = Admin(_username, _password, _email);
      //push admin to database
    }
  }

  String get getUserId {
    return _userId;
  }

  String get getUsername {
    return _username;
  }

  set setUsername(String username) {
    _username = username;
  }

  String get getPassword {
    return _password;
  }

  set setPassword(String password) {
    _password = password;
  }

  String? get getNickname {
    return _nickname;
  }

  set setNickname(String nickname) {
    _nickname = nickname;
  }

  String get getEmail {
    return _email;
  }

  set setEmail(String email) {
    _email = email;
  }

  String? get getRegion {
    return _region;
  }

  set setRegion(String region) {
    _region = region;
  }

  DateTime? get getBirthday {
    return _birthday;
  }

  set setBirthday(DateTime birthday) {
    _birthday = birthday;
  }

  DateTime get getDateJoined {
    return _dateJoined;
  }

  String? get getPhoneNumber {
    return _phoneNumber;
  }

  set setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  String? get getPersonalBio {
    return _personalBio;
  }

  set setPersonalBio(String personalBio) {
    _personalBio = personalBio;
  }

  Avatar? get getAvatar {
    return _avatar;
  }

  set setAvatar(Avatar avatar) {
    _avatar = avatar;
  }

  bool get isPaidAccount {
    return _isPaidAccount;
  }

  set setAccountType(bool isPaidAccount) {
    _isPaidAccount = isPaidAccount;
  }

  bool get isEmailVerifed {
    return _isEmailVerified;
  }

  set setEmailAsVerified(bool isEmailVerified) {
    _isEmailVerified = isEmailVerified;
  }

  bool get isPhoneVerifed {
    return _isPhoneVerified;
  }

  set setPhoneAsVerified(bool isPhoneVerified) {
    _isPhoneVerified = isPhoneVerified;
  }

  NativeLanguage get getNativeLanguage {
    return _nativeLanguage;
  }

  set setNativeLanguage(NativeLanguage nativeLanguage) {
    _nativeLanguage = nativeLanguage;
  }

  TargetLanguage get getTargetLanguage {
    return _targetLanguage;
  }

  set setTargetLanguage(TargetLanguage targetLanguage) {
    _targetLanguage = targetLanguage;
  }

  LanguageLevel get getLanguageLevel {
    return _languageLevel;
  }

  set setLanguageLevel(LanguageLevel languageLevel) {
    _languageLevel = languageLevel;
  }

  UserRole get getUserRole {
    return userRole;
  }

  set setUserRole(UserRole userRole) {
    userRole = userRole;
  }
}

///The Admin is a subclass of User. Admins are retrievable by userId.
class Admin extends User {
  Admin(super._username, super._password, super._email,
      {super.userRole = UserRole.admin});

  String get getAdminUserId {
    return super._userId;
  }
}
