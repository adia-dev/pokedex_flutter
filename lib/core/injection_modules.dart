import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class InjectionModules {
  @lazySingleton
  Logger get logger => Logger();
}
