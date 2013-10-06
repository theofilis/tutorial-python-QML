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
import "includes"

Rectangle {
    id: structure

    property int stars: 5
    property int starSpacing: 0
    property int starSize: -1
    property int value: 0
    property int hooverVal: 0
    property string starOn: "star_on.png"
    property string starOff: "star_off.png"
    property int structureMargin: 3
    property bool locked: false
    property bool lockAfterRate: false

    signal newCLRating(int rating)

    Component.onCompleted: {
        if (structure.starSize <= 0) structure.starSize = Math.round( (structure.width - 2*structure.structureMargin - ((structure.stars-1) * structure.starSpacing)) / structure.stars );
        structure.hooverVal = structure.value;
    }

    onNewCLRating: {
        structure.hooverVal = rating;
        structure.value = rating;
    }

    onValueChanged: structure.value = (structure.value>structure.stars)?structure.stars:structure.value;

    onHeightChanged: height = starSize + 2*structureMargin;

    onStarSizeChanged: {
        structure.height = structure.starSize + 2*structure.structureMargin;
        structure.width = (structure.stars * structure.starSize) + 2*structure.structureMargin + ((structure.stars-1) * structure.starSpacing);
    }

    width: 100
    height: starSize + 2*structureMargin
    color: "transparent"
    smooth: true

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onExited: {structure.hooverVal = structure.value;}
    }

    Row {
        anchors.centerIn: parent
        width: structure.width - 2*structureMargin
        height: structure.height - 2*structureMargin
        spacing: starSpacing

        Repeater {
            model: stars

            CLRatingStar {starValue: (index+1); smooth: structure.smooth}
        }
    }
}
