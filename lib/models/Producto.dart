import 'dart:convert';

Productos productosFromJson(String str) => Productos.fromJson(json.decode(str));

String productosToJson(Productos data) => json.encode(data.toJson());

class Productos {
  final List<Producto> productos;
  Productos({
    required this.productos,
  });

  factory Productos.fromJson(Map<String, dynamic> json) => Productos(
        productos: List<Producto>.from(
            json["productos"].map((x) => Producto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productos": List<dynamic>.from(productos.map((x) => x.toJson())),
      };
}

class Producto {
  final int idProducto;
  final int tipo;
  final int codPrincipal;
  final String nombre;
  final String descripcion;
  final String precio;
  final int stock;
  final List<String> imagenes;

  Producto({
    required this.idProducto,
    required this.tipo,
    required this.codPrincipal,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.stock,
    required this.imagenes,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        idProducto: json["id_producto"],
        tipo: json["tipo"],
        codPrincipal: json["cod_principal"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        stock: json["stock"],
        imagenes: List<String>.from(json["imagenes"].map((x) => x))
      );

  Map<String, dynamic> toJson() => {
        "id_producto": idProducto,
        "tipo": tipo,
        "cod_principal": codPrincipal,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "stock": stock,
        "imagenes": List<dynamic>.from(imagenes.map((x) => x)),
      };
}
