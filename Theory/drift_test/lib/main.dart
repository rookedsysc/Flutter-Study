import 'package:drift/drift.dart' hide Column;
import 'package:drift_test/database/diary_dao.dart';
import 'package:drift_test/database/drift_database.dart';
import 'package:flutter/material.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:
        HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LocalDatabase db;
  late DiaryDao diaryDao;

  String title = '';
  String content = '';


  @override
  void initState() {
    db = LocalDatabase();
    diaryDao = DiaryDao(db);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Diary 등록 팝업
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                //Dialog Main Title
                title: Text("Dialog"),

                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // 저장 버튼 누르면 다이어리 저장
                      // TextFormField - 입력창
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: '제목을 입력하세요',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return '제목을 입력하세요';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          title = value!;
                          print('title : $title');
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: '내용을 입력하세요',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return '내용을 입력하세요';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          content = value!;
                          print('content : $content');
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("저장"),
                    onPressed: () async {
                      if(formKey.currentState == null) {
                        throw Exception("formKey.currentState is null");
                      }

                      // 오류가 없다면 실행하는 부분
                      if(formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        // 저장 버튼 누르면 다이어리 저장
                        diaryDao.createDiary(DiaryCompanion(
                          title: Value(title),
                          content: Value(content),
                          date: Value(DateTime.now()),
                        ));
                        print('저장 완료');
                        setState(() {});
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      body: StreamBuilder<List<DiaryData>>(
        stream: diaryDao.watchAllDiaries(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {

            final diaries = snapshot.data;

            return ListView.builder(
              itemCount: diaries!.length,
              itemBuilder: (context, index) {
                final diary = diaries[index];
                return ListTile(
                  title: Text(diary.title),
                  subtitle: Text(diary.content),

                );
              },
            );
          } else {
            return const Center(child: Text("No data"));
          }
        }
      ),
    );
  }
}
