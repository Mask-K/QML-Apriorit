#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <iostream>
#include <QQmlContext>
#include "ImageParser.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;
    ImageParser model;


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    model.setProperty("images", QStringList{});
    engine.rootContext()->setContextProperty("myModel", &model);
    engine.load(url);

    return app.exec();
}
