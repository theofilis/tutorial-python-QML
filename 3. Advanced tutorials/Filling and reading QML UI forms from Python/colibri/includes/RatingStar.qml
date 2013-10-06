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

Flipable {
    id: star

    property int starValue: 1
    property int current: structure.hooverVal
    property int angle: 0
    property bool flipped: false

    onCurrentChanged: {
        if( current >= starValue ) star.flipped = true;
        else star.flipped = false;
    }

    width: structure.starSize
    height: structure.starSize
    smooth: true
    anchors.verticalCenter: parent.verticalCenter
    front: Image { source: "../images/"+structure.starOff; anchors.fill: parent; smooth: star.smooth; }
    back: Image { source: "../images/"+structure.starOn; anchors.fill: parent; smooth: star.smooth;  }

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        onClicked: {
            if( !structure.locked ) structure.newCLRating(star.starValue);
            if( structure.lockAfterRate ) structure.locked = true;
        }
        onEntered: { if( !structure.locked ) structure.hooverVal = star.starValue; }
    }

    states: State {
        name: "back"
        PropertyChanges { target: star; angle: 180 }
        when: star.flipped
    }

    transitions: Transition {
        NumberAnimation { properties: "angle"; duration: 600 }
    }

    transform: Rotation {
        origin.x: star.width/2; origin.y: star.height/2
        axis.x: 0; axis.y: 1; axis.z: 0
        angle: star.angle
    }

}
