import QtQuick 2.15
import QtQuick.Controls 2.15

Button
{
    id: btnToggle
    // CUSTOM PROPERTIES
    property url btnIconSource: "qrc:/Images/toggle.png"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"

    QtObject{
        id: internal

        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(btnToggle.down){
                                       btnToggle.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnToggle.hovered ? btnColorMouseOver : btnColorDefault
                                   }

    }

    implicitWidth: 60
    implicitHeight: 60

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: imageBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 30
            width: 30
            fillMode: Image.PreserveAspectFit
        }
    }
}
