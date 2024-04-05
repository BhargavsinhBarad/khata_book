import 'package:khata_book/modules/views/add/model/datamodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();

  Database? database;
  String tablename = "khatabook";
  String id = "id";
  String name = "name";
  String remark = "remark";
  String amount = "amount";
  String mono = "mono";
  String time = "time";
  String date = "date";
  String type = "type";
  String recivedate = "recivedate";

  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'khata.db');

    database = await openDatabase(path, version: 1, onCreate: (db, version) {
      String query =
          "CREATE TABLE $tablename($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT NOT NULL, $remark TEXT NOT NULL,$mono TEXT NOT NULL, $amount TEXT NOT NULL, $date TEXT NOT NULL, $time TEXT NOT NULL, $type TEXT NOT NULL,$recivedate TEXT NOT NULL);";
      db.execute(query);
    });
  }

  Future<int> insertdata({required Datamodel dm}) async {
    await initDB();
    String query =
        "INSERT INTO $tablename($name,$remark,$mono,$amount,$date,$time,$type,$recivedate) VALUES(?,?,?,?,?,?,?,?);";
    List<dynamic> arguments = [
      dm.name,
      dm.remark,
      dm.mono,
      dm.amount,
      dm.date,
      dm.time,
      dm.type,
      dm.recivedate
    ];
    int res = await database!.rawInsert(query, arguments);
    return res;
  }

  Future<List<Datamodel>?> fetchdata() async {
    await initDB();
    String query = "SELECT * FROM $tablename;";
    var body = await database?.rawQuery(query);
    List<Datamodel>? todo = body?.map((e) => Datamodel.name(data: e)).toList();
    return todo;
  }

  updatedata({required Datamodel dm}) async {
    await initDB();
    String query =
        "UPDATE $tablename SET $name = ?,$remark = ?,$mono = ?,$amount = ?, $date = ?, $time = ?,$type = ? ,$recivedate = ? WHERE $id = ? ;";
    List aru = [
      dm.name,
      dm.remark,
      dm.mono,
      dm.amount,
      dm.date,
      dm.time,
      dm.type,
      dm.recivedate,
      dm.id
    ];
    int res = await database!.rawUpdate(query, aru);
    return res;
  }
}
