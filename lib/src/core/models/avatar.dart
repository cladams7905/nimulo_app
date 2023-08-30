import 'package:uuid/uuid.dart';
import '../../utils/dateformatter.dart';

/// The avatar profile image for a user.
/// Requires a filepath to the image to be instantiated.
class Avatar {
  final String _avatarId = const Uuid().v4();
  final String _uploadedAt = dateFormatter.format(DateTime.now());
  String? _filePath;

  //Constructor
  Avatar(this._filePath);

  //Getters and setters
  String get getAvatarId => _avatarId;
  String? get getFilePath => _filePath;
  String get getUploadTime => _uploadedAt;
  set setFilePath(String filePath) => _filePath = filePath;
}
