import 'package:flutter_test/flutter_test.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
void main() {
  test('Game Distribution', () async {
   expect(12.567.toDoublePrecision(2), 12.57); 
    expect(12.554.toDoublePrecision(2), 12.55); 
    expect(12.555.toDoublePrecision(2), 12.56); 


  });
}
