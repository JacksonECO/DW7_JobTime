import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonWithLoader<B extends StateStreamable<S>, S> extends ElevatedButton {
  final BlocWidgetSelector<S, bool>? selector;
  final S? selectorStatusLoading;
  final B block;
  final String label;

  ButtonWithLoader({
    this.selector,
    this.selectorStatusLoading,
    required this.block,
    required this.label,
    required super.onPressed,
    super.key,
  })  : assert(selector != null || selectorStatusLoading != null),
        super(
          child: BlocSelector<B, S, bool>(
            bloc: block,
            selector: selector ?? (state) => state == selectorStatusLoading!,
            builder: (context, loading) {
              if (!loading) {
                return Text(label);
              }
              return Stack(
                alignment: Alignment.center,
                children: [
                  Text(label),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                        strokeWidth: 3.5,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
}
