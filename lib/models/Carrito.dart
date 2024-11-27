import 'package:flutter/material.dart';
import 'package:yesnoapp/models/Producto.dart';

class Carrito extends ChangeNotifier {
  Map<String, Producto> _producto = {};
  Map<String, Producto> get productos {
    return {..._producto};
  }

  int get numeroProductos {
    return _producto.length;
  }

  double get subtotal {
    var total = 0.0;
    productos.forEach((key, elementos) => total += elementos.precio as double);
    return total;
  }

  void agregarProducto(
      int idProducto,
      int tipo,
      int codPrincipal,
      String nombre,
      String descripcion,
      String precio,
      int stock,
      List<String> imagenes) {
    if (_producto.containsKey(idProducto.toString())) {
      _producto.update(
          idProducto.toString(),
          (old) => Producto(
              idProducto: old.idProducto,
              tipo: old.tipo,
              codPrincipal: old.codPrincipal,
              nombre: old.nombre,
              descripcion: old.descripcion,
              precio: old.precio,
              stock: old.stock,
              imagenes: old.imagenes));
    } else {
      _producto.putIfAbsent(
          idProducto.toString(),
          () => Producto(
              idProducto: idProducto,
              tipo: tipo,
              codPrincipal: codPrincipal,
              nombre: nombre,
              descripcion: descripcion,
              precio: precio,
              stock: stock,
              imagenes: imagenes));
    }
  }
  void incremetarProducto(int idProducto){
    if (_producto.containsKey(idProducto.toString())) {
    _producto.update(
        idProducto.toString(),
        (old) => Producto(
            idProducto: old.idProducto,
            tipo: old.tipo,
            codPrincipal: old.codPrincipal,
            nombre: old.nombre,
            descripcion: old.descripcion,
            precio: old.precio,
            stock: old.stock,
            imagenes: old.imagenes));
  }
  }
  void decrementarProducto(int idProducto) {
    if (_producto.containsKey(idProducto.toString())) {
      _producto.update(
          idProducto.toString(),
          (old) => Producto(
              idProducto: old.idProducto,
              tipo: old.tipo,
              codPrincipal: old.codPrincipal,
              nombre: old.nombre,
              descripcion: old.descripcion,
              precio: old.precio,
              stock: old.stock - 1,
              imagenes: old.imagenes));
    }
  }

  void removerProducto(int idProducto) {
    _producto.remove(idProducto);
  }

  void removerCarrito() {
    _producto = {};
  }
}
