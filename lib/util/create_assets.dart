import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Create assets: if the --create-assets flag is specified on the command line, the app will not create a gui interface
/// but will instead run this program.
/// The idea is to take the contents of the assets folder and convert them to a single "assets" sqlite3 database in the
/// runtime data directory for this app.
/// During development, new schemas may be created, and a migration plan will be implemented.  At distribution, new assets
/// may be added to existing schema (think a new set of card images, or translations of descriptions, etc) by downloading
/// a new database.
/// Step 1: get our app data directory
/// Step 2, if no database exists, create it and prepare to populate it.
///

Future<String> locateDatabase() async {
  Directory appSupportDirectory = await getApplicationSupportDirectory();

  return "${appSupportDirectory.path}/assets.sqlite";
}
