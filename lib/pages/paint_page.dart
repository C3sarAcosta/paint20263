import 'package:flutter/material.dart';
import 'package:paint20263/models/drawn_line.dart';
import 'package:paint20263/widgets/paint_canvas.dart';
import 'package:paint20263/widgets/paint_toolbar.dart';

class PaintPage extends StatefulWidget {
  const PaintPage({super.key});

  @override
  State<PaintPage> createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  final List<DrawnLine> _lines = [];
  Color _selectedColor = Colors.black;
  double _selectedWidth = 5.0;

  void _onPanStart(Offset position) {
    setState(() {
      _lines.add(
        DrawnLine(
          points: [position],
          color: _selectedColor,
          strokeWidth: _selectedWidth
        )
      );
    });
  }

  void _onPanUpdate(Offset position){
    setState(() {
      if(_lines.isNotEmpty){
        _lines.last.points.add(position);
      }
    });
  }

  void _clearCanvas(){
    setState(() {
      _lines.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pinturilla"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Limpiar Lienzo',
            onPressed: _clearCanvas,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PaintCanvasWidget(
              lines: _lines, 
              onPanStart: _onPanStart, 
              onPanUpdate: _onPanUpdate
            ),
          ),
          PaintToolbar(
          selectedColor: _selectedColor,
          selectedWidth: _selectedWidth,
          onColorSelected: (color) => setState(() => _selectedColor = color),
          onWidthChanged: (width) => setState(() => _selectedWidth = width)
        )
        ],
      ),
    );
  }
}