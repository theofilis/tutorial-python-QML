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

/**
 * Helpful functions for QtQuick-library
 */


 /**
  * Keeps number in given area. If value isn't between min and max value
  *
  * @param value Value
  * @param min Minimum value for value
  * @param max Maximun value for value
  * @return value if value is betwewwn min and max. otherwise returns min or max value.
  */
function numberParser(value,min,max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}

/**
 * Count radius for qml element. Function is used to get relative radius
 * to different size of items.
 *
 * @param roundness wanted roundness value
 * @param elementWidth Width of element
 * @param elementHeight Height of element
 * @param minValue
 * @param maxValue
 * @return Radius value
 */
function countRadius(roundness,elementWidth,elementHeight,minValue,maxValue) {
    var roundness = numberParser(roundness,minValue,maxValue);
    if (elementWidth < elementHeight) return (elementWidth/2)*roundness;
    return (elementHeight/2)*roundness;
}

/**
 * Returns bigger number of two numbers
 *
 * @param number1
 * @param number2
 * @return Bigger number from number1 and number2
 */
function returnBigger(number1,number2) {
    if (number1 < number2) return number2;
    return number1;
}
