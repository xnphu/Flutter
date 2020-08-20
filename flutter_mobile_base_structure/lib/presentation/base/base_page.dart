import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/app/application_bloc.dart';

import '../app/application_bloc.dart';
import 'base_bloc.dart';
import 'base_page_mixin.dart';

import 'package:flutter_mobile_base_structure/app_injector.dart';

import 'base_router.dart';
export 'package:flutter_mobile_base_structure/app_injector.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_mobile_base_structure/presentation/resources/icons/app_images.dart';
export 'package:flutter_mobile_base_structure/presentation/styles/styles.dart';
export 'package:flutter_mobile_base_structure/presentation/widgets/index.dart';

abstract class BasePage<T extends BaseBloc<dynamic, dynamic>>
    extends StatefulWidget {
  BasePage({Key key, this.bloc, this.router}) : super(key: key);

  final BaseBloc bloc;
  final BaseRouter router;
}

abstract class BasePageState<
    T extends BaseBloc<BaseEvent, BaseState>,
    P extends BasePage,
    R extends BaseRouter> extends State<P> with BasePageMixin {
  BaseBloc bloc;
  BuildContext subContext;
  BaseRouter router;
  ApplicationBloc applicationBloc;

  @override
  void didChangeDependencies() {
    bloc?.dispatchEvent(PageDidChangeDependenciesEvent(context: context));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    bloc = widget.bloc ?? injector.get<T>();
    bloc?.dispatchEvent(PageInitStateEvent(context: context));
    router = widget.router ?? injector.get<R>();
    applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    // applicationBloc.dispatchEvent((LoadingEvent()));
    super.initState();
  }

  Widget buildBody(BuildContext context, BaseBloc bloc);

  void stateListenerCallBack(BaseState state) {
    if (state is ErrorState) {
      print(' stateListenerCallBack  ${state.messageError}');
      showSnackBarMessage(state.messageError, subContext);
    }
  }

  _onResult(dynamic res) {
    if (res != null) {
      bloc?.dispatchEvent(OnResultEvent(result: res));
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc?.dispatchEvent(PageBuildEvent(context: context));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<BaseBloc, BaseState>(listener: (bloc, state) async {
          stateListenerCallBack(state);
          final res = await router?.onNavigate(context: context, state: state);
          _onResult(res);
        }, child: LayoutBuilder(builder: (sub, _) {
          subContext = sub;
          return buildBody(subContext, bloc);
        })),
      ),
    );
  }

  @override
  dispose() {
    bloc.dispose();
    super.dispose();
  }
}
