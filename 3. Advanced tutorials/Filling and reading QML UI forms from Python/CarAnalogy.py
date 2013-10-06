import sys
 
from PySide import QtCore, QtGui, QtDeclarative

class Car(QtCore.QObject):
    def __init__(self, model='', brand='', year=0, in_stock=False):
        QtCore.QObject.__init__(self)
        self.__model = model
        self.__brand = brand
        self.__year = year
        self.__in_stock = in_stock
 
    changed = QtCore.Signal()
 
    def _model(self): return self.__model
    def _brand(self): return self.__brand
    def _year(self): return self.__year
    def _inStock(self): return self.__in_stock
 
    def _setModel(self, model):
        self.__model = model
        self.changed.emit()
 
    def _setBrand(self, brand):
        self.__brand = brand
        self.changed.emit()
 
    def _setYear(self, year):
        self.__year = year
        self.changed.emit()
 
    def _setInStock(self, in_stock):
        self.__in_stock = in_stock
        self.changed.emit()
 
    model = QtCore.Property(str, _model, _setModel, notify=changed)
    brand = QtCore.Property(str, _brand, _setBrand, notify=changed)
    year = QtCore.Property(int, _year, _setYear, notify=changed)
    inStock = QtCore.Property(bool, _inStock, _setInStock, notify=changed)

class Controller(QtCore.QObject):
    def __init__(self, lst):
        QtCore.QObject.__init__(self)
        self._lst = lst
        self._pos = 0
 
    def fill(self, widgets):
        widgets['model'].setProperty('text', self._lst[self._pos].model)
        widgets['brand'].setProperty('text', self._lst[self._pos].brand)
        widgets['year'].setProperty('value', self._lst[self._pos].year)
        widgets['inStock'].setProperty('checked', self._lst[self._pos].inStock)
        widgets['position'].setProperty('text', '%d/%d' % (self._pos+1, len(self._lst)))
 
    @QtCore.Slot(QtCore.QObject)
    def prev(self, root):
        print 'prev'
        self._pos = max(0, self._pos - 1)
        self.fill(root.property('widgets'))
 
    @QtCore.Slot(QtCore.QObject)
    def next(self, root):
        print 'next'
        self._pos = min(len(self._lst) - 1, self._pos + 1)
        self.fill(root.property('widgets'))
 
    @QtCore.Slot(QtCore.QObject)
    def init(self, root):
        print 'init'
        self.fill(root.property('widgets'))

cars = [
        Car('Model T', 'Ford', 1908),
        Car('Beetle', 'Volkswagen', 1938, True),
        Car('Corolla', 'Toyota', 1966),
        Car('Clio', 'Renault', 1991, True),
        Car('Ambassador', 'Hindustan', 1958),
        Car('Uno', 'Fiat', 1983, True),
        Car('Ibiza', 'Seat', 1984, True),
]

controller = Controller(cars)
 
app = QtGui.QApplication(sys.argv)
 
view = QtDeclarative.QDeclarativeView()
view.setResizeMode(QtDeclarative.QDeclarativeView.SizeRootObjectToView)
 
ctx = view.rootContext()
 
for name in ('controller', 'cars'):
    ctx.setContextProperty(name, locals()[name])
 
view.setSource(__file__.replace('.py', '.qml'))
view.show()
 
app.exec_()