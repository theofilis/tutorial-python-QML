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

Rectangle {
    id: column

    property int maxHeight: structure.height
    property real value: 100
    property string label: ""
    property real maxValue: structure.maxValue
    property real targetHeight: (!rowArea.visible || rowArea.opacity==0)?0:(column.radius + Math.round(column.maxHeight*(column.value/column.maxValue)))

    /*onParentChanged: {
        targetHeight = 0;
        width = 0;
        height = 0;
        maxHeight = 1;
        maxValue = 1;
        color = "transparent";
        radius = 0;
    }*/

    color: structure.colorWhenDefault
    gradient: (structure.gradientDefaultOn)?structure.gradientWhenDefault:structure.nullGradient
    width: Math.round( ( rowArea.width - (structure.spacing*(rowArea.visibleChilds-1)) ) / rowArea.visibleChilds );
    height: targetHeight
    radius: (column.width/2)*structure.roundness
    smooth: true
    anchors.bottom: parent.bottom
    anchors.bottomMargin: -radius

    Behavior on height { SpringAnimation { id: theSpring; velocity: 500; damping: 0.15; spring: 5.0; } }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            structure.currentValue = value;
            structure.currentLabel = label;
        }
        onEntered: {
            structure.currentValue = value;
            structure.currentLabel = label;
        }
    }
}
