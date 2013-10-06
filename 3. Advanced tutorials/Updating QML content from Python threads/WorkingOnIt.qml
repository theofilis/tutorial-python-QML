import QtQuick 1.1

Rectangle {
    width: 300; height: 160

    function formatProgress(size, progress) {
        return "" + parseInt(progress*size/1024) +
            " KiB ("+parseInt(progress*100.) + "%)";
    }

    Text {
        x: progressBar.x; y: 20
        width: progressBar.width
        font.pixelSize: 11
        text: downloader.filename
        elide: Text.ElideRight
    }

    Rectangle {
        id: progressBar
        color: "#aaa"

        x: 20; y: 60
        width: parent.width-40
        height: 20

        Rectangle {
            color: downloader.progress<1?"#ee8":"#8e8"
            clip: true

            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }

            width: parent.width*downloader.progress

            Text {
                anchors {
                    fill: parent
                    rightMargin: 5
                }
                color: "black"
                text: formatProgress(downloader.size, downloader.progress)
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }
    }

    Rectangle {
        anchors.left: progressBar.left
        anchors.right: progressBar.right

        color: "#aad"
        y: progressBar.y + progressBar.height + 20
        height: 40

        Text {
            anchors.fill: parent
            color: "#003"
            text: downloader.running?"Please wait...":"Start download"

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        MouseArea {
            anchors.fill: parent
            onClicked: { downloader.start_download() }
        }
    }
}
