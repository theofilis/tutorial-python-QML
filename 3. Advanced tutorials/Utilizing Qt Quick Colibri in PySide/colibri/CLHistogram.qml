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
import "javascripts/histogram2.js" as Logic
import "includes"

Rectangle {
    id: structure

    // Operational properties... DO NOT FORCE ANY CHANGE
    property real currentValue: 0;
    property string currentLabel: "";
    property int setID : 0
    property real maxValue : 100

    // CLStyle properties... Feel free to change
    property CLStyle style : CLStyle {}
    property int spacing : 8
    property real roundness: style.roundness
    property color colorWhenDefault : style.colorWhenDefault
    property bool gradientDefaultOn : style.gradientDefaultOn
    property Gradient gradientWhenDefault : style.gradientWhenDefault
    property Gradient nullGradient : Gradient{}

    /**
     * Sets new values for histogram. Redirects request to Logic.
     *
     * @param valueCLTable A two-dimensional table of new values and column names
     * @return Nothing
     */
    function setValues( valueCLTable ) {
        /* Draws the graph again with values given in 2D table
         * - CLTable
         *  - 0
         *    - 0: Column value INT
         *    - 1: Column label STRING
         *  - 1
         *    - 0: Column value INT
         *    - 1: Column label STRING */
        Logic.reDrawColumns( valueCLTable );
    }

    /**
     * Gets values of currently visible columns
     *
     * @return array
     */
    function getValues() {
        return Logic.getValues();
    }

    /**
     * Counts visible columns
     *
     * @return int
     */
    function countVisible() {
        var amount = 0;
        for (var i = 0; i < rowArea.children.length; ++i) {
            if (rowArea.children[i].visible) ++amount;
        }
        return amount;
    }

    // Should be changed to conform with your application
    width: 400
    height: 200
    color: "transparent"

    // Do not change
    clip: true


    Row {
        id: rowArea

        property int visibleChilds: countVisibleChildren()

        /**
         * Counts visible children AKA columns
         *
         * @return int
         */
        function countVisibleChildren() {
            var amount = 0;
            for (var i = 0; i < rowArea.children.length; ++i) {
                if (rowArea.children[i].visible) ++amount;
            }
            return amount;
        }

        /**
         * Counts all visible columns
         */
        width: structure.width - 2*spacing
        x: spacing
        height: structure.height
        spacing: parent.spacing
        visible: parent.visible
        opacity: parent.opacity

        onParentChanged: {
            visibleChilds = 0;
            currentValue = 0;
            currentLabel = "";
        }

        Component.onCompleted: {
            structure.currentValue = (rowArea.children.length>0)?rowArea.children[0].value:0;
            structure.currentLabel = (rowArea.children.length>0)?rowArea.children[0].label:0;
        }

        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }

        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }

        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }
        HistogramColumn{ value: 1; label: ""; visible: false; }  HistogramColumn{ value: 1; label: ""; visible: false; }

        HistogramColumn{ value: 1; label: ""; visible: false; }  // 31 columns, because phone can't create dynamically.
    }
}
