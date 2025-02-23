#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "tcpclient.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    // expose C++ object to qml
    CTcpConHandler tcpClientConHandler;
    engine.rootContext()->setContextProperty("tcpClientConHandler", &tcpClientConHandler);
    CTcpClient tcpClient(nullptr, tcpClientConHandler);
    engine.rootContext()->setContextProperty("tcpClient", &tcpClient);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("LedStripContoller", "Main");

    return app.exec();
}
