import 'package:blood_sugar_monitor/models/blood_sugar.dart';
import 'package:blood_sugar_monitor/models/medicine_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MedicationDatabase {
  static final MedicationDatabase instance = MedicationDatabase._init();

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
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final doubleType = 'DOUBLE NOT NULL';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableBloodSugar (
  ${BloodSugarFields.id} $idType,
  ${BloodSugarFields.beforeFood} $boolType,
  ${BloodSugarFields.afterFood} $boolType,
  ${BloodSugarFields.date} $textType,
  ${BloodSugarFields.time} $textType,
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

  Future<Medicine> create(Medicine medicine) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableMedicine, medicine.toJson());
    return medicine.copy(id: id);
  }

  //Read BloodSugars
  Future<Medicine> readMedicine(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMedicine,
      columns: MedicineFields.values,
      where: '${MedicineFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Medicine.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //Read All Bloodsugar
  Future<List<Medicine>> readAllMedicine() async {
    final db = await instance.database;

    final orderBy = '${MedicineFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableMedicine, orderBy: orderBy);

    return result.map((json) => Medicine.fromJson(json)).toList();
  }

  //Updata
  Future<int> update(Medicine meds) async {
    final db = await instance.database;

    return db.update(
      tableMedicine,
      meds.toJson(),
      where: '${MedicineFields.id} = ?',
      whereArgs: [meds.id],
    );
  }

  //Delete
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableMedicine,
      where: '${MedicineFields.id} = ?',
      whereArgs: [id],
    );
  }

  //Close DB
  Future close() async {
    final db = await instance.database;

    db.close();
  }

  MedicationDatabase._init();
}
