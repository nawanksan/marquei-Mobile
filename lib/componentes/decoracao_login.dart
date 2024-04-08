import 'package:flutter/material.dart';

InputDecoration getAuthenticationInputDecoration(String label) {
  return InputDecoration(
    label: Text(label),
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFF0053CC) ,
      ),
      borderRadius: BorderRadius.circular(5),
    
    ), 
    
    
    
  );
}