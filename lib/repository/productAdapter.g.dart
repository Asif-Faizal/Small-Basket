// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productAdapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    int id = fields[0] != null ? fields[0] as int : 0;
    String name = fields[1] != null ? fields[1] as String : '';
    double price = fields[2] != null ? fields[2] as double : 0;
    String imageUrl = fields[3] != null ? fields[3] as String : '';

    return Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
