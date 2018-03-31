/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtPositioning 5.3
import "."

ApplicationWindow
{
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
    PositionSource { id: gps }
    Timer {id: positiontimer}
    Page {id:settingspages;}
    Item{
        id:positiondata
        property var positionvar: [];
        property var timestampvar: [];
    }

//-----------------------Function-----------------------------//
    property bool state: false;
    function sendData(Position, timestamp) {
        var http = new XMLHttpRequest()
        var url = livetracksettings.getString("URL")+livetracksettings.getString("ID")+"?lat=" + Position.coordinate.latitude +"&lon="+Position.coordinate.longitude+"&timestamp="+timestamp+"&alt="+Position.coordinate.altitude+"&speed="+Position.speed+"&acc="+Position.horizontalAccuracy;
        http.open("Get", url, false); //true=asynchronus,false=synchronus, testing synchronous now
        http.onreadystatechange = function() {
          if (http.readyState === XMLHttpRequest.DONE) {
           if (http.status === 200) {
               state = true;
           }
           else {
                state = false;
                }
            }
        };
        http.send();
       return state;
}
//------------------------------------------------------------//

}

