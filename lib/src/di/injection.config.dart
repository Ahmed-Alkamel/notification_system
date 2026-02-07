// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../impl/firebase_notification_service.dart' as _i609;
import '../impl/general_notification_service.dart' as _i447;
import '../impl/local_notification_service.dart' as _i399;
import '../services/permission_service.dart' as _i165;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i447.GeneralNotificationService>(
      () => _i447.GeneralNotificationService(),
    );
    gh.singleton<_i399.LocalNotificationService>(
      () => _i399.LocalNotificationService(),
    );
    gh.singleton<_i165.PermissionService>(
      () => _i165.PermissionService(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i609.FirebaseNotificationService>(
      () => _i609.FirebaseNotificationService(
        gh<_i399.LocalNotificationService>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
