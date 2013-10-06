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

Item {
    id: structure

    property CLStyle style: CLStyle {}
    property Gradient gradientWhenDefault: style.gradientWhenDefault
    property color colorWhenDefault: style.colorWhenDefault
    property bool displayBg: false
    /* IMAGE PROPERTIES
     */
    property string backgroundImage: ""
    property string needleImage: ""

    /* ROTATION PROPERTIES
     */
    property int startAngle: -90
    property int endAngle: 90
    property real startValue: 0
    property real endValue: 100
    property real value: 0
    property real theRealValue: value // Hidden property
    property real percentage: ((theRealValue-startValue) / (endValue-startValue)) // Hidden property
    property real curAngle: startAngle + Math.round((endAngle-startAngle)*percentage) // Hidden property

    onValueChanged: {
        if ( value < startValue ) {
            theRealValue = startValue;
        }
        else {
            if ( value > endValue ) theRealValue = endValue;
            else theRealValue = value;
        }
    }

    // This widget needs to stay square (1:1)
    onHeightChanged: if ( structure.height != structure.width ) structure.height = structure.width;

    Component.onCompleted: {
        if ( needleImage != "" ) needle.visible=false;
    }
    width: 400
    height: structure.width

    Rectangle {
        id: bgRect

        gradient: gradientWhenDefault
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        smooth: true
        radius: width/2
        visible: (backgroundImage == "" || displayBg ) ? true : false
    }

    Image {
        id: bgImg

        source:  "images/"+backgroundImage
        width: parent.width
        height: parent.width
        fillMode: Image.Stretch
        anchors.centerIn: parent
        smooth: true
    }

    Rectangle {
        id: needle

        x: (parent.width/2)
        y: (parent.height/2) - height
        visible: (needleImage == "") ? true : false
        width: 4
        radius: 2
        height: Math.round((parent.height/2)*0.95)
        color: colorWhenDefault
        smooth: true
        transform: Rotation {
            id: rectRotation
            origin.x: Math.round(needle.width/2); origin.y: needle.height;
            angle: structure.curAngle;
            Behavior on angle {
                SpringAnimation {spring: 2; damping: 0.5; }
            }
        }
    }

    Image {
        id: needleImg

        source:  "images/"+needleImage
        width: parent.width
        height: parent.height
        fillMode: Image.Stretch
        anchors.centerIn: parent
        smooth: true
        transform: Rotation {
            id: imgRotation
            origin.x: Math.round(structure.width/2); origin.y: Math.round(structure.height/2);
            angle: structure.curAngle;
            Behavior on angle {
                SpringAnimation {spring: 2; damping: 0.5; }
            }
        }
    }
}
