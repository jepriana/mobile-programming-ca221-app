part of 'moment_bloc.dart';

sealed class MomentEvent extends Equatable {
  const MomentEvent();

  @override
  List<Object> get props => [];
}

class MomentLoadEvent extends MomentEvent {}

class MomentNavigateToAddEvent extends MomentEvent {}

class MomentAddEvent extends MomentEvent {
  final Moment moment;
  const MomentAddEvent(this.moment);

  @override
  List<Object> get props => [moment];
}

class MomentNavigateToUpdateEvent extends MomentEvent {
  final String momentId;
  const MomentNavigateToUpdateEvent(this.momentId);

  @override
  List<Object> get props => [momentId];
}

class MomentUpdateEvent extends MomentEvent {
  final Moment moment;
  const MomentUpdateEvent(this.moment);

  @override
  List<Object> get props => [moment];
}

class MomentNavigateToDeleteEvent extends MomentEvent {
  final String momentId;
  const MomentNavigateToDeleteEvent(this.momentId);

  @override
  List<Object> get props => [momentId];
}

class MomentDeleteEvent extends MomentEvent {
  final String momentId;
  const MomentDeleteEvent(this.momentId);

  @override
  List<Object> get props => [momentId];
}

class MomentGetByIdEvent extends MomentEvent {
  final String momentId;
  const MomentGetByIdEvent(this.momentId);

  @override
  List<Object> get props => [momentId];
}

class MomentNavigateBackEvent extends MomentEvent {}
