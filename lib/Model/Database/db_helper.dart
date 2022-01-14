import 'package:fg_task/Model/Components/inspection_item.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper
{
  late Database db;

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
    await open("fg_db.db");

    List <InspectionItem> inspectionItems = [];

    List<Map> result = await db.query(InspectionItem.myClassName);

    result.forEach((row)
    {
      InspectionItem item = InspectionItem(
          id: row[INSPECTION_ITEM_FIELDS.id.name],
          title: row[INSPECTION_ITEM_FIELDS.title.name],
          description: row[INSPECTION_ITEM_FIELDS.description.name],
          dateTime: DateTime.parse(row[INSPECTION_ITEM_FIELDS.dateTime.name]),
          status: (row[INSPECTION_ITEM_FIELDS.status.name] == 1) ? true : false,
          picture: row[INSPECTION_ITEM_FIELDS.picture.name]
      );

      inspectionItems.add(item);
    });

    close();
    return inspectionItems;
  }

  Future<InspectionItem> insertInspectionItem (InspectionItem item) async
  {
    await open("fg_db.db");

    item.id = await db.insert(InspectionItem.myClassName, item.toMap());

    close();

    return item;
  }

  Future<InspectionItem?> getInspectionItem (int id) async
  {
    await open("fg_db.db");

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
    await open("fg_db.db");
    int status = await db.delete(InspectionItem.myClassName, where: '${INSPECTION_ITEM_FIELDS.id.name} = ?', whereArgs: [id]);
    close();
    return status;
  }

  Future<int> updateInspectionItem (InspectionItem item) async
  {
    await open("fg_db.db");

    int status = await db.update(InspectionItem.myClassName, item.toMap(),
        where: '${INSPECTION_ITEM_FIELDS.id.name} = ?', whereArgs: [item.id]);

    close();

    return status;
  }

  Future close() async => db.close();
}