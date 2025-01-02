
// To parse this JSON data, do
//
//     final cartCheckResponseModel = cartCheckResponseModelFromJson(jsonString);

import 'dart:convert';

CartCheckResponseModel cartCheckResponseModelFromJson(String str) => CartCheckResponseModel.fromJson(json.decode(str));

String cartCheckResponseModelToJson(CartCheckResponseModel data) => json.encode(data.toJson());

class CartCheckResponseModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Category>? categories;

  CartCheckResponseModel({
    this.totalSize,
    this.limit,
    this.offset,
    this.categories,
  });

  factory CartCheckResponseModel.fromJson(Map<String, dynamic> json) => CartCheckResponseModel(
    totalSize: json["total_size"],
    limit: json["limit"],
    offset: json["offset"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_size": totalSize,
    "limit": limit,
    "offset": offset,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  int? id;
  String? name;
  String? image;
  int? parentId;
  int? position;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? priority;
  int? moduleId;
  String? slug;
  int? featured;
  int? productsCount;
  int? childesCount;
  String? imageFullUrl;
  List<dynamic>? childes;
  List<Storage>? storage;
  List<Translation>? translations;

  Category({
    this.id,
    this.name,
    this.image,
    this.parentId,
    this.position,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.priority,
    this.moduleId,
    this.slug,
    this.featured,
    this.productsCount,
    this.childesCount,
    this.imageFullUrl,
    this.childes,
    this.storage,
    this.translations,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    parentId: json["parent_id"],
    position: json["position"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    priority: json["priority"],
    moduleId: json["module_id"],
    slug: json["slug"],
    featured: json["featured"],
    productsCount: json["products_count"],
    childesCount: json["childes_count"],
    imageFullUrl: json["image_full_url"],
    childes: json["childes"] == null ? [] : List<dynamic>.from(json["childes"]!.map((x) => x)),
    storage: json["storage"] == null ? [] : List<Storage>.from(json["storage"]!.map((x) => Storage.fromJson(x))),
    translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "parent_id": parentId,
    "position": position,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "priority": priority,
    "module_id": moduleId,
    "slug": slug,
    "featured": featured,
    "products_count": productsCount,
    "childes_count": childesCount,
    "image_full_url": imageFullUrl,
    "childes": childes == null ? [] : List<dynamic>.from(childes!.map((x) => x)),
    "storage": storage == null ? [] : List<dynamic>.from(storage!.map((x) => x.toJson())),
    "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x.toJson())),
  };
}

class Storage {
  int? id;
  String? dataType;
  String? dataId;
  String? key;
  String? value;
  DateTime? createdAt;
  DateTime? updatedAt;

  Storage({
    this.id,
    this.dataType,
    this.dataId,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory Storage.fromJson(Map<String, dynamic> json) => Storage(
    id: json["id"],
    dataType: json["data_type"],
    dataId: json["data_id"],
    key: json["key"],
    value: json["value"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "data_type": dataType,
    "data_id": dataId,
    "key": key,
    "value": value,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Translation {
  int? id;
  String? translationableType;
  int? translationableId;
  String? locale;
  String? key;
  String? value;
  dynamic createdAt;
  dynamic updatedAt;

  Translation({
    this.id,
    this.translationableType,
    this.translationableId,
    this.locale,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    translationableType: json["translationable_type"],
    translationableId: json["translationable_id"],
    locale: json["locale"],
    key: json["key"],
    value: json["value"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "translationable_type": translationableType,
    "translationable_id": translationableId,
    "locale": locale,
    "key": key,
    "value": value,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

/*
class CategoryModel {
  int? _id;
  String? _name;
  int? _parentId;
  int? _position;
  String? _createdAt;
  String? _updatedAt;
  String? _imageFullUrl;

  CategoryModel(
    {int? id,
    String? name,
    int? parentId,
    int? position,
    String? createdAt,
    String? updatedAt,
    String? imageFullUrl}) {
    _id = id;
    _name = name;
    _parentId = parentId;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imageFullUrl = imageFullUrl;
  }

  int? get id => _id;
  String? get name => _name;
  int? get parentId => _parentId;
  int? get position => _position;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imageFullUrl => _imageFullUrl;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imageFullUrl = json['image_full_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['parent_id'] = _parentId;
    data['position'] = _position;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['image_full_url'] = _imageFullUrl;

    return data;
  }
}
*/
