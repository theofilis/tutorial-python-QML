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
import "../javascripts/functions.js" as Functions
import "../"

Rectangle {
    id: screen

    property CLStyle style: CLStyle{}
    property string value: ""
    property string textAlign: "center"
    property string fontFamily: "Helvetica"
    property real fontSize: style.fontSize
    property color textColor: style.textColor
    property Gradient gradientBg: style.gradientWhenDefault
    property bool gradientOn: style.gradientDefaultOn
    property real roundness: style.roundness

    Component.onCompleted: {
        if(!gradientOn) gradientContainer.destroy();
    }

    border.color: "black"
    color: "white"
    width: text.width + text.width * 0.2
    height: text.height + text.height * 0.2
    radius: Functions.countRadius(roundness,width,height,0,1)

    Rectangle {
        id: gradientContainer

        anchors.fill: parent
        gradient: gradientBg
        radius: parent.radius
    }

    Text {
        id: text

        text: value;
        font.family: fontFamily;
        font.pointSize: 0.001 + fontSize;
        color: textColor
        anchors.verticalCenter: screen.verticalCenter;
        anchors.horizontalCenter: if(textAlign ==  "center") screen.horizontalCenter
        anchors.left:             if(textAlign == "left") screen.left
        anchors.right:            if(textAlign == "right") screen.right
    }

}
