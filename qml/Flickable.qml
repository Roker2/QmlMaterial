import QtQuick

import Qcm.Material as MD

Flickable {
    id: root

    // it's hard to avoid item around Flickable is not transparent
    clip: true

    // flickable not set contentHeight
    contentHeight: contentItem.childrenRect.height// + topMargin + bottomMargin
    contentWidth: width - rightMargin - leftMargin
    implicitHeight: contentHeight

    leftMargin: 0
    rightMargin: 0
    topMargin: 0
    bottomMargin: 0

    signal wheelMoved

    MD.WheelHandler {
        id: wheel
        target: root
        filterMouseEvents: false
        onWheelMoved: root.wheelMoved()
    }
    ScrollBar.vertical: MD.ScrollBar {
    }
}

