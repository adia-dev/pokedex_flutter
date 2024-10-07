import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart'; // Generated file

GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void configureDependencies() => getIt.init();
