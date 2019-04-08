import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:signature/signature.dart';

class FormBuilderSignaturePad extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final Image initialValue;
  final bool readonly;
  final InputDecoration decoration;
  final ValueTransformer valueTransformer;

  final List<Point> points;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color penColor;
  final double penStrokeWidth;
  final String clearButtonText;

  FormBuilderSignaturePad({
    @required this.attribute,
    this.validators = const [],
    this.readonly = false,
    this.decoration = const InputDecoration(),
    this.backgroundColor = Colors.white,
    this.penColor = Colors.black,
    this.penStrokeWidth = 3.0,
    this.clearButtonText = "Clear",
    this.initialValue,
    this.points,
    this.width,
    this.height = 200,
    this.valueTransformer,
  });

  @override
  _FormBuilderSignaturePadState createState() =>
      _FormBuilderSignaturePadState();
}

class _FormBuilderSignaturePadState extends State<FormBuilderSignaturePad> {
  bool _readonly = false;

  @override
  void initState() {
    _readonly =
        (FormBuilder.of(context)?.readonly == true) ? true : widget.readonly;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _signatureCanvas = Signature(
      points: widget.points,
      width: widget.width,
      height: widget.height,
      backgroundColor: widget.backgroundColor,
      penColor: widget.penColor,
      penStrokeWidth: widget.penStrokeWidth,
    );

    return FormField<Image>(
      key: Key(widget.attribute),
      enabled: !_readonly,
      initialValue: widget.initialValue,
      validator: (val) {
        for (int i = 0; i < widget.validators.length; i++) {
          if (widget.validators[i](val) != null)
            return widget.validators[i](val);
        }
      },
      onSaved: (val) async {
        Uint8List signature = await _signatureCanvas.exportBytes();
        var image = Image.memory(signature).image;
        var transformed = image;
        if (widget.valueTransformer != null)
          transformed = widget.valueTransformer(val);
        FormBuilder.of(context)
            ?.setAttributeValue(widget.attribute, transformed);
      },
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !_readonly,
            errorText: field.errorText,
          ),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: GestureDetector(
                  onVerticalDragUpdate: (_) {},
                  child: _signatureCanvas,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  FlatButton.icon(
                    onPressed: () {
                      _signatureCanvas.clear();
                      field.didChange(null);
                    },
                    label: Text(
                      widget.clearButtonText,
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}