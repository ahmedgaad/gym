import 'package:flutter/material.dart';

Future<Object?> loadingDialog(BuildContext context) {
    return showGeneralDialog(
                        barrierDismissible: true,
                        barrierLabel: "loading",
                        context: context,
                        pageBuilder: (context, _, __) => Center(
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.94),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      );
  }