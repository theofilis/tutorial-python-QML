import Qt 4.7
 
Rectangle {
    width: 800
    height: 480
 
    Image {
        source: "images/pysidelogo.png"
        fillMode: Image.PreserveAspectFit
        width: parent.width/2
        height: parent.height/2
        anchors.centerIn: parent
        rotation: listener.rotation
    }
}