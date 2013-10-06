import sys
 
from PySide import QtCore
from PySide import QtGui
from PySide import QtDeclarative

Constants = {
    'CustomText': "Hey PySide!",
    'FontSize': 9.24,
    'Colors': {
        'Background': "#8ac852",
        'Foreground': "#00672a",
    },
    'BoldText': True,
    'Items': {
        'Count': 7,
        'Suffixes': ['A', 'B', 'C', 'D', 'E', 'F', 'G'],
    },
    'Step': { 'X': 5, 'Y': 10 },
}

app = QtGui.QApplication(sys.argv)
 
view = QtDeclarative.QDeclarativeView()
view.setResizeMode(QtDeclarative.QDeclarativeView.SizeRootObjectToView)

ctx = view.rootContext()
ctx.setContextProperty('C', Constants)

view.setSource('Constants.qml')
view.show()
 
sys.exit(app.exec_())