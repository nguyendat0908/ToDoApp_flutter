// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_realm_entity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CategoryRealmEntity extends $CategoryRealmEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  CategoryRealmEntity(
    ObjectId id,
    String name, {
    int? iconCodePoint,
    String? backgroundColorHex,
    String? iconColorColorHex,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'iconCodePoint', iconCodePoint);
    RealmObjectBase.set(this, 'backgroundColorHex', backgroundColorHex);
    RealmObjectBase.set(this, 'iconColorColorHex', iconColorColorHex);
  }

  CategoryRealmEntity._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int? get iconCodePoint =>
      RealmObjectBase.get<int>(this, 'iconCodePoint') as int?;
  @override
  set iconCodePoint(int? value) =>
      RealmObjectBase.set(this, 'iconCodePoint', value);

  @override
  String? get backgroundColorHex =>
      RealmObjectBase.get<String>(this, 'backgroundColorHex') as String?;
  @override
  set backgroundColorHex(String? value) =>
      RealmObjectBase.set(this, 'backgroundColorHex', value);

  @override
  String? get iconColorHex =>
      RealmObjectBase.get<String>(this, 'iconColorColorHex') as String?;
  @override
  set iconColorHex(String? value) =>
      RealmObjectBase.set(this, 'iconColorColorHex', value);

  @override
  Stream<RealmObjectChanges<CategoryRealmEntity>> get changes =>
      RealmObjectBase.getChanges<CategoryRealmEntity>(this);

  @override
  Stream<RealmObjectChanges<CategoryRealmEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CategoryRealmEntity>(this, keyPaths);

  @override
  CategoryRealmEntity freeze() =>
      RealmObjectBase.freezeObject<CategoryRealmEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'iconCodePoint': iconCodePoint.toEJson(),
      'backgroundColorHex': backgroundColorHex.toEJson(),
      'iconColorColorHex': iconColorHex.toEJson(),
    };
  }

  static EJsonValue _toEJson(CategoryRealmEntity value) => value.toEJson();
  static CategoryRealmEntity _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'iconCodePoint': EJsonValue iconCodePoint,
        'backgroundColorHex': EJsonValue backgroundColorHex,
        'iconColorColorHex': EJsonValue iconColorColorHex,
      } =>
        CategoryRealmEntity(
          fromEJson(id),
          fromEJson(name),
          iconCodePoint: fromEJson(iconCodePoint),
          backgroundColorHex: fromEJson(backgroundColorHex),
          iconColorColorHex: fromEJson(iconColorColorHex),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CategoryRealmEntity._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, CategoryRealmEntity, 'CategoryRealmEntity', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('iconCodePoint', RealmPropertyType.int, optional: true),
      SchemaProperty('backgroundColorHex', RealmPropertyType.string,
          optional: true),
      SchemaProperty('iconColorColorHex', RealmPropertyType.string,
          optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
