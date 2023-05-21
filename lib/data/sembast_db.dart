import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../model/password.dart';

class SembastDb {
  DatabaseFactory dbFactory = databaseFactoryIo;
  late Database _db;
  final store = intMapStoreFactory.store('password');

  static SembastDb _singleton = SembastDb._internal();

  Future<Database> init() async {
    if (_db == null) {
      _db = await _openDb();
    }
    return _db;
  }

  factory SembastDb() {
    return _singleton;
  }

  SembastDb._internal() {}

  Future _openDb() async {
    final docDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docDir.path, 'pass.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future addPassword(Password password) async {
    await init();
    int id = await store.add(_db, password.toMap());
    return id;
  }

  Future getPassowrds() async {
    final finder = Finder(sortOrders: [SortOrder('name')]);
    final snapShot = await store.find(_db, finder: finder);
    return snapShot.map((item) {
      final pwd = Password.formMap(item.value);
      pwd.id = item.key;
    }).toList();
  }

  Future updatePassword(Password pwd) async {
    final finder = Finder(filter: Filter.byKey(pwd));
    await store.update(_db, pwd.toMap(), finder: finder);
  }

  Future deletePassword(Password pwd) async {
    final finder = Finder(filter: Filter.byKey(pwd.id));
    await store.delete(_db, finder: finder);
  }

  Future deleteAll() async {
    await store.delete(_db);
  }
}
