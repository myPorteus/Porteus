/*
 *   Copyright 2019 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.6
import org.kde.kirigami 2.11 as Kirigami

Rectangle {
    color: Kirigami.Theme.backgroundColor

    CornerShadow {
        id: topLeft
        corner: Qt.BottomRightCorner
        z: -1
        anchors {
            right: parent.left
            bottom: parent.top
            margins: margin
            bottomMargin: margin - 1
        }
    }
    CornerShadow {
        id: topRight
        corner: Qt.BottomLeftCorner
        z: -1
        anchors {
            left: parent.right
            bottom: parent.top
            margins: margin
            bottomMargin: margin - 1
        }
    }
    CornerShadow {
        id: bottomLeft
        corner: Qt.TopRightCorner
        z: -1
        anchors {
            right: parent.left
            top: parent.bottom
            margins: margin
        }
    }
    CornerShadow {
        id: bottomRight
        corner: Qt.TopLeftCorner
        z: -1
        anchors {
            left: parent.right
            top: parent.bottom
            margins: margin
        }
    }
    EdgeShadow {
        edge: Qt.BottomEdge
        z: -1
        anchors {
            left: bottomLeft.right
            right: bottomRight.left
            bottom: parent.top
            bottomMargin: - 1
        }
    }
    EdgeShadow {
        edge: Qt.TopEdge
        z: -1
        anchors {
            left: topLeft.right
            right: topRight.left
            top: parent.bottom
        }
    }
    EdgeShadow {
        edge: Qt.LeftEdge
        z: -1
        anchors {
            top: topRight.bottom
            bottom: bottomRight.top
            left: parent.right
        }
    }
    EdgeShadow {
        edge: Qt.RightEdge
        z: -1
        anchors {
            top: topLeft.bottom
            bottom: bottomLeft.top
            right: parent.left
        }
    }
}

