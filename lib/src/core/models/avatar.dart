import 'package:uuid/uuid.dart';

/// The avatar profile image for a user.
/// Requires a filepath to the image and the time of upload to be initialized.
class Avatar {
  final String _avatarId = const Uuid().v4();
  String? _filePath;
  DateTime? _uploadedAt;

  Avatar.base();

  Avatar(this._filePath, this._uploadedAt);

  String get getAvatarId {
    return _avatarId;
  }

  String? get getFilePath {
    return _filePath;
  }

  set setFilePath(String filePath) {
    _filePath = filePath;
  }

  DateTime? get getUploadedAtTime {
    return _uploadedAt;
  }
}
