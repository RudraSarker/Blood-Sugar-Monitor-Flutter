import 'package:blood_sugar_monitor/models/blood_sugar.dart';
import 'package:blood_sugar_monitor/models/medicine_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BloodSugarDatabase {
  static final BloodSugarDatabase instance = BloodSugarDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('bloodsugar.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const doubleType = 'DOUBLE NOT NULL';
    const textType = 'TEXT NOT NULL';
    //const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableBloodSugar (
  ${BloodSugarFields.id} $idType,
  ${BloodSugarFields.beforeFood} $doubleType,
  ${BloodSugarFields.afterFood} $doubleType,
  ${BloodSugarFields.date} $textType,
  ${BloodSugarFields.time} $textType
  )
''');

    await db.execute('''
CREATE TABLE $tableMedicine ( 
  ${MedicineFields.id} $idType, 
  ${MedicineFields.name} $textType,
  ${MedicineFields.morning} $integerType,
  ${MedicineFields.noon} $integerType,
  ${MedicineFields.night} $integerType
  )
''');
  }

  Future<BloodSugar> createBloodSugarEntry(BloodSugar bloodSugar) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableBloodSugar, bloodSugar.toJson());
    return bloodSugar.copy(id: id);
  }

  //Read BloodSugars
  Future<BloodSugar> readBloodsugar(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBloodSugar,
      columns: BloodSugarFields.values,
      where: '${BloodSugarFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BloodSugar.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //Read All Bloodsugar
  Future<List<BloodSugar>> readAllBloodsugar() async {
    final db = await instance.database;

    final orderBy = '${BloodSugarFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableBloodSugar, orderBy: orderBy);

    return result.map((json) => BloodSugar.fromJson(json)).toList();
  }

  //Updata
  Future<int> update(BloodSugar bls) async {
    final db = await instance.database;

    return db.update(
      tableBloodSugar,
      bls.toJson(),
      where: '${BloodSugarFields.id} = ?',
      whereArgs: [bls.id],
    );
  }

  //Delete
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableBloodSugar,
      where: '${BloodSugarFields.id} = ?',
      whereArgs: [id],
    );
  }

  //Close DB
  Future close() async {
    final db = await instance.database;

    db.close();
  }

  BloodSugarDatabase._init();
}
