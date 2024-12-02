import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/contracts/abs_moment_repository.dart';
import '../../repositories/databases/db_moment_repository.dart';

final repositoryProviders = [
  RepositoryProvider<AbsMomentRepository>(
      create: (context) => DbMomentRepository()),
];
