/*
 *  SPDX-FileCopyrightText: 2019 Björn Feber <bfeber@protonmail.com>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.5
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.10 as Kirigami

/**
 * A section delegate for the primitive ListView component.
 *
 * It's intended to make all listviews look coherent.
 *
 * Example usage:
 * @code
 * import QtQuick 2.5
 * import QtQuick.Controls 2.5 as QQC2
 *
 * import org.kde.kirigami 2.10 as Kirigami
 *
 * ListView {
 *  [...]
 *     section.delegate: Kirigami.ListSectionHeader {
 *         label: section
 *
 *         QQC2.Button {
 *             text: "Button 1"
 *         }
 *         QQC2.Button {
 *             text: "Button 2"
 *         }
 *     }
 *  [...]
 * }
 * @endcode
 *
 */
Kirigami.AbstractListItem {
    id: listSection

    /**
     * label: string
     * A single text label the list section header will contain
     */
    property alias label: listSection.text

    default property alias _contents: rowLayout.data

    backgroundColor: Kirigami.Theme.backgroundColor
    Kirigami.Theme.inherit: false
    Kirigami.Theme.colorSet: Kirigami.Theme.Window

    separatorVisible: false
    sectionDelegate: true
    hoverEnabled: false

    contentItem: RowLayout {
        id: rowLayout

        Kirigami.Heading {
            level: 3
            text: listSection.text
            Layout.fillWidth: rowLayout.children.length === 1
        }
    }
}
