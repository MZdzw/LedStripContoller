#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QString>
#include <QTcpSocket>
#include <qqml.h>


class CTcpConHandler : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString connect READ isConnected WRITE setConnection NOTIFY connectionChanged)

public:
    explicit CTcpConHandler(QObject *parent);

    QString isConnected();
    void setConnection(const QString& connStr);
    QTcpSocket* GetSocket();
signals:
    void connectionChanged(bool isConntected);

private:
    QString m_IsConnected;
    QHostAddress m_IpAddress;
    quint16 m_PortNumber;
    QTcpSocket* m_pSocket;
};

class CTcpClient : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString operation READ readTcp WRITE writeTcp NOTIFY operationChanged)

public:
    explicit CTcpClient(QObject *parent,
                        CTcpConHandler& conHandler);

    QString readTcp();
    void writeTcp(const QString& data);
signals:
    void operationChanged();

private:
    CTcpConHandler& m_ConHandler;
};

#endif // TCPCLIENT_H
