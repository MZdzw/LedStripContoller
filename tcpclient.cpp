#include <QDebug>
#include "tcpclient.h"

CTcpConHandler::CTcpConHandler(QObject *parent)
    : QObject{parent}
{}

QString CTcpConHandler::isConnected()
{
    return m_IsConnected;
}

void CTcpConHandler::setConnection(const QString &connStr)
{
    m_IsConnected = connStr;
    QStringList strList = connStr.split(" ", Qt::SkipEmptyParts);

    if (strList.size() == 1 && strList[0] == "Disconnect")
    {
        qDebug() << "Disconnecting";
        if (m_pSocket->isOpen())
        {
            m_pSocket->disconnectFromHost();
        }
        m_Status = ConnectionStatusE::DISCONNECTED;
    }
    else if (strList.size() == 3 && strList[0] == "Connect")
    {
        if (m_IpAddress.setAddress(strList[1]))
        {
            m_PortNumber = static_cast<quint16>(strList[2].toInt());
            qDebug() << "Everything is ok! We can connect";
            // Establish connection. Only then change the status
            // to connected
            m_pSocket = new QTcpSocket();
            m_pSocket->connectToHost(m_IpAddress, m_PortNumber);
        }

        m_Status = ConnectionStatusE::CONNECTED;

    }


    emit connectionChanged();
}

QTcpSocket *CTcpConHandler::GetSocket()
{
    return m_pSocket;
}

CTcpClient::CTcpClient(QObject *parent,
                       CTcpConHandler& conHandler)
    : QObject{parent}, m_ConHandler(conHandler)
{

}

QString CTcpClient::readTcp()
{

}

void CTcpClient::writeTcp(const QString &data)
{
    QStringList strList = data.split(" ", Qt::SkipEmptyParts);
    QString dataOut;
    if (strList[0] == "RAW")
    {
        strList.removeFirst();
        dataOut = strList.join("-");
    }
    else if (strList[0] == "D1")
    {
        int diodeNr = strList[1].toInt();
        uint16_t hue = strList[2].toDouble();
        int saturation = strList[3].toInt();
        int value = strList[4].toInt();
        QTextStream out(&dataOut);
        out << "A-2-0-0-0-" << diodeNr << "-";
        out << ((hue & 0xFF00) >> 8) << "-" << (hue & 0xFF);
        out << "-" << saturation << "-" << value << "-A";

    }


    QByteArray dataBytes = dataOut.toLocal8Bit();
    m_ConHandler.GetSocket()->write(dataBytes);
    qDebug() << dataOut;
}
