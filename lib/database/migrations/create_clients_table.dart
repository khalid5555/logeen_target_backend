import 'package:vania/vania.dart';

class CreateClientsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTable(
      'clients',
      () {
        id();
        char('name');
        char("phone", length: 11);
        longText("description");
        char("city", length: 200);
        char("category", length: 200);
        char("employeeId", length: 200);
        timeStamps();
      },
    );
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('clients');
  }
}
