import os
import sys
import threading
import urllib
 
from PySide import QtCore, QtGui, QtDeclarative

class Downloader(QtCore.QObject):
    def __init__(self, url, filename=None):
        QtCore.QObject.__init__(self)
        self._url = url
        if filename is None:
            filename = os.path.basename(self._url)
        self._filename = filename
        self._progress = 0.
        self._running = False
        self._size = -1
 
    def _download(self):
        def reporthook(pos, block, total):
            if self.size != total:
                self._size = total
                self.on_size.emit()
            self.progress = float(pos*block)/float(total)
        urllib.urlretrieve(self._url, self._filename, reporthook)
        self.running = False
 
    @QtCore.Slot()
    def start_download(self):
        if not self.running:
            self.running = True
            thread = threading.Thread(target=self._download)
            thread.start()
 
    def _get_progress(self):
        return self._progress
 
    def _set_progress(self, progress):
        self._progress = progress
        self.on_progress.emit()
 
    def _get_running(self):
        return self._running
 
    def _set_running(self, running):
        self._running = running
        self.on_running.emit()
 
    def _get_filename(self):
        return self._filename
 
    def _get_size(self):
        return self._size
 
    on_progress = QtCore.Signal()
    on_running = QtCore.Signal()
    on_filename = QtCore.Signal()
    on_size = QtCore.Signal()
 
    progress = QtCore.Property(float, _get_progress, _set_progress,
            notify=on_progress)
    running = QtCore.Property(bool, _get_running, _set_running,
            notify=on_running)
    filename = QtCore.Property(str, _get_filename, notify=on_filename)
    size = QtCore.Property(int, _get_size, notify=on_size)

downloader = Downloader('http://repo.meego.com/MeeGo/builds/trunk/1.1.80.8.20101130.1/handset/images/meego-handset-armv7l-n900/meego-handset-armv7l-n900-1.1.80.8.20101130.1-vmlinuz-2.6.35.3-13.6-n900')

app = QtGui.QApplication(sys.argv)
view = QtDeclarative.QDeclarativeView()
view.rootContext().setContextProperty('downloader', downloader)
view.setSource(__file__.replace('.py', '.qml'))
view.show()
app.exec_()