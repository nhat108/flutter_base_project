import 'package:minakomi/blocs/auth/auth_bloc.dart';
import 'package:minakomi/test/bloc/bloc/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minakomi/export.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../app.dart';
import '../../utils/theme_manager.dart';

class AuthInit extends StatefulWidget {
  @override
  _AuthInitState createState() => _AuthInitState();
}

class _AuthInitState extends State<AuthInit> {
  final ListBloc listBloc = ListBloc();
  final RefreshController refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (BlocProvider.of<AuthBloc>(context).state.themeData ==
              ThemeManager().lightTheme) {
            BlocProvider.of<AuthBloc>(context)
                .add(AuthChangeTheme(theme: AppConstrants.darkTheme));
          } else {
            BlocProvider.of<AuthBloc>(context)
                .add(AuthChangeTheme(theme: AppConstrants.lightTheme));
          }
        },
      ),
      body: Center(
        child: GestureDetector(
            onTap: () {
              NavigationService.instance.push(Test());
            },
            child: Text(
              'zxc',
              style: AppStyles.textSize20(color: AppColors.whiteColor),
            )),
      ),
      // body: BlocListener<ListBloc, ListState>(
      //   bloc: listBloc,
      //   listener: (context, state) {
      //     if (state.getListLoading == false) {
      //       refreshController.refreshCompleted();
      //     }
      //   },
      //   child: BlocBuilder<ListBloc, ListState>(
      //     bloc: listBloc,
      //     builder: (_, state) {
      //       return AppListViewBloc(
      //         separator: SizedBox(height: 10),
      //         isLoading: state.getListLoading!,
      //         error: state.getListError!,
      //         itemCount: state.list?.results?.length ?? 0,
      //         itemBuilder: (_, index) {
      //           final item = state.list!.results![index];
      //           return Container(
      //             color: Colors.red,
      //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //             child: Text("#${index + 1} ${item.name}"),
      //           );
      //         },
      //         onRefresh: () {
      //           listBloc.add(GetList(isLoadMore: false));
      //         },
      //         onLoadMore: () {
      //           listBloc.add(GetList(isLoadMore: true));
      //         },
      //         hasReachedMax: state.list?.hasReachedMax ?? true,
      //       );
      //     },
      //   ),
      // ),
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (BlocProvider.of<AuthBloc>(context).state.themeData ==
              ThemeManager().lightTheme) {
            BlocProvider.of<AuthBloc>(context)
                .add(AuthChangeTheme(theme: AppConstrants.darkTheme));
          } else {
            BlocProvider.of<AuthBloc>(context)
                .add(AuthChangeTheme(theme: AppConstrants.lightTheme));
          }
          // await Future.delayed(Duration(milliseconds: 500));
          RestartWidget.restartApp(context);
          setState(() {});
        },
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            NavigationService.instance.push(Test2());
          },
          child: Text(
            "FJOWFJIOWJFOEJF",
            style: AppStyles.textSize24(context: context),
          ),
        ),
      ),
    );
  }
}

class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (BlocProvider.of<AuthBloc>(context).state.themeData ==
              ThemeManager().lightTheme) {
            BlocProvider.of<AuthBloc>(context)
                .add(AuthChangeTheme(theme: AppConstrants.darkTheme));
          } else {
            BlocProvider.of<AuthBloc>(context)
                .add(AuthChangeTheme(theme: AppConstrants.lightTheme));
          }
          RestartWidget.restartApp(context);
          setState(() {});
          // await Future.delayed(Duration(milliseconds: 700));
          // setState(() {});
          // Navigator.popUntil(context, (route) => route.isFirst);
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (_) => AuthInit()));
        },
      ),
      body: Center(
        child: Text(
          "Page3 ",
          style: AppStyles.textSize24(context: context),
        ),
      ),
    );
  }
}
