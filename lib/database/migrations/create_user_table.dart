import 'package:vania/vania.dart';

class CreateUserTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTable(
      'users',
      () {
        id();
        char('name', length: 100);
        char('email', length: 100);
        char('password');
        dateTime('created_at');
      },
    );
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('users');
  }
}
