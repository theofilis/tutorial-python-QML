#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import sys
from PySide.QtCore import *
from PySide.QtGui import *
from PySide.QtDeclarative import *
 
# Our main window
class MainWindow(QDeclarativeView):
   
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.setWindowTitle("Basic Types")
        # Renders 'view.qml'
        self.setSource(QUrl.fromLocalFile('view.qml'))
        # QML resizes to main window
        self.setResizeMode(QDeclarativeView.SizeRootObjectToView)
 
 
if __name__ == '__main__':
    # Create the Qt Application
    app = QApplication(sys.argv)
    # Create and show the main window
    window = MainWindow()
    window.show()
    # Run the main Qt loop
    sys.exit(app.exec_())