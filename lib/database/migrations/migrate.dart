import 'dart:io';

import 'package:vania/vania.dart';

import 'create_user_table.dart';
import 'create_clients_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		 await CreateUserTable().up();
		 await CreateClientsTable().up();
	}

  dropTables() async {
		 await CreateClientsTable().down();
		 await CreateUserTable().down();
	 }
}
