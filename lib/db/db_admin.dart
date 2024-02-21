import 'dart:io';

import 'package:gastos_app_fixed/models/gasto_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? myDatabase;

  static final DBAdmin _instace = DBAdmin._();

  factory DBAdmin() {
    // print(_instace.myDatabase.hashCode);
    return _instace;
  }
  DBAdmin._();

  Future<Database?> checkDatabase() async {
    // if (myDatabase == null) {
    //   myDatabase = await initDatabase();
    //   return myDatabase;
    // } else {
    //   return myDatabase;
    // }

    // if (myDatabase == null) {
    //   myDatabase = await initDatabase();
    // }
    // return myDatabase;

    myDatabase ??= await initDatabase();
    return myDatabase;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    String pathDatabase = join(directory.path, "GastosDB.db");
    return await openDatabase(
      pathDatabase,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute("""CREATE TABLE GASTOS (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              title TEXT ,
              price REAL, 
              datetime TEXT, 
              type TEXT
              )""");
      },
    );
  }

  //OBTENER DATOS
  Future<List<GastoModel>> obtenerGastos() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> data = await db!.query("GASTOS");
    // List data = await db!.rawQuery("SELECT TITLE, PRICE FROM GASTOS");
    // List data = await db!.query("GASTOS", where: "TYPE='Alimentos'");
    // print(data);
    List<GastoModel> gastosLista =
    data.map((e) => GastoModel.convertirDeMapaAModelo(e)).toList();

    // for (var item in data) {
    //   // GastoModel model = GastoModel(
    //   //   title: item["title"],
    //   //   dateTime: item["dateTime"],
    //   //   price: item["price"],
    //   //   type: item["type"],
    //   // );
    //   GastoModel model = GastoModel.convertirDeMapaAModelo(item);
    //   gastosLista.add(model);
    // }
    return gastosLista;
  }

  //INSERTAR GASTO
  Future<int> insertarGasto(GastoModel gasto) async {
    Database? db = await checkDatabase();
    int res = await db!.insert("GASTOS", gasto.convertirAMap()

      // {
      //   "title": gasto.title,
      //   "price": gasto.price,
      //   "datetime": gasto.dateTime,
      //   "type": gasto.type
      // }
    );
    return res;
    // print(res);
  }

  //ACTUALIZAR GASTO
  Future<int> updGasto(int? id) async {
    Database? db = await checkDatabase();
    int res = await db!.update(
      "GASTOS",
      {"title": "ACTUALIZADO12"},
      where: "id=$id",
    );
    return res;
  }

  //ELIMINAR GASTO

  Future<int> delGasto(int? id) async {
    Database? db = await checkDatabase();
    int res = await db!.delete(
      "GASTOS",
      where: 'id=$id',
    );

    return res;
  }
}
