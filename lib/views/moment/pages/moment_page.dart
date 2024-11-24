import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/views/moment/widgets/post_item.dart';

import '../bloc/moment_bloc.dart';
import 'moment_entry_page.dart';

class MomentPage extends StatelessWidget {
  static const routeName = '/moment';

  const MomentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MomentBloc, MomentState>(
      listenWhen: (previous, current) => current is MomentActionState,
      // buildWhen: (previous, current) => current is! MomentActionState,
      listener: (context, state) {
        if (state is MomentNavigateToAddActionState) {
          Navigator.pushNamed(context, MomentEntryPage.routeName);
        } else if (state is MomentNavigateToUpdateActionState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Update Moment'),
                content:
                    const Text('Are you sure you want to update this moment?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(
                        context,
                        MomentEntryPage.routeName,
                        arguments: {'momentId': state.momentId},
                      );
                    },
                    child: const Text('Sure'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<MomentBloc>().add(MomentNavigateBackEvent());
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        } else if (state is MomentNavigateToDeleteActionState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Delete Moment'),
                content:
                    const Text('Are you sure you want to delete this moment?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context
                          .read<MomentBloc>()
                          .add(MomentDeleteEvent(state.momentId));
                    },
                    child: const Text('Sure'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<MomentBloc>().add(MomentNavigateBackEvent());
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        } else if (state is MomentAddedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Moment added successfully'),
            ),
          );
        } else if (state is MomentUpdatedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Moment updated successfully'),
            ),
          );
        } else if (state is MomentDeletedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Moment deleted successfully'),
            ),
          );
        } else if (state is MomentAddErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is MomentUpdateErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is MomentDeleteErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is MomentNavigateBackActionState) {
          Navigator.of(context).pop();
          context.read<MomentBloc>().add(MomentLoadEvent());
        }
      },
      builder: (context, state) {
        print(state.runtimeType);
        if (state is MomentLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MomentLoadedState) {
          return SingleChildScrollView(
            child: Column(
              children: state.moments
                  .map(
                    (momentItem) => PostItem(
                      moment: momentItem,
                    ),
                  )
                  .toList(),
            ),
          );
        }
        return Container();
      },
    );
  }
}
