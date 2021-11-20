// Discarded CLASS_DECL on line 22 'KPluginLoader' (by default forward declaration handling)
// Discarded CLASS_DECL on line 23 'QPluginLoader' (by default forward declaration handling)
// Discarded CLASS_DECL on line 24 'KPluginMetaDataPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 25 'KAboutPerson' (by default forward declaration handling)
// Discarded CLASS_DECL on line 26 'QObject' (by default forward declaration handling)
class KPluginMetaData
{
%TypeHeaderCode
#include <kpluginmetadata.h>
%End
public:
    // Discarded VAR_DECL on line 87 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 87 'qt_check_for_QGADGET_macro' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    typedef void QtGadgetHelper;
private:
public:
    KPluginMetaData();
    KPluginMetaData(const KPluginLoader & loader);
    KPluginMetaData(const QPluginLoader & loader);
    KPluginMetaData(const QString & file);
    KPluginMetaData(const QJsonObject & metaData, const QString & file);
    KPluginMetaData(const QJsonObject & metaData, const QString & pluginFile, const QString & metaDataFile);
    KPluginMetaData(const KPluginMetaData & __0);
    // Discarded CXX_METHOD on line 178 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    ~KPluginMetaData();
    static KPluginMetaData fromDesktopFile(const QString & file, const QStringList & serviceTypes = QStringList());
    bool isValid() const;
    bool isHidden() const;
    QString fileName() const;
    QString metaDataFileName() const;
    QJsonObject rawData() const;
    QObject * instantiate() const;
    QString name() const;
    QString description() const;
    QString extraInformation() const;
    QList<KAboutPerson> authors() const;
    QList<KAboutPerson> translators() const;
    QList<KAboutPerson> otherContributors() const;
    QString category() const;
    QString iconName() const;
    QString license() const;
    QString licenseText() const;
    QString copyrightText() const;
    QString pluginId() const;
    QString version() const;
    QString website() const;
    QStringList dependencies() const;
    QStringList serviceTypes() const;
    QStringList mimeTypes() const;
    bool supportsMimeType(const QString & mimeType) const;
    QStringList formFactors() const;
    bool isEnabledByDefault() const;
    int initialPreference() const;
    QString value(const QString & key, const QString & defaultValue = QString()) const;
    static QStringList readStringList(const QJsonObject & jo, const QString & key);
    static QJsonValue readTranslatedValue(const QJsonObject & jo, const QString & key, const QJsonValue & defaultValue = QJsonValue());
    static QString readTranslatedString(const QJsonObject & jo, const QString & key, const QString & defaultValue = QString());
    bool operator==(const KPluginMetaData & other) const;
    bool operator!=(const KPluginMetaData & other) const;
private:
private:
};
uint qHash(const KPluginMetaData & md, unsigned int seed);
// Discarded STRUCT_DECL on line 458 'QMetaTypeId' (by rules_PyKF5.py:ContainerRuleDb[2],container_discard)
