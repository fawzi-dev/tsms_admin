class AppVersionModel {
  final double version;

  AppVersionModel({required this.version});

  Map<String, dynamic> toJson() {
    return {'version': version};
  }

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    return AppVersionModel(version: json['version']);
  }
}
