enum INSPECTION_ITEM_FIELDS
{
  id,
  title,
  picture,
  description,
  dateTime,
  status
}

extension InspectionItemEXTENSION on INSPECTION_ITEM_FIELDS
{
  String get name
  {
    switch (this)
    {
      case INSPECTION_ITEM_FIELDS.id:
        return "id";

      case INSPECTION_ITEM_FIELDS.title:
        return "title";

      case INSPECTION_ITEM_FIELDS.picture:
        return "picture";

      case INSPECTION_ITEM_FIELDS.description:
        return "description";

      case INSPECTION_ITEM_FIELDS.dateTime:
        return "dateTime";

      case INSPECTION_ITEM_FIELDS.status:
        return "status";
    }
  }
}

class InspectionItem
{
  static const String myClassName = "InspectionItem";

  int? _id;
  String? _title;
  String? _picture;
  String? _description;
  DateTime? _dateTime;
  bool? _status = true;

  InspectionItem({
    int? id,
    String? title,
    String? picture,
    String? description,
    DateTime? dateTime,
    bool? status
  }) : _id = id,
      _title = title,
      _picture = picture,
      _description = description,
      _dateTime = dateTime,
      _status = status;


  Map<String, Object?> toMap()
  {
    var map = <String, Object?>{
      INSPECTION_ITEM_FIELDS.title.name : _title,
      INSPECTION_ITEM_FIELDS.picture.name : _picture,
      INSPECTION_ITEM_FIELDS.description.name : _description,
      INSPECTION_ITEM_FIELDS.dateTime.name : _dateTime.toString(),
      INSPECTION_ITEM_FIELDS.status.name : (_status!) ? 1 : 0
    };
    if (_id != null) {
      map[INSPECTION_ITEM_FIELDS.id.name] = _id;
    }
    return map;
  }

  InspectionItem.fromMap(Map<dynamic, dynamic> map)
  {
    _id = map[INSPECTION_ITEM_FIELDS.id.name];
    _title = map[INSPECTION_ITEM_FIELDS.title.name];
    _picture = map[INSPECTION_ITEM_FIELDS.picture.name];
    _description = map[INSPECTION_ITEM_FIELDS.description.name];
    _dateTime = DateTime.parse(map[INSPECTION_ITEM_FIELDS.dateTime.name]);
    _status = (map[INSPECTION_ITEM_FIELDS.status.name] == 1) ? true : false;
  }

  bool get status => _status!;

  DateTime get dateTime => _dateTime!;

  String get description => _description!;

  String get picture => _picture!;

  String get title => _title!;

  int get id => _id!;

  set status(bool value) {
    _status = value;
  }

  set dateTime(DateTime value) {
    _dateTime = value;
  }

  set description(String value) {
    _description = value;
  }

  set picture(String value) {
    _picture = value;
  }

  set title(String value) {
    _title = value;
  }

  set id(int value) {
    _id = value;
  }


}