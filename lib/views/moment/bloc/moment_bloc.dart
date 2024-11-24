import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:nanoid2/nanoid2.dart';
import 'package:faker/faker.dart' as faker;

import '../../../models/moment.dart';

part 'moment_event.dart';
part 'moment_state.dart';

class MomentBloc extends Bloc<MomentEvent, MomentState> {
  final _faker = faker.Faker();
  List<Moment> moments = [];

  MomentBloc() : super(MomentInitial()) {
    moments = List.generate(
      2,
      (index) => Moment(
        id: nanoid(),
        momentDate: _faker.date.dateTime(),
        creator: _faker.person.name(),
        location: _faker.address.city(),
        imageUrl: 'https://picsum.photos/800/600?random=$index',
        caption: _faker.lorem.sentence(),
        likeCount: faker.random.integer(1000),
        commentCount: faker.random.integer(100),
        bookmarkCount: faker.random.integer(10),
      ),
    );
    on<MomentLoadEvent>(momentLoadEvent);
    on<MomentGetByIdEvent>(momentGetByIdEvent);
    on<MomentAddEvent>(momentAddEvent);
    on<MomentNavigateToAddEvent>(momentNavigateToAddEvent);
    on<MomentUpdateEvent>(momentUpdateEvent);
    on<MomentNavigateToUpdateEvent>(momentNavigateToUpdateEvent);
    on<MomentDeleteEvent>(momentDeleteEvent);
    on<MomentNavigateToDeleteEvent>(momentNavigateToDeleteEvent);
    on<MomentNavigateBackEvent>(momentNavigateBackEvent);
  }

  FutureOr<void> momentLoadEvent(
      MomentLoadEvent event, Emitter<MomentState> emit) {
    emit(const MomentLoadingState());
    emit(MomentLoadedState(moments));
  }

  FutureOr<void> momentGetByIdEvent(
      MomentGetByIdEvent event, Emitter<MomentState> emit) {
    emit(MomentGettingByIdState());
    final result =
        moments.firstWhereOrNull((moment) => moment.id == event.momentId);
    if (result != null) {
      emit(MomentGetByIdSuccessActionState(result));
    } else {
      emit(const MomentGetByIdNotFoundActionState());
    }
  }

  FutureOr<void> momentAddEvent(
      MomentAddEvent event, Emitter<MomentState> emit) {
    emit(MomentAddingActionState());
    moments.add(event.moment);
    emit(MomentAddedActionState(event.moment));
    emit(MomentLoadedState(moments));
  }

  FutureOr<void> momentNavigateToAddEvent(
      MomentNavigateToAddEvent event, Emitter<MomentState> emit) {
    emit(MomentNavigateToAddActionState());
  }

  FutureOr<void> momentUpdateEvent(
      MomentUpdateEvent event, Emitter<MomentState> emit) {
    emit(MomentUpdatingState());
    final index = moments.indexWhere((moment) => moment.id == event.moment.id);
    if (index >= 0) {
      moments[index] = event.moment;
      emit(MomentUpdatedActionState(event.moment));
      emit(MomentLoadedState(moments));
    } else {
      emit(const MomentUpdateErrorActionState("Moment not found"));
    }
  }

  FutureOr<void> momentNavigateToUpdateEvent(
      MomentNavigateToUpdateEvent event, Emitter<MomentState> emit) {
    emit(MomentNavigateToUpdateActionState(event.momentId));
  }

  FutureOr<void> momentDeleteEvent(
      MomentDeleteEvent event, Emitter<MomentState> emit) {
    emit(MomentDeletingState());
    final index = moments.indexWhere((moment) => moment.id == event.momentId);
    if (index >= 0) {
      moments.removeAt(index);
      emit(const MomentDeletedActionState());
      emit(MomentLoadedState(moments));
    } else {
      emit(const MomentDeleteErrorActionState("Moment not found"));
    }
  }

  FutureOr<void> momentNavigateToDeleteEvent(
      MomentNavigateToDeleteEvent event, Emitter<MomentState> emit) {
    emit(MomentNavigateToDeleteActionState(event.momentId));
  }

  FutureOr<void> momentNavigateBackEvent(
      MomentNavigateBackEvent event, Emitter<MomentState> emit) {
    emit(MomentNavigateBackActionState());
  }
}
