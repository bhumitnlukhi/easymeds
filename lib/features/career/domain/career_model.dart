class CareerModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? gender;
  String? preferredJobLocation;
  int? jobRole;
  String? highestQualification;
  String? cvFilePath;


  CareerModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.preferredJobLocation,
    this.jobRole,
    this.highestQualification,
    this.cvFilePath,

  });

  // Factory constructor to create an instance from JSON
  factory CareerModel.fromJson(Map<String, dynamic> json) {
    return CareerModel(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['mob_no'],
      gender: json['gender'],
      preferredJobLocation: json['preferred_job_loc'],
      jobRole: json['job_role'],
      highestQualification: json['highest_qual'],
      cvFilePath: json['cv'], // Assuming 'cv' contains the file path or name
    );
  }

  // Method to convert the model to JSON (e.g., for API submission)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name ?? '';
    data['email'] = email ?? '';
    data['mob_no'] = phoneNumber ?? '';
    data['gender'] = gender ?? '';
    data['preferred_job_loc'] = preferredJobLocation ?? '';
    data['job_role'] = jobRole ?? 0;
    data['highest_qual'] = highestQualification ?? '';
    data['cv'] = cvFilePath ?? '';
    return data;
  }
}

class JobRoleModel {
  int? id;
  String? jobRole;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<TranslationModel>? translations;

  JobRoleModel({
    this.id,
    this.jobRole,
    this.createdAt,
    this.updatedAt,
    this.translations,
  });

  // Factory constructor to create an instance from JSON
  factory JobRoleModel.fromJson(Map<String, dynamic> json) {
    return JobRoleModel(
      id: json['id'],
      jobRole: json['jobRole'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      translations: (json['translations'] as List<dynamic>?)
          ?.map((translation) => TranslationModel.fromJson(translation))
          .toList(),
    );
  }

  // Method to convert the model to JSON (e.g., for API submission)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['jobRole'] = jobRole;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    if (translations != null) {
      data['translations'] = translations!.map((t) => t.toJson()).toList();
    }
    return data;
  }
}

class TranslationModel {
  int? id;
  String? translationableType;
  int? translationableId;
  String? locale;
  String? key;
  String? value;

  TranslationModel({
    this.id,
    this.translationableType,
    this.translationableId,
    this.locale,
    this.key,
    this.value,
  });

  // Factory constructor to create an instance from JSON
  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      id: json['id'],
      translationableType: json['translationable_type'],
      translationableId: json['translationable_id'],
      locale: json['locale'],
      key: json['key'],
      value: json['value'],
    );
  }

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['translationable_type'] = translationableType;
    data['translationable_id'] = translationableId;
    data['locale'] = locale;
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
