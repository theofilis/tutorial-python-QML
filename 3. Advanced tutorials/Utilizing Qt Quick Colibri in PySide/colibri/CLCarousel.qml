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

    property int imageSize: (vertical)? Math.round( structure.height / imageAmount ) : Math.round( structure.width / imageAmount );
    property int imageAmount: 3
    property ListModel coverList: TestCoverList {}
    property bool vertical: false
    property Path horPath: Path {
        startX: 0; startY: Math.round(pathElement.height/2)
        PathAttribute { name: "elementOpacity"; value: 0 }
        PathAttribute { name: "elementAngle"; value: 60 }
        PathAttribute { name: "elementZ"; value: 0 }
        PathLine { x: Math.round(pathElement.width/2); y: Math.round(pathElement.height/2) }
        PathAttribute { name: "elementOpacity"; value: 1 }
        PathAttribute { name: "elementAngle"; value: 0 }
        PathAttribute { name: "elementZ"; value: 80 }
        PathLine { x: pathElement.width; y: Math.round(pathElement.height/2) }
        PathAttribute { name: "elementOpacity"; value: 0 }
        PathAttribute { name: "elementAngle"; value: -60 }
        PathAttribute { name: "elementZ"; value: 0 }
    }

    property Path verPath: Path {
        startX: Math.round(pathElement.width/2); startY: 0
        PathAttribute { name: "elementOpacity"; value: 0 }
        PathAttribute { name: "elementAngle"; value: 60 }
        PathAttribute { name: "elementZ"; value: 0 }
        PathLine { x: Math.round(pathElement.width/2); y: Math.round(pathElement.height/2) }
        PathAttribute { name: "elementOpacity"; value: 1 }
        PathAttribute { name: "elementAngle"; value: 0 }
        PathAttribute { name: "elementZ"; value: 80 }
        PathLine { x: Math.round(pathElement.width/2); y: pathElement.height }
        PathAttribute { name: "elementOpacity"; value: 0 }
        PathAttribute { name: "elementAngle"; value: -60 }
        PathAttribute { name: "elementZ"; value: 0 }
    }

    signal coverChanged( int index );

    /**
     * Positions the coverflow to a specific index
     *
     * @param newIndex The index to rotate to
     * @return Nothing
     */
    function goTo( newIndex ) {
        if( 0 >= newIndex < pathElement.count ) pathElement.currentIndex = newIndex;
    }

    /**
     * Selects previous cover
     *
     * @return Nothing
     */
    function previous() {
        if( pathElement.currentIndex == 0 ) pathElement.currentIndex = (pathElement.count - 1);
        else pathElement.currentIndex = (pathElement.currentIndex - 1);
        if( pathElement.currentIndex < 0 ) pathElement.currentIndex = 0;
    }

    /**
     * Selects next cover
     *
     * @return Nothing
     */
    function next() {
        if( pathElement.currentIndex < (pathElement.count - 1) ) pathElement.currentIndex = (pathElement.currentIndex + 1);
        else pathElement.currentIndex = 0;
    }

    /**
     * Move a given number of steps
     *
     * @param steps The amount of covers to jump
     * @return Nothing
     */
    function move( steps ) {
        if( steps == 0 ) return;
        steps = (steps % pathElement.count);
        if( steps > 0 ) for( var a=0; a<steps; ++a ) next();
        else for( var b=0; b<(-steps); ++b ) previous();
    }

    Component.onCompleted: {
        if( structure.vertical ) width = imageSize;
        else height = imageSize;
        pathElement.path = (vertical)? verPath : horPath;
        goTo(1); goTo(0);
    }
    onHeightChanged: if( !vertical && structure.height < imageSize ) height = imageSize;
    onWidthChanged: if( vertical && structure.width < imageSize ) width = imageSize;
    onCoverListChanged: goTo(0);
    onImageAmountChanged: if(imageAmount<1) imageAmount = 1;

    width: 400
    height: 400
    color: "transparent"

    Component {
        id: delegate

        Item {
            Component.onCompleted: {
                if( structure.vertical ) anchors.horizontalCenter = pathElement.horizontalCenter;
                else anchors.verticalCenter = pathElement.verticalCenter;
            }

            width: structure.imageSize
            height: structure.imageSize
            opacity: PathView.elementOpacity
            Image { anchors.centerIn: parent; width: structure.imageSize; height: structure.imageSize; source: cover; smooth: true; }
            z: PathView.elementZ
            transform: Rotation {
                origin.x: Math.round(structure.imageSize/2); origin.y: Math.round(structure.imageSize/2)
                axis.x: (structure.vertical)?1:0; axis.y: (structure.vertical)?0:1; axis.z: 0     // rotate around y-axis
                angle: PathView.elementAngle
            }

            MouseArea {
                anchors.fill: parent
                onClicked: pathElement.currentIndex = index
            }
        }
    }

    PathView {
        id: pathElement

        onModelChanged: goTo(0);
        onCurrentIndexChanged: {
            if( pathElement.currentIndex == pathElement.count ) {
                coverChanged( 0 );
            } else {
                coverChanged( pathElement.currentIndex );
            }
        }

        anchors.fill: parent
        model: coverList
        delegate: delegate
        pathItemCount: structure.imageAmount
        highlightRangeMode: PathView.StrictlyEnforceRange
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }
}

