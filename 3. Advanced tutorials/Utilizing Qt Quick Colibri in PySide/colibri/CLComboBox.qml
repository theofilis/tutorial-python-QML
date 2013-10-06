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

/* TODO:
 * Next releases of Qt will change the usage of selectionStart and selectionEnd properties.
 * Properties are to be change to read only properties.
 * For selection functionalities, there will be select (start, end) -function.
 * When these changes are made, this component's selectionStart & selectionEnd- functionalities
 * has to be changed corresponding selection funtionality.
 */

Rectangle {
    id:structure

    property real itemHeight: 30
    property int itemsVisible: 5
    property ListModel items: TestItemList {}
    property bool selectMany: false
    property bool dropDown: false
    property bool dropDownCopy: false
    property bool up: false
    property string searchBoxText: ""
    property CLStyle style: CLStyle {}
    property bool activeStateOn: style.activeStateOn
    property Image arrowDownWhenDefault: arrowDown
    property Image arrowDownWhenHovered: arrowDown
    property Image arrowDownWhenPressed: arrowDown
    property Image arrowUpWhenDefault: arrowUp
    property Image arrowUpWhenHovered: arrowUp
    property Image arrowUpWhenPressed: arrowUp
    property color bgColor: style.bgColor
    property color borderColor: style.borderColor
    property color borderColorWhenActive: style.borderColorWhenActive
    property color borderColorWhenHovered: style.borderColorWhenHovered
    property color borderColorWhenPressed: style.borderColorWhenPressed
    property int borderWidth: style.borderWidth
    property color colorWhenActive: style.colorWhenActive
    property color colorWhenDefault: style.colorWhenDefault
    property color colorWhenHovered: style.colorWhenHovered
    property color colorWhenPressed: style.colorWhenPressed
    property color colorWhenSelected: style.colorWhenSelected
    property string fontFamily: style.fontFamily
    property real fontSize: style.fontSize
    property variant fontWeight: style.fontWeight
    property bool gradientActiveOn: style.gradientActiveOn
    property bool gradientBgOn: style.gradientBgOn
    property bool gradientDefaultOn: style.gradientDefaultOn
    property bool gradientHoveredOn: style.gradientHoveredOn
    property bool gradientPressedOn: style.gradientPressedOn
    property bool gradientSelectedOn: style.gradientSelectedOn
    property color sliderColor: colorWhenHovered
    property color sliderBgColor: borderColor
    property Gradient gradientWhenActive: style.gradientWhenActive
    property Gradient gradientBg: style.gradientBg
    property Gradient gradientWhenDefault: style.gradientWhenDefault
    property Gradient gradientWhenHovered: style.gradientWhenHovered
    property Gradient gradientWhenPressed: style.gradientWhenPressed
    property Gradient gradientWhenSelected: style.gradientWhenSelected
    property bool hoveredStateOn: style.hoveredStateOn
    property Gradient nullGradient: Gradient{}
    property bool pressedStateOn: style.pressedStateOn
    property color textAreaColorWhenSelected: style.selectionColor
    property color textColor: style.textColor
    property color textColorWhenSelected: style.selectedTextColor
    property string searchCLButtonText: ""
    property Image arrowUp: Image {
        id: picUp

        source: "images/arrow_up_50x50.png"
        height: structure.itemHeight*0.8
        width: structure.width*0.15*0.8
        smooth: true

    }
    property Image arrowDown : Image {
        id: picDown

        source: "images/arrow_down_50x50.png"
        height: structure.itemHeight*0.8
        width: structure.width*0.15*0.8
        smooth: true
    }
    property bool open: false //private property

    signal listItemClicked(int index)
    signal selectedChange()

    width: 200
    height: structure.itemHeight
    color: "transparent"
    border.width: structure.borderWidth
    border.color: structure.borderColor

    /**
     * Closes dropdown list
     *
     * @return Nothing
     */
    function closeCombo() {
        animation2.running = true;
        animation4.running = true;
        open = false;
        searchCLButton.backgroundImage = (up)?arrowUp:arrowDown;
        searchCLButton.backgroundImageWhenDefault = (up)?arrowUpWhenDefault:arrowDownWhenDefault;
        searchCLButton.backgroundImageWhenHovered = (up)?arrowUpWhenHovered:arrowDownWhenHovered;
        searchCLButton.backgroundImageWhenPressed = (up)?arrowUpWhenPressed:arrowDownWhenPressed;
    }

    /**
     * Opens dropdown list
     *
     * @return Nothing
     */
    function openCombo() {
        animation.running = true;
        animation3.running = true;
        open = true;
        searchCLButton.backgroundImage = (up)?arrowDown:arrowUp;
        searchCLButton.backgroundImageWhenDefault = (up)?arrowDownWhenDefault:arrowUpWhenDefault;
        searchCLButton.backgroundImageWhenHovered = (up)?arrowDownWhenHovered:arrowUpWhenHovered;
        searchCLButton.backgroundImageWhenPressed = (up)?arrowDownWhenPressed:arrowUpWhenPressed;
    }

    /**
     * Checks whether current search has multiple matches
     *
     * @param searchWord The search input
     * @return array
     */
    function oneOrMany(searchWord) {
        var result;
        var j =0;
        var index = -1;
        var alreadyFoundOne = false;
        var resultArray = new Array();
        for (var i = 0; i < itemsList.countChildren(); i++) {
            var searchWord = searchWord.toLowerCase();
            var matchable =items.get(i).label.toLowerCase();
            result = matchable.search(searchWord);
                if (result != -1) {
                    resultArray[j] = i;
                    j++;
                }
                else items.setProperty(i, "selected", false);
        }
        return resultArray;
    }

    /**
     * Performs a text based search
     *
     * @param searchWord The search input
     * @return Nothing
     */
    function searchText(searchWord) {
        var array = oneOrMany(searchWord);
        if (array.length <= 0) return;
        else if (array.length == 1) {
            items.setProperty(array[0], "selected", true);
            structure.searchBoxText = items.get(array[0]).label;
            textField.setFocus = false;
            textField.setFocus = true;
            if(open) {
               animation2.running = true;
               animation4.running = true;
               open = false;
               searchCLButton.backgroundImage = (up)?arrowUp:arrowDown;
               searchCLButton.backgroundImageWhenDefault = (up)?arrowUpWhenDefault:arrowDownWhenDefault;
               searchCLButton.backgroundImageWhenHovered = (up)?arrowUpWhenHovered:arrowDownWhenHovered;
               searchCLButton.backgroundImageWhenPressed = (up)?arrowUpWhenPressed:arrowDownWhenPressed;
           }
        }
        else {
            continueProcess(array,searchWord);
        }
    }

    /**
     * Continues search process
     *
     * @param array Previous results
     * @param searchWord The search input
     * @return Nothing
     */
    function continueProcess(array,searchWord) {
        var alreadyFoundOne = false;
        for (var i = 0; i < array.length; i++) {
            if (!selectMany) {
                if(alreadyFoundOne) items.setProperty(array[i], "selected", false);
                else {
                    var matchTo = items.get(array[i]).label.toLowerCase();
                    var pos = matchTo.indexOf(searchWord);
                    structure.searchBoxText = items.get(array[i]).label;
                    textField.selectText(pos + searchWord.length,structure.searchBoxText.length);
                    textField.setFocus = false;
                    textField.setFocus = true;
                    alreadyFoundOne = true;
                }
                if(open) {
                   animation2.running = true;
                   animation4.running = true;
                   open = false;
                   searchCLButton.backgroundImage = (up)?arrowUp:arrowDown;
                   searchCLButton.backgroundImageWhenDefault = (up)?arrowUpWhenDefault:arrowDownWhenDefault;
                   searchCLButton.backgroundImageWhenHovered = (up)?arrowUpWhenHovered:arrowDownWhenHovered;
                   searchCLButton.backgroundImageWhenPressed = (up)?arrowUpWhenPressed:arrowDownWhenPressed;
               }
            }
            else {
                items.setProperty(array[i], "selected", true);
                textField.setFocus = false;
                textField.setFocus = true;
                if(!open) {
                    animation.running = true;
                    animation3.running = true;
                    open = true;
                    searchCLButton.backgroundImage = (up)?arrowDown:arrowUp;
                    searchCLButton.backgroundImageWhenDefault = (up)?arrowDownWhenDefault:arrowUpWhenDefault;
                    searchCLButton.backgroundImageWhenHovered = (up)?arrowDownWhenHovered:arrowUpWhenHovered;
                    searchCLButton.backgroundImageWhenPressed = (up)?arrowDownWhenPressed:arrowUpWhenPressed;
                }

                if (!alreadyFoundOne) searchBoxText = items.get(array[i]).label
                alreadyFoundOne = true;
            }
        }
    }

    /**
     * Gets the selected items
     *
     * @return array
     */
    function getSelected() {
        var result = itemsList.getSelected();
        return result;
    }

    onHeightChanged: {
        structure.height = structure.itemHeight;
    }

    onItemsVisibleChanged:  {
        if (itemsVisible < 0) structure.itemsVisible = structure.itemsVisible*-1;
        if (itemsVisible == 0) structure.itemsVisible = 1;
    }
    Component.onCompleted: {
        structure.height = structure.itemHeight;
    }

    onItemHeightChanged: {
        structure.height = structure.itemHeight;
        searchBox.height = structure.itemHeight;
    }

    onSearchBoxTextChanged: {
        textField.text = structure.searchBoxText;
        textField.visible = false;
        textField.visible = true;
        searchBox.doNotSearch = true;
        selectedChange();
    }

    Rectangle{
        id:container

        width: structure.width+2*structure.borderWidth
        height: structure.itemHeight+2*structure.borderWidth
        clip: true
        color: "transparent"
        Rectangle{
            id: listContainer

            y: (up)?structure.itemsVisible*structure.itemHeight:(searchBox.y+searchBox.height)-(itemsList.countChildren()*structure.itemHeight)
            color: "transparent"
            width: structure.width
            height: itemsVisible*structure.itemHeight
            clip: true
            CLListbox{
                id: itemsList

                onItemClicked: {
                    structure.listItemClicked(Index);
                    if(items.get(index).selected) {
                        searchBox.doNotSearch = true;
                        textField.text = items.get(index).label;
                        textField.visible = false;
                        textField.visible = true;
                        structure.searchBoxText = items.get(index).label;
                        selectedChange();
                    }

                    if (itemsList.getSelected().length==0) {
                        textField.text = "";
                        textField.visible = false;
                        textField.visible = true;
                        structure.searchBoxText = "";
                    }

                    if (!selectMany){
                        animation2.running = true;
                        animation4.running = true;
                        open = false;
                        searchCLButton.backgroundImage = (up)?arrowUp:arrowDown;
                        searchCLButton.backgroundImageWhenDefault = (up)?arrowUpWhenDefault:arrowDownWhenDefault;
                        searchCLButton.backgroundImageWhenHovered = (up)?arrowUpWhenHovered:arrowDownWhenHovered;
                        searchCLButton.backgroundImageWhenPressed = (up)?arrowUpWhenPressed:arrowDownWhenPressed;
                    }
                }

                anchors.left: listContainer.left
                width: structure.width
                itemsVisible: (up)?structure.itemsVisible:structure.itemsVisible
                itemHeight: structure.itemHeight
                items: structure.items
                selectMany: structure.selectMany
                style: structure.style
                colorWhenDefault: structure.colorWhenDefault
                colorWhenHovered: structure.colorWhenHovered
                colorWhenSelected: structure.colorWhenSelected
                textColor: structure.textColor
                borderColor: structure.borderColor
                borderWidth: structure.borderWidth
                fontSize: structure.fontSize
                fontFamily: structure.fontFamily
                fontWeight: structure.fontWeight
                bgColor: structure.bgColor
                gradientDefaultOn: structure.gradientDefaultOn
                gradientHoveredOn: structure.gradientHoveredOn
                gradientSelectedOn: structure.gradientSelectedOn
                gradientBgOn: structure.gradientBgOn
                gradientWhenDefault: structure.gradientWhenDefault
                gradientWhenHovered: structure.gradientWhenHovered
                gradientBg: structure.gradientBg
                gradientWhenSelected: structure.gradientWhenSelected
                nullGradient: Gradient{}
                sliderBgColor: structure.sliderBgColor
                sliderColor: structure.sliderColor
                hoveredStateOn: structure.hoveredStateOn
            }
        }
    }
    Rectangle {
        id: searchBox

        property bool doNotSearch: false
        width: structure.width;
        height: structure.itemHeight
        color: "transparent"
        clip: true
        MouseArea{
            id: disableTextField

            onClicked: {
                if(!open) {
                        animation.running = true;
                        animation3.running = true;
                        open = true;
                        searchCLButton.backgroundImage = (up)?arrowDown:arrowUp;
                        searchCLButton.backgroundImageWhenDefault = (up)?arrowDownWhenDefault:arrowUpWhenDefault;
                        searchCLButton.backgroundImageWhenHovered = (up)?arrowDownWhenHovered:arrowUpWhenHovered;
                        searchCLButton.backgroundImageWhenPressed = (up)?arrowDownWhenPressed:arrowUpWhenPressed;
                }
                else{
                        animation2.running = true;
                        animation4.running = true;
                        open = false;
                        searchCLButton.backgroundImage = (up)?arrowUp:arrowDown;
                        searchCLButton.backgroundImageWhenDefault = (up)?arrowUpWhenDefault:arrowDownWhenDefault;
                        searchCLButton.backgroundImageWhenHovered = (up)?arrowUpWhenHovered:arrowDownWhenHovered;
                        searchCLButton.backgroundImageWhenPressed = (up)?arrowUpWhenPressed:arrowDownWhenPressed;
                }
            }
            anchors.fill: textField
            z: (dropDown && !dropDownCopy)?40:20
        }

        CLLineEdit{
            id: textField

            onTextChange: {
                if (structure.dropDown) {
                    if (searchBoxText == "") textField.text = "";
                    else {
                        textField.text = searchBoxText;
                        textField.visible = false;
                        textField.visible = true;
                    }
                    textField.cursorVisible = false;
                }
                else{
                    if(textField.text != "" && !searchBox.doNotSearch) {
                        searchText(textField.text);
                    }
                    searchBox.doNotSearch = false;
                }
            }

            width: parent.width*0.85
            z: 30
            height: parent.height
            style: structure.style
            visible: true
            text: structure.searchBoxText
            borderColor: structure.borderColor
            borderColorWhenHovered: structure.borderColorWhenHovered
            borderWidth: structure.borderWidth
            colorWhenDefault: structure.colorWhenDefault
            colorWhenHovered: structure.colorWhenHovered
            fontFamily: structure.fontFamily
            fontSize: structure.fontSize
            fontWeight: structure.fontWeight
            gradientDefaultOn: structure.gradientDefaultOn
            gradientHoveredOn: structure.gradientHoveredOn
            gradientWhenDefault: structure.gradientWhenDefault
            gradientWhenHovered: structure.gradientWhenHovered
            hoveredStateOn: structure.hoveredStateOn
            setFocus: false
            roundness: 0
            textColor: structure.textColor
            textColorWhenSelected: structure.textColorWhenSelected
            textAreaColorWhenSelected: structure.textAreaColorWhenSelected
        }

        CLButton{
            id: searchCLButton

            onClicked: {
                if(!open) {
                    animation.running = true;
                    animation3.running = true;
                    open = true;
                    searchCLButton.backgroundImage = (up)?arrowDown:arrowUp;
                    searchCLButton.backgroundImageWhenDefault = (up)?arrowDownWhenDefault:arrowUpWhenDefault;
                    searchCLButton.backgroundImageWhenHovered = (up)?arrowDownWhenHovered:arrowUpWhenHovered;
                    searchCLButton.backgroundImageWhenPressed = (up)?arrowDownWhenPressed:arrowUpWhenPressed;
 }
                else {
                    animation2.running = true;
                    animation4.running = true;
                    open = false;
                    searchCLButton.backgroundImage = (up)?arrowUp:arrowDown;
                    searchCLButton.backgroundImageWhenDefault = (up)?arrowUpWhenDefault:arrowDownWhenDefault;
                    searchCLButton.backgroundImageWhenHovered = (up)?arrowUpWhenHovered:arrowDownWhenHovered;
                    searchCLButton.backgroundImageWhenPressed = (up)?arrowUpWhenPressed:arrowDownWhenPressed;
                }
            }

            height: parent.height
            width: parent.width*0.15
            text: structure.searchCLButtonText
            backgroundImage: (up)?arrowUp:arrowDown
            anchors.left: textField.right
            style: structure.style
            colorWhenDefault: structure.colorWhenDefault
            colorWhenPressed: structure.colorWhenPressed
            colorWhenHovered: structure.colorWhenHovered
            textColor: structure.textColor
            roundness: 0
            borderColor: structure.borderColor
            borderWidth: structure.borderWidth
            fontSize: structure.fontSize
            fontFamily: structure.fontFamily
            fontWeight: structure.fontWeight
            borderColorWhenHovered: structure.borderColorWhenHovered
            borderColorWhenPressed: structure.borderColorWhenPressed
            backgroundImageWhenDefault: (up)?arrowUpWhenDefault:arrowDownWhenDefault
            backgroundImageWhenHovered: (up)?arrowUpWhenHovered:arrowDownWhenHovered
            backgroundImageWhenPressed: (up)?arrowUpWhenPressed:arrowDownWhenPressed
            gradientDefaultOn: structure.gradientDefaultOn
            gradientHoveredOn: structure.gradientHoveredOn
            gradientPressedOn: structure.gradientPressedOn
            hoveredStateOn: structure.hoveredStateOn
            pressedStateOn: structure.pressedStateOn
            gradientWhenDefault: structure.gradientWhenDefault
            gradientWhenHovered: structure.gradientWhenHovered
            gradientWhenPressed: structure.gradientWhenPressed
        }
    }
    PropertyAnimation { id: animation; target: listContainer;  property: "y"; to: (up)?-structure.itemHeight*structure.itemsVisible : searchBox.height; duration: 200+(structure.itemsVisible/0.5) }
    PropertyAnimation { id: animation2; target: listContainer;  property: "y"; to: (up)?0 : searchBox.height-itemsList.countChildren()*structure.itemHeight; duration: 200+(structure.itemsVisible/0.5) }
    PropertyAnimation { id: animation3; target: container;  property: "height"; to: (up)?-(structure.itemsVisible)*structure.itemHeight : (itemsVisible+1)*structure.itemHeight; duration: 200+(structure.itemsVisible/0.5) }
    PropertyAnimation { id: animation4; target: container;  property: "height"; to: (up)?structure.itemHeight : structure.itemHeight; duration:200+(structure.itemsVisible/0.5) }

}
