import 'package:fg_task/Model/Components/inspection_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main ()
{
  test("Test ENUM", (){
    INSPECTION_ITEM_FIELDS desc = INSPECTION_ITEM_FIELDS.description;
    assert (desc.name == "description");
  });

}