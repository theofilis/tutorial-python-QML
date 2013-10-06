import QtQuick 1.1

ListView {
    id: pythonList
    width: 300
    height: 500
    model: pythonListModel

    delegate: Component {
        Rectangle {
            width: pythonList.width
            height: 30
            color: model.zenItem.checked?"#00B8F5":(index%2?"#eee":"#ddd")
            Text {
                elide: Text.ElideRight
                text: model.zenItem.name
                color: (model.zenItem.checked?"white":"black")
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    right: (model.zenItem.checked?checkbox.left:parent.right)
                    leftMargin: 5
                }
            }
            Text {
                id: checkbox
                text: "✔"
                font.pixelSize: parent.height
                font.bold: true
                visible: model.zenItem.checked
                color: "white"
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 5
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: { controller.toggled(pythonListModel, model.zenItem) }
            }
        }
    }
}
