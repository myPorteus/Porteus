/*
    SPDX-FileCopyrightText: 2013-2014 Jan Grulich <jgrulich@redhat.com>
    SPDX-FileCopyrightText: 2014-2015 David Rosca <nowrep@gmail.com>

    SPDX-License-Identifier: LGPL-2.1-only OR LGPL-3.0-only OR LicenseRef-KDE-Accepted-LGPL
*/

import QtQuick 2.2
import org.kde.plasma.plasmoid 2.0
import org.kde.bluezqt 1.0 as BluezQt
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kquickcontrolsaddons 2.0
import org.kde.plasma.private.bluetooth 1.0 as PlasmaBt

import "logic.js" as Logic

Item {
    id: bluetoothApplet

    property bool deviceConnected : false
    property int runningActions : 0
    property QtObject btManager : BluezQt.Manager

    Plasmoid.toolTipMainText: i18n("Bluetooth")
    Plasmoid.icon: Logic.icon()

    Plasmoid.switchWidth: PlasmaCore.Units.gridUnit * 15
    Plasmoid.switchHeight: PlasmaCore.Units.gridUnit * 10

    Plasmoid.compactRepresentation: CompactRepresentation { }
    Plasmoid.fullRepresentation: FullRepresentation { }

    function action_configure() {
        KCMShell.openSystemSettings("bluetooth");
    }

    function action_addNewDevice() {
        PlasmaBt.LaunchApp.runCommand("bluedevil-wizard");
    }

    Component.onCompleted: {
        plasmoid.removeAction("configure");
        plasmoid.setAction("configure", i18n("Configure &Bluetooth..."), "preferences-system-bluetooth");

        plasmoid.setAction("addNewDevice", i18n("Add New Device..."), "list-add");
        plasmoid.action("addNewDevice").visible = Qt.binding(() => {return !btManager.bluetoothBlocked;});

        Logic.init();
    }
}
