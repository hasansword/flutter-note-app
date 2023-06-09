import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/notes_cubit.dart';
import '../constants/custom_colors.dart';
import '../database/tables.dart';

class MainScreenWithContent extends StatelessWidget {
  const MainScreenWithContent({
    Key? key,
    required this.notes,
  }) : super(key: key);

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NotesCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: Dismissible(
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(
                        "Notu silmek istediğine emin misin?",
                        style: TextStyle(fontSize: 19),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: () => {
                            cubit.deleteNote(notes[index]),
                            Navigator.of(context).pop(true)
                          },
                          child: const Text(
                            "Sil",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text(
                            "İptal",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              background: Container(
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child:
                      Icon(Icons.delete_rounded, size: 36, color: Colors.white),
                ),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/show',
                    arguments: {'note': notes[index]}),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16.0),
                  color: Color(notes[index].color),
                  child: Text(
                    notes[index].title,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
