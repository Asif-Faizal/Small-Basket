import 'package:hive/hive.dart';
import 'package:machn_tst/models/product.dart';

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final price = reader.readDouble();
    final imageUrl = reader.readString();
    return Product(id: id, name: name, price: price, imageUrl: imageUrl);
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeDouble(obj.price);
    writer.writeString(obj.imageUrl);
  }
}
