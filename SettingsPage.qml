import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Controls.Material
import "MyComponents"

Item {
    Rectangle
    {
        id: rectangle
        color: "#232f4f"
        anchors.fill: parent

        Label
        {
            id: label
            color: "#ffffff"
            text: qsTr("TCP/IP CLIENT")
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.top
            font.pointSize: 28
        }
        TextField
        {
            id: ipAddressField
            text: qsTr("192.168.0.0")
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.left: parent.left
            anchors.leftMargin: 15
            height: 60
            width: parent.width - 400
            placeholderText: qsTr("Insert IP address of the server: ")
            font.pixelSize: 30
        }
        TextField
        {
            id: portField
            text: qsTr("22")
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.left: ipAddressField.right
            anchors.leftMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.bottom: ipAddressField.bottom
            placeholderText: qsTr("Insert port: ")
            font.pixelSize: 30
        }

        Button
        {
            id: connectButton
            text: qsTr("Connect")
            anchors.top: ipAddressField.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 15
            width: parent.width / 2 - 20
            height: ipAddressField.height + 5
            font.pixelSize: 20
            onClicked:
            {
                tcpClientConHandler.connect = text + " " +
                        ipAddressField.text + " " + portField.text
            }
        }
        Button
        {
            id: disconnectButton
            text: qsTr("Disconnect")
            anchors.top: ipAddressField.bottom
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 15
            width: parent.width / 2 - 20
            height: ipAddressField.height + 5
            font.pixelSize: 20
            onClicked:
            {
                tcpClientConHandler.connect = text
            }
        }
        CheckBox
        {
            id: connectionStatus
            text: qsTr("Not Connected")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: commandField.top
            anchors.bottomMargin: 50
            height: 60
            font.pixelSize: height
            indicator.width: height
            indicator.height: height
            checked: false
            enabled: false
            contentItem: Text
            {
                text: parent.text
                color: (connectionStatus.text === "Connected") ? "green" : "red"
                font: parent.font
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.indicator.right
                anchors.leftMargin: 8
            }
            Connections
            {
                target: tcpClientConHandler
                onConnectionChanged: (isConnected) =>
                {
                    if (isConnected)
                    {
                        connectionStatus.text = "Connected"
                        connectionStatus.checked = true
                    }
                    else
                    {
                        connectionStatus.text = "Disconnected"
                        connectionStatus.checked = false
                    }
                }
            }

        }

        Button
        {
            id: sendRawCommand
            text: qsTr("Send Command")
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.bottom: parent.bottom
            width: parent.width - 20
            height: ipAddressField.height + 5
            font.pixelSize: 20
            onClicked:
            {
                tcpClient.operation = "RAW " + commandField.text
            }
        }
        TextField
        {
            id: commandField
            text: qsTr(" ")
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.bottom: sendRawCommand.top
            anchors.bottomMargin: 10
            width: parent.width - 40
            placeholderText: qsTr("Insert command to send over socket: ")
            font.pixelSize: 30
        }
    }
}
