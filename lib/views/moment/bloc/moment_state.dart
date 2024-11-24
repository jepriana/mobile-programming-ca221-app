part of 'moment_bloc.dart';

sealed class MomentState extends Equatable {
  const MomentState();

  @override
  List<Object> get props => [];
}

abstract class MomentActionState extends MomentState {
  const MomentActionState();

  @override
  List<Object> get props => [];
}

class MomentLoadingState extends MomentState {
  const MomentLoadingState();

  @override
  List<Object> get props => [];
}

final class MomentInitial extends MomentState {}

final class MomentLoadErrorActionState extends MomentActionState {
  final String message;
  const MomentLoadErrorActionState(this.message);

  @override
  List<Object> get props => [message];
}

final class MomentLoadedState extends MomentState {
  final List<Moment> moments;
  const MomentLoadedState(this.moments);

  @override
  List<Object> get props => [moments];
}

final class MomentAddingActionState extends MomentLoadingState {}

final class MomentAddErrorActionState extends MomentActionState {
  final String message;
  const MomentAddErrorActionState(this.message);

  @override
  List<Object> get props => [message];
}

final class MomentAddedActionState extends MomentActionState {
  final Moment moment;
  const MomentAddedActionState(this.moment);

  @override
  List<Object> get props => [moment];
}

final class MomentUpdatingState extends MomentLoadingState {}

final class MomentUpdateErrorActionState extends MomentActionState {
  final String message;
  const MomentUpdateErrorActionState(this.message);

  @override
  List<Object> get props => [message];
}

final class MomentUpdatedActionState extends MomentActionState {
  final Moment moment;
  const MomentUpdatedActionState(this.moment);

  @override
  List<Object> get props => [moment];
}

final class MomentDeletingState extends MomentLoadingState {}

final class MomentDeleteErrorActionState extends MomentActionState {
  final String message;
  const MomentDeleteErrorActionState(this.message);

  @override
  List<Object> get props => [message];
}

final class MomentDeletedActionState extends MomentActionState {
  const MomentDeletedActionState();
}

final class MomentGettingByIdState extends MomentLoadingState {}

final class MomentGetByIdErrorActionState extends MomentActionState {
  final String message;
  const MomentGetByIdErrorActionState(this.message);

  @override
  List<Object> get props => [message];
}

final class MomentGetByIdSuccessActionState extends MomentActionState {
  final Moment moment;
  const MomentGetByIdSuccessActionState(this.moment);

  @override
  List<Object> get props => [moment];
}

final class MomentGetByIdNotFoundActionState extends MomentActionState {
  const MomentGetByIdNotFoundActionState();
}

final class MomentNavigateToAddActionState extends MomentActionState {}

final class MomentNavigateToUpdateActionState extends MomentActionState {
  final String momentId;
  const MomentNavigateToUpdateActionState(this.momentId);

  @override
  List<Object> get props => [momentId];
}

final class MomentNavigateToDeleteActionState extends MomentActionState {
  final String momentId;
  const MomentNavigateToDeleteActionState(this.momentId);

  @override
  List<Object> get props => [momentId];
}

final class MomentNavigateBackActionState extends MomentActionState {}
