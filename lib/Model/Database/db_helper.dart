import 'package:fg_task/Model/Components/inspection_item.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper
{
  late Database db;
  final String DB_NAME = "fg_db.db";

  Future open(String path) async
  {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async
        {
          /// create inspection item table
          await db.execute('''
          create table ${InspectionItem.myClassName} ( 
            ${INSPECTION_ITEM_FIELDS.id.name} integer primary key autoincrement, 
            ${INSPECTION_ITEM_FIELDS.title.name} text not null,
            ${INSPECTION_ITEM_FIELDS.picture.name} text not null,
            ${INSPECTION_ITEM_FIELDS.description.name} text not null,
            ${INSPECTION_ITEM_FIELDS.dateTime.name} text not null,
            ${INSPECTION_ITEM_FIELDS.status.name} integer not null)
          ''');

        });
  }

  Future <List<InspectionItem>> getAllInspectionItems () async
  {
    await open(DB_NAME);

    List <InspectionItem> inspectionItems = [];

    var result = await db.rawQuery("SELECT * FROM ${InspectionItem.myClassName}");

    result.forEach((row)
    {
      InspectionItem item = InspectionItem.fromMap(row);
      inspectionItems.add(item);
    });

    close();
    return inspectionItems;
  }

  Future<InspectionItem> insertInspectionItem (InspectionItem item) async
  {
    await open(DB_NAME);

    item.id = await db.insert(InspectionItem.myClassName, item.toMap());

    close();

    return item;
  }

  Future<InspectionItem?> getInspectionItem (int id) async
  {
    await open(DB_NAME);

    List<Map> maps = await db.query(InspectionItem.myClassName,
        columns: [
          INSPECTION_ITEM_FIELDS.id.name,
          INSPECTION_ITEM_FIELDS.title.name,
          INSPECTION_ITEM_FIELDS.picture.name,
          INSPECTION_ITEM_FIELDS.description.name,
          INSPECTION_ITEM_FIELDS.dateTime.name,
          INSPECTION_ITEM_FIELDS.status.name
        ],
        where: '${INSPECTION_ITEM_FIELDS.id.name} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return InspectionItem.fromMap(maps.first);
    }

    close();

    return null;
  }

  Future<int> deleteInspectionItem (int id) async
  {
    await open(DB_NAME);
    int status = await db.delete(InspectionItem.myClassName, where: '${INSPECTION_ITEM_FIELDS.id.name} = ?', whereArgs: [id]);
    close();
    return status;
  }

  Future<int> updateInspectionItem (InspectionItem item) async
  {
    await open(DB_NAME);

    int status = await db.update(InspectionItem.myClassName, item.toMap(),
        where: '${INSPECTION_ITEM_FIELDS.id.name} = ?', whereArgs: [item.id]);

    close();

    return status;
  }

  Future close() async => db.close();
}