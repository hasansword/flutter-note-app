import 'package:app_client/blocs/notes_color_cubit.dart';
import 'package:app_client/blocs/notes_color_state.dart';
import 'package:app_client/blocs/notes_cubit.dart';
import 'package:app_client/constants/custom_colors.dart';
import 'package:app_client/ui/appbar/add_note_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteAddScreen extends StatelessWidget {
  NoteAddScreen({super.key});

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var notesCubit = context.read<NotesCubit>();
    var colorCubit = context.read<NotesColorCubit>();

    return StreamBuilder<NotesColorState>(
        initialData: colorCubit.state,
        stream: colorCubit.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AddNoteAppBar(
              color: colorCubit.state.noteColor,
              onSavePress: () => saveNote(notesCubit, colorCubit, context),
              onColorChangePress: () => changeColor(context, colorCubit),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      
                      decoration: const InputDecoration(
                        hintText: 'Başlık',
                        fillColor: Colors.black12,
                      ),
                      style: const TextStyle(fontSize: 38),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _bodyController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Açıklama Yaz...',
                        fillColor: Colors.black12,
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> changeColor(BuildContext context, NotesColorCubit colorCubit) {
    return showDialog(
      context: context,
      builder: (context) => StreamBuilder<NotesColorState>(
          initialData: colorCubit.state,
          stream: colorCubit.stream,
          builder: (context, snapshot) {
            return AlertDialog(
              content: SizedBox(
                width: 210,
                height: 110,
                child: GridView.builder(
                  itemCount: CustomColors.colorsData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () => {
                          colorCubit.changeColor(
                              CustomColors.colorsData[index].value),
                          Navigator.pop(context)
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Ink(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            color: CustomColors.colorsData[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }

  void saveNote(
      NotesCubit cubit, NotesColorCubit colorCubit, BuildContext context) {
    if (_titleController.text.isNotEmpty && _bodyController.text.isNotEmpty) {
      cubit.addNote(_titleController.text, _bodyController.text,
          colorCubit.state.noteColor);
      Navigator.pop(context);
    }
  }
}
