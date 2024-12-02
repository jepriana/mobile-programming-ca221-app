import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/contracts/abs_moment_repository.dart';
import '../../views/moment/bloc/moment_bloc.dart';

final blocProviders = [
  BlocProvider<MomentBloc>(
    create: (context) =>
        MomentBloc(RepositoryProvider.of<AbsMomentRepository>(context)),
  ),
];
