import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myapp/core/resources/dimentions.dart';
import 'package:myapp/views/moment/bloc/moment_bloc.dart';
import 'package:nanoid2/nanoid2.dart';

import '../../../models/moment.dart';
import '../../../core/resources/colors.dart';

class MomentEntryPage extends StatefulWidget {
  static const routeName = '/moment/entry';
  const MomentEntryPage({
    super.key,
    this.momentId,
  });

  final String? momentId;

  @override
  State<MomentEntryPage> createState() => _MomentEntryPageState();
}

class _MomentEntryPageState extends State<MomentEntryPage> {
  // Membuat object form global key
  final _formKey = GlobalKey<FormState>();
  final _dataMoment = {};
  // Text Editing Controller untuk set nilai awal pada text field
  final _momentDateController = TextEditingController();
  final _creatorController = TextEditingController();
  final _locationController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _captionController = TextEditingController();
  // Date Format
  final _dateFormat = DateFormat('yyyy-MM-dd');
  late DateTime _selectedDate;
  Moment? _selectedMoment;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    if (widget.momentId != null) {
      context.read<MomentBloc>().add(MomentGetByIdEvent(widget.momentId!));
    }
  }

  // Membuat method untuk menyimpan data moment
  void _saveMoment() {
    if (_formKey.currentState!.validate()) {
      // Menyimpan data inputan pengguna ke map _dataMoment
      _formKey.currentState!.save();
      // Membuat object moment baru
      final moment = Moment(
        id: widget.momentId ??
            nanoid(), // Gunakan ID yang ada jika operasi update, jika tidak ada, buat ID baru
        momentDate: _dataMoment['momentDate'],
        creator: _dataMoment['creator'],
        location: _dataMoment['location'],
        imageUrl: _dataMoment['imageUrl'],
        caption: _dataMoment['caption'],
        likeCount: _selectedMoment?.likeCount ?? 0,
        commentCount: _selectedMoment?.commentCount ?? 0,
        bookmarkCount: _selectedMoment?.bookmarkCount ?? 0,
      );
      // Menyimpan object moment ke list _moments
      if (widget.momentId == null) {
        context.read<MomentBloc>().add(MomentAddEvent(moment));
      } else {
        context.read<MomentBloc>().add(MomentUpdateEvent(moment));
      }
      // Menutup halaman create moment
      Navigator.of(context).pop();
    }
  }

  void _pickDate() async {
    final todayDate = DateTime.now();
    final firstDate = todayDate.subtract(const Duration(days: 365));
    final lastDate = todayDate.add(const Duration(days: 0));
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: _selectedDate.isAfter(lastDate) ? null : _selectedDate,
    );
    if (selectedDate != null) {
      _momentDateController.text = _dateFormat.format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.read<MomentBloc>().add(MomentNavigateBackEvent()),
        ),
        title: Text('${widget.momentId == null ? 'Create' : 'Update'} Moment'),
      ),
      body: BlocConsumer<MomentBloc, MomentState>(
        listener: (context, state) {
          if (state is MomentGetByIdSuccessActionState) {
            _selectedMoment = state.moment;
            _momentDateController.text =
                _dateFormat.format(_selectedMoment!.momentDate);
            _creatorController.text = _selectedMoment!.creator;
            _locationController.text = _selectedMoment!.location;
            _imageUrlController.text = _selectedMoment!.imageUrl;
            _captionController.text = _selectedMoment!.caption;
            _selectedDate = _selectedMoment!.momentDate;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(largeSize),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Moment Date'),
                    TextFormField(
                      controller: _momentDateController,
                      onTap: _pickDate,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        hintText: 'Select Date',
                        prefixIcon: const Icon(Icons.calendar_month),
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter moment date in format yyyy-MM-dd';
                        } else if (DateTime.tryParse(value) == null) {
                          return 'Please enter valid moment date in format yyyy-MM-dd';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          _dataMoment['momentDate'] =
                              DateTime.tryParse(newValue) ?? DateTime.now();
                        }
                      },
                    ),
                    const Text('Creator'),
                    TextFormField(
                      controller: _creatorController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        hintText: 'Moment creator',
                        prefixIcon: const Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter moment creator';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          _dataMoment['creator'] = newValue;
                        }
                      },
                    ),
                    const Text('Location'),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        hintText: 'Moment location',
                        prefixIcon: const Icon(Icons.location_pin),
                      ),
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter moment location';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          _dataMoment['location'] = newValue;
                        }
                      },
                    ),
                    const Text('Image URL'),
                    TextFormField(
                      controller: _imageUrlController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        hintText: 'Moment image URL',
                        prefixIcon: const Icon(Icons.image),
                      ),
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter moment image URL';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          _dataMoment['imageUrl'] = newValue;
                        }
                      },
                    ),
                    const Text('Caption'),
                    TextFormField(
                      controller: _captionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        hintText: 'Moment description',
                        prefixIcon: const Icon(Icons.note),
                      ),
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter moment caption';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          _dataMoment['caption'] = newValue;
                        }
                      },
                    ),
                    const SizedBox(height: largeSize),
                    SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: _saveMoment,
                        child: const Text('Save'),
                      ),
                    ),
                    const SizedBox(height: mediumSize),
                    SizedBox(
                      height: 50.0,
                      child: OutlinedButton(
                        onPressed: () {
                          context
                              .read<MomentBloc>()
                              .add(MomentNavigateBackEvent());
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
