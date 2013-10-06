import sys
import time
import json
 
from PySide import QtGui, QtDeclarative

def sendData(data):
    global rootObject
    print 'Sending data:', data
    json_str = json.dumps(data).replace('"', '\\"')
    rootObject.evaluateJavaScript('receiveJSON("%s")' % json_str)
 
def receiveData(json_str):
    global rootObject
 
    data = json.loads(json_str)
    print 'Received data:', data
 
    if len(data) == 2 and data[0] == 'setRotation':
        rootObject.setProperty('rotation', data[1])
    else:
        sendData({'Hello': 'from PySide', 'itsNow': int(time.time())})

app = QtGui.QApplication(sys.argv)
 
view = QtDeclarative.QDeclarativeView()
view.setRenderHints(QtGui.QPainter.SmoothPixmapTransform)
view.setSource(__file__.replace('.py', '.qml'))
rootObject = view.rootObject()
rootObject.setProperty('url', __file__.replace('.py', '.html'))
rootObject.alert.connect(receiveData)
view.show()
 
app.exec_()