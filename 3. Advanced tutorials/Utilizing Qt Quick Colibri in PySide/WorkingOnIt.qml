import QtQuick 1.1
import "colibri"

Rectangle {
    width: 200; height: 160

    Text {
        x: progressBar.x; y: 20
        width: progressBar.width
        font.pixelSize: 8
        text: downloader.filename
        elide: Text.ElideRight
    }


    CLProgressBar {
        id: progressBar
        x: 20; y: 60
        width: parent.width-40

        value: downloader.progress*100
    }


    CLButton {
        anchors.left: progressBar.left
        anchors.right: progressBar.right

        y: progressBar.y + progressBar.height + 20

        text: downloader.running?"Please wait...":"Start download"
        onClicked: { downloader.start_download() }
    }
}
