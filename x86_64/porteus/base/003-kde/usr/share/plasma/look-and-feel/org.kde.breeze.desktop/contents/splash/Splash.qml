/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
 
 // Modified for Porteus by jssouza 

import QtQuick 2.2

Image {
    id: root
    source: "/usr/share/wallpapers/porteus.jpg"
    fillMode: Image.PreserveAspectCrop


    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.6
    }

    property int stage
    onStageChanged: {
    	if (stage == 1) {
        	introAnimation.running = true
    	}
	}
	

/*
    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: stage += 1
    }

    onStageChanged: {
        if(stage == 8) Qt.quit()
    }

*/
    Image {
        id: port_logo
        source: "/usr/share/pixmaps/porteus/porteus-logo-white.svg"
        anchors.centerIn: parent
        sourceSize.height: 128
        sourceSize.width: 128
        /*
        scale: stage < 2 ? 0 : 1
        Behavior on scale {
            NumberAnimation {
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }
        */
    }

    Rectangle {
        radius: 1
        color: "#31363b"
        anchors.top: port_logo.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        height: 2
        width: height*96
        opacity: stage < 2 ? 0 : 1
        Behavior on opacity {
            NumberAnimation {
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }

        Rectangle {
            radius: 1
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            width: (parent.width / 6) * stage
            color: "#82B1FF" //"#00BCD4"
            //color: ((parseInt(Qt.formatDateTime(new Date(), "dd")) % 2) === 0) ? "#2196F3" : "#CECECE"
            Behavior on width {
                PropertyAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
    
    ParallelAnimation {
    	id: introAnimation
    	running: false
    	
    	ScaleAnimator {
            target: port_logo
            from: 0
            to: 1
            duration: 1000
            easing.type: Easing.InOutQuad
        }        
	}
}
