/**
 *  Copyright © 2010 Digia Plc
 *  Copyright © 2010 Nokia Corporation
 *
 *  All rights reserved.
 *
 *  Nokia and Nokia Connecting People are registered trademarks of
 *  Nokia Corporation.
 *  Java and all Java-based marks are trademarks or registered
 *  trademarks of
 *  Sun Microsystems, Inc. Other product and company names
 *  mentioned herein may be
 *  trademarks or trade names of their respective owners.
 *
 *
 *  Subject to the conditions below, you may, without charge:
 *
 *  ·  Use, copy, modify and/or merge copies of this software and
 *     associated documentation files (the "Software")
 *
 *  ·  Publish, distribute, sub-licence and/or sell new software
 *     derived from or incorporating the Software.
 *
 *
 *  This file, unmodified, shall be included with all copies or
 *  substantial portions
 *  of the Software that are distributed in source code form.
 *
 *  The Software cannot constitute the primary value of any new
 *  software derived
 *  from or incorporating the Software.
 *
 *  Any person dealing with the Software shall not misrepresent
 *  the source of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
 *  KIND, EXPRESS OR IMPLIED,
 *  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 *  MERCHANTABILITY, FITNESS FOR A
 *  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT
 *  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 *  WHETHER IN AN ACTION
 *  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *  CONNECTION WITH THE
 *  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
import Qt 4.7
import "javascripts/functions.js" as Functions

Rectangle {
    id: tabWidget

    property int current: 0
    default property alias content: stack.children
    property CLStyle style: CLStyle{}
    property color borderColor: style.borderColor
    property real borderWidth: style.borderWidth
    property string fontFamily: style.fontFamily
    property real tabHeight: 32
    property real fontSize: tabHeight*0.3
    property color textColor: style.textColor
    property color contentColor: style.colorWhenDefault
    property real roundness: style.roundness
    property real tabSpacing: 5
    property color tabColor: style.colorWhenPressed
    property color tabColorWhenSelected: contentColor
    property Gradient tabGradient: style.gradientWhenHovered
    property Gradient tabGradientWhenSelected: style.gradientWhenDefault
    property color textColorWhenSelected: textColor
    property bool tabGradientOn: style.gradientDefaultOn
    property Gradient nullGradient: Gradient{}
    property real tabWidth: (tabWidget.width / stack.children.length - tabSpacing) + (tabSpacing/stack.children.length) - (headerMarginSides*2/stack.children.length)
    property int animationDuration: 100
    property BorderImage tabBorderImage: borderImageborderImageNull
    property BorderImage borderImageborderImageNull: BorderImage {
        id: nullBorderImage
        source: ""
        width: 0; height: 0
        border.left: 0; border.top: 0
        border.right: 0; border.bottom: 0
    }
    property real headerMarginSides: borderWidth

    onCurrentChanged: setOpacities()
    Component.onCompleted: {
        setOpacities();
    }

    /**
     * Functions sets not selected tab opacities to 0 and selected
     * tab opacity to 1.
     */
    function setOpacities() {
        for (var i = 0; i < stack.children.length; ++i) {
            if (i == current) stack.children[i].opacity = 1;
            else stack.children[i].opacity = 0;
        }
        stack.visible = true;
    }

    /**
     * Functions counts spacing between tab headers.
     * @param index Index of tab
     * @return correct spacing between tab headers
     */
    function countCLTabSpacing(index) {
        if (index == stack.children.length-1) {
            if (headerMarginSides == 0) return  0;
            return borderWidth;
        }
        else return tabSpacing;
    }

    width: 500;
    height: 400;
    color: "transparent"

    Row {
        id: header

        spacing: 0
        z: 1
        x: headerMarginSides
        Repeater {
            delegate:
            Row {
                id: row

                spacing: 0
                anchors.bottom: parent.bottom
                height: tabHeight

                Rectangle {
                    id: master

                    width: tabWidth
                    height: if (tabWidget.current == index) tabHeight; else tabHeight*0.8
                    color: (tabWidget.current == index)?tabColorWhenSelected:tabColor
                    gradient: if (tabWidget.current == index) { (tabGradientOn)?tabGradientWhenSelected:nullGradient } else { (tabGradientOn)?tabGradient:nullGradient }
                    radius: if (tabBorderImage.source == "") Functions.countRadius(roundness,master.width,master.height,0,1); else 0
                    y: 0
                    smooth: true
                    anchors.bottom: parent.bottom

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: stack.children[index].title
                        font.bold: tabWidget.current == index
                        font.family: fontFamily
                        font.pointSize: fontSize
                        z: 4
                        color: (tabWidget.current == index)?textColorWhenSelected:textColor
                        y: tabHeight*0.2
                    }
                    Behavior on height {
                        PropertyAnimation { duration: animationDuration }
                    }

                    Rectangle {
                        Component.onCompleted: {
                            //setOpacities()
                            if(tabBorderImage.source != "") master.visible = false;
                        }

                        y: master.radius
                        smooth: true
                        width: master.width
                        height: master.height - master.radius;
                        clip: true
                        color: "transparent"

                        Rectangle {
                            id: tab
                            height: master.height;
                            y: -master.radius
                            width: tabWidth
                            color: (tabWidget.current == index)?tabColorWhenSelected:tabColor
                            gradient: if (tabWidget.current == index) { (tabGradientOn)?tabGradientWhenSelected:nullGradient } else { (tabGradientOn)?tabGradient:nullGradient }
                            smooth: true
                            radius: 0
                         }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: tabWidget.current = index
                    }

                    //stripe under tab
                    Rectangle {
                        color: borderColor;
                        width: parent.width;
                        height: borderWidth
                        opacity: if (tabWidget.current == index)  0; else 1
                        z: 2
                        anchors { bottom: parent.bottom }
                        Behavior on opacity {
                            PropertyAnimation { duration: animationDuration*4 }
                        }
                    }
                }


                //this rectangle is for borderImage.
                Rectangle {
                    id: borderImageClipper

                    Component.onCompleted: {
                        if(tabBorderImage.source == "") borderImageClipper.visible = false;
                    }

                    width: tabWidth
                    height: tabHeight
                    clip: true
                    smooth: true
                    color: "transparent"
                    anchors.bottom: parent.bottom

                    BorderImage {
                        id: bImage

                        source: tabBorderImage.source
                        smooth: tabBorderImage.smooth
                        border.left: tabBorderImage.border.left
                        border.right: tabBorderImage.border.right
                        border.top: tabBorderImage.border.top;
                        border.bottom: tabBorderImage.border.bottom
                        width: master.width
                        height: master.height
                        anchors.bottom: parent.bottom


                        MouseArea {
                            onClicked: tabWidget.current = index;
                            anchors.fill: parent
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: stack.children[index].title
                            font.bold: tabWidget.current == index
                            font.family: fontFamily
                            font.pointSize: fontSize
                            z: 2
                            color: (tabWidget.current == index)?textColorWhenSelected:textColor
                            y: tabHeight*0.2
                        }

                        //stripe under tab
                        Rectangle {
                            color: borderColor;
                            width: parent.width;
                            height: borderWidth
                            opacity: if (tabWidget.current == index)  0; else 1
                            z: 2
                            anchors {bottom: parent.bottom}
                            Behavior on opacity {
                                PropertyAnimation { duration: animationDuration*4 }
                            }
                        }
                    }
                }

                //tab spacing
                Rectangle{
                    width: countCLTabSpacing(index)
                    height: if (borderWidth == 0) 1; else borderWidth;
                    color: if (borderWidth == 0) "transparent"; else borderColor;
                    anchors.bottom: parent.bottom
                }
            }
            model: stack.children.length
        }
    }

    Rectangle {
        id: stack

        visible: false
        anchors.top: header.bottom; anchors.bottom: tabWidget.bottom; width: tabWidget.width
        color: tabWidget.contentColor
    }

    //border-left
    Rectangle{anchors.left: parent.left; anchors.bottom: parent.bottom; width: borderWidth; height: parent.height-tabHeight+borderWidth; color: borderColor}
    //border-right
    Rectangle{anchors.right: parent.right; anchors.bottom: parent.bottom; width: borderWidth; height: parent.height-tabHeight; color: borderColor}
    //border-bottom
    Rectangle{anchors.bottom: parent.bottom; width: parent.width; height: borderWidth; color: borderColor}
}

