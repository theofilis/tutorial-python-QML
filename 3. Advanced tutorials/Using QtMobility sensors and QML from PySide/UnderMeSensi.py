import sys
 
from PySide import QtCore, QtGui, QtDeclarative, QtOpenGL
from QtMobility import Sensors

class Listener(QtCore.QObject):
    def __init__(self):
        QtCore.QObject.__init__(self)
        self._initial = True
        self._rotation = 0.
 
    def get_rotation(self):
        return self._rotation
 
    def set_rotation(self, rotation):
        if self._initial:
            self._rotation = rotation
            self._initial = False
        else:
            # Smooth the accelermeter input changes
            self._rotation *= .8
            self._rotation += .2*rotation
 
        self.on_rotation.emit()
 
    on_rotation = QtCore.Signal()
    rotation = QtCore.Property(float, get_rotation, set_rotation, \
            notify=on_rotation)
 
    @QtCore.Slot()
    def on_reading_changed(self):
        accel = self.sender()
        # Scale the x axis reading to keep the image roughly steady
        self.rotation = accel.reading().x()*7

app = QtGui.QApplication(sys.argv)
 
accel = Sensors.QAccelerometer()
listener = Listener()
accel.readingChanged.connect(listener.on_reading_changed)
accel.start()
 
view = QtDeclarative.QDeclarativeView()
glw = QtOpenGL.QGLWidget()
view.setViewport(glw)
view.setResizeMode(QtDeclarative.QDeclarativeView.SizeRootObjectToView)
view.rootContext().setContextProperty('listener', listener)
view.setSource(__file__.replace('.py', '.qml'))
view.showFullScreen()
 
app.exec_()