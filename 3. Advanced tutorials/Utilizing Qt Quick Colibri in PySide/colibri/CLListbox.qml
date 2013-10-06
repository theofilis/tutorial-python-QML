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
import "gradients"

Rectangle {
    id: structure

    property real itemHeight: 30
    property int itemsVisible: 5
    property ListModel items: TestItemList {}
    property bool selectMany: false
    property bool enableCLSlider: true
    property bool allowDeSelect: true
    property CLStyle style: CLStyle {}
    property color colorWhenDefault: style.colorWhenDefault
    property color colorWhenHovered: style.colorWhenHovered
    property color colorWhenSelected: style.colorWhenSelected
    property color textColor: style.textColor
    property color borderColor: style.borderColor
    property int borderWidth: style.borderWidth
    property real fontSize: style.fontSize
    property string fontFamily: style.fontFamily
    property variant fontWeight: style.fontWeight
    property color bgColor: style.bgColor
    property color sliderColor: colorWhenHovered
    property color sliderBgColor: borderColor
    property bool gradientDefaultOn: style.gradientDefaultOn
    property bool gradientHoveredOn: style.gradientHoveredOn
    property bool gradientSelectedOn: style.gradientSelectedOn
    property bool gradientBgOn: style.gradientBgOn
    property Gradient gradientWhenDefault: style.gradientWhenDefault
    property Gradient gradientWhenHovered: style.gradientWhenHovered
    property Gradient gradientBg: style.gradientBg
    property Gradient gradientWhenSelected: style.gradientWhenSelected
    property Gradient nullGradient: Gradient{}
    property bool hoveredStateOn: style.hoveredStateOn

    signal itemClicked(int index)
    signal change()

    /**
     * Gets the values of selected items
     *
     * @return array
     */
    function getSelected() {
        var theArray = Array();
        var arrayCount = 0;
        for (var i=0; i<theList.count; ++i) {
            if (theList.model.get(i).selected) {
                theArray[arrayCount] = theList.model.get(i).value;
                ++arrayCount;
            }
        }
        return theArray;
    }

    /**
     * Get names of items
     *
     * @return array
     */
    function getNames() {
        var theArray = Array();
        for (var i=0; i<theList.count; ++i) {
            theArray[i] = theList.model.get(i).label;
        }
        return theArray;
    }

    /**
     * Removes all selections
     *
     * @return Nothing
     */
    function clearSelections() {
        for (var i=0; i<theList.count; ++i) {
            theList.model.setProperty(i, "selected", false);
        }
    }

    /**
     * Counts items
     *
     * @return Nothing
     */
    function countChildren() {
        return theList.count;
    }

    /**
     * Selects a specific item
     *
     * @param index Index of the item to be selected
     * @return bool
     */
    function select(index) {
        if (index < 0) return false;
        if (index >= theList.count) return false;
        theList.model.setProperty(index, "selected", true);
        structure.change();
        return true;
    }

    /**
     * Removes selection from a specific item
     *
     * @param index Index of the item to be unselected
     * @return bool
     */
    function deSelect(index) {
        if (index < 0) return false;
        if (index >= theList.count) return false;
        theList.model.setProperty(index, "selected", false);
        structure.change();
        return true;
    }

    /**
     * Checks whether an item is selected. Returns -1 on error, 1 on selected and 0 on not selected.
     *
     * @param idnex Index of the item to be checked
     * @return int
     */
    function isSelected(index) {
        if (index < 0) return -1;
        if (index >= theList.count) return -1;
        return (theList.model.get(index).selected)?1:0;
    }

    onItemClicked: {
        if (selectMany) {
            if (theList.model.get(index).selected) theList.model.setProperty(index, "selected", false);
            else theList.model.setProperty(index, "selected", true);
        } else {
            if (theList.model.get(index).selected) {
                if (structure.allowDeSelect) theList.model.setProperty(index, "selected", false);
            } else {
                for (var i=0; i<theList.count; ++i) theList.model.setProperty(i, "selected", false);
                theList.model.setProperty(index, "selected", true);
            }
        }
        structure.change();
    }

    Component.onCompleted: {
        var alreadyFoundOne = false;
        if (!selectMany) for (var i=0; i<theList.count; ++i) {
            if (alreadyFoundOne) {
                theList.model.setProperty(i, "selected", false);
            } else {
                if (theList.model.get(i).selected) alreadyFoundOne = true;
            }
        }
        var available = (theList.count<itemsVisible)? theList.count : itemsVisible;
        structure.height = (available * structure.itemHeight) + 2*borderWidth;
        smallerRect.height = (available * structure.itemHeight);
    }

    onHeightChanged: {
        var available = (theList.count<itemsVisible)? theList.count : itemsVisible;
        structure.height = (available * structure.itemHeight) + 2*borderWidth;
        smallerRect.height = (available * structure.itemHeight);
    }

    onItemsVisibleChanged: {
        if (itemsVisible < 1) itemsVisible = 1;
        var available = (theList.count<itemsVisible)? theList.count : itemsVisible;
        structure.height = (available * structure.itemHeight) + 2*borderWidth;
        smallerRect.height = (available * structure.itemHeight);
    }

    onItemHeightChanged: {
        var available = (theList.count<itemsVisible)? theList.count : itemsVisible;
        structure.height = (available * structure.itemHeight) + 2*borderWidth;
        smallerRect.height = (available * structure.itemHeight);
    }

    onSelectManyChanged: {
        var alreadyFoundOne = false;
        if (!selectMany) for (var i=0; i<theList.count; ++i) {
            if (alreadyFoundOne) {
                theList.model.setProperty(i, "selected", false);
            }
            else {
                if (theList.model.get(i).selected) alreadyFoundOne = true;
            }
        }
        structure.change();
    }

    width: 160
    height: 400
    clip: true
    color: bgColor
    gradient: (gradientBgOn)?gradientBg:nullGradient
    border.width: borderWidth
    border.color: borderColor

    Component {
        id: listItem
        Rectangle {
            id: rectis

            property string valuex: value
            property string labelx: label
            property int indexx: index
            property bool selectedx: selected

            width: smallerRect.width
            height: structure.itemHeight
            color: colorWhenDefault
            gradient: (gradientDefaultOn)?gradientWhenDefault:nullGradient

            MouseArea {
                id: mousepad
                anchors.fill: parent
                hoverEnabled: true
                onClicked: structure.itemClicked(indexx)
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                x: 8
                font.pointSize: fontSize
                font.family: fontFamily
                font.weight: fontWeight
                color: textColor
                text: labelx
            }
            states: [
            State {
                id: stateSelected
                name: "selectedx"; when: rectis.selectedx
                PropertyChanges { target: rectis; color: colorWhenSelected; gradient: (gradientSelectedOn)?gradientWhenSelected:nullGradient }
            },
            State {
                id: stateHovered
                name: "hovered"; when: (mousepad.containsMouse && hoveredStateOn)
                PropertyChanges { target: rectis; color: colorWhenHovered; gradient: (gradientHoveredOn)?gradientWhenHovered:nullGradient }
            }
            ]
        }
    }

    Rectangle {
        id: smallerRect

        x: structure.borderWidth
        y: structure.borderWidth
        width: structure.width - 2*structure.borderWidth
        height: structure.width - 2*structure.borderWidth
        clip: true
        color: "transparent"

        ListView {
            id: theList

            interactive: (theList.count<=structure.itemsVisible)?false:true;
            model: items
            delegate: listItem
            anchors.fill: parent
            snapMode: ListView.SnapOneItem
        }
    }

    Rectangle {
        id: scroller

        visible: (theList.count>structure.itemsVisible && enableCLSlider)?true:false;
        color: structure.sliderBgColor
        width: 5
        height: smallerRect.height
        x: smallerRect.x + smallerRect.width - scroller.width
        y: smallerRect.y
        opacity: 0.7
        clip: true

        Rectangle {
            id: sled
            color: structure.sliderColor
            width: scroller.width
            height: smallerRect.height * ( structure.itemsVisible / theList.count )
            y: Math.round( ((theList.contentY / itemHeight) / (theList.count - itemsVisible)) * (scroller.height-sled.height)  )
            radius: 2
            smooth: true
        }
    }
}
