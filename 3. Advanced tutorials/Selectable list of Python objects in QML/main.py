import sys
 
from PySide import QtCore
from PySide import QtGui
from PySide import QtDeclarative
from PySide import QtOpenGL

class ThingWrapper(QtCore.QObject):
    def __init__(self, thing):
        QtCore.QObject.__init__(self)
        self._thing = thing
 
    def _name(self):
        return str(self._thing)
 
    changed = QtCore.Signal()
 
    name = QtCore.Property(unicode, _name, notify=changed)

class ThingListModel(QtCore.QAbstractListModel):
    COLUMNS = ('thing',)
 
    def __init__(self, things):
        QtCore.QAbstractListModel.__init__(self)
        self._things = things
        self.setRoleNames(dict(enumerate(ThingListModel.COLUMNS)))
 
    def rowCount(self, parent=QtCore.QModelIndex()):
        return len(self._things)
 
    def data(self, index, role):
        if index.isValid() and role == ThingListModel.COLUMNS.index('thing'):
            return self._things[index.row()]
        return None

class Controller(QtCore.QObject):
    @QtCore.Slot(QtCore.QObject)
    def thingSelected(self, wrapper):
        print 'User clicked on:', wrapper._thing.name
        if wrapper._thing.number > 10:
            print 'The number is greater than ten!'

class Person(object):
    def __init__(self, name, number):
        self.name = name
        self.number = number
 
    def __str__(self):
        return 'Person "%s" (%d)' % (self.name, self.number)
 
if __name__ == '__main__':
	app = QtGui.QApplication(sys.argv)
 
	m = QtGui.QMainWindow()
	 
	view = QtDeclarative.QDeclarativeView()
	glw = QtOpenGL.QGLWidget()
	view.setViewport(glw)
	view.setResizeMode(QtDeclarative.QDeclarativeView.SizeRootObjectToView)

	people = [
	        Person('Locke', 4),
	        Person('Reyes', 8),
	        Person('Ford', 15),
	        Person('Jarrah', 16),
	        Person('Shephard', 23),
	        Person('Kwon', 42),
	]


	things = [ThingWrapper(thing) for thing in people]

	controller = Controller()
	thingList = ThingListModel(things)
	 
	rc = view.rootContext()
	 
	rc.setContextProperty('controller', controller)
	rc.setContextProperty('pythonListModel', thingList)
	 
	view.setSource('view.qml')

	m.setCentralWidget(view)
 
	m.show()
	 
	app.exec_()