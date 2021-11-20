// Discarded CLASS_DECL on line 18 'KPluginFactory' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'KPluginMetaData' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'KPluginLoaderPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'KPluginName' (by default forward declaration handling)
class KPluginLoader: QObject
{
%TypeHeaderCode
#include <kpluginloader.h>
%End
    // Discarded VAR_DECL on line 63 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 63 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 63 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 63 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 63 'tr' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 63 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public:
    // Modified PARM_DECL on line 80 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPluginLoader(const QString & plugin, QObject*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 92 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPluginLoader(const KPluginName & name, QObject*  parent /TransferThis/ = nullptr);
    virtual ~KPluginLoader();
    KPluginFactory * factory();
    QString pluginName() const;
    quint32 pluginVersion();
    static QString findPlugin(const QString & name);
    QString errorString() const;
    QString fileName() const;
    QObject * instance();
    bool isLoaded() const;
    bool load();
    QLibrary::LoadHints loadHints() const;
    QJsonObject metaData() const;
    void setLoadHints(QFlags<QLibrary::LoadHint> loadHints);
    bool unload();
    // Discarded CXX_METHOD on line 309 'instantiatePlugins' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
    // Discarded CXX_METHOD on line 329 'findPlugins' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
    static QVector<KPluginMetaData> findPluginsById(const QString & directory, const QString & pluginId);
    // Discarded CXX_METHOD on line 368 'forEachPlugin' (by rules_PyKF5.py:FunctionRuleDb[14],function_discard)
private:
    KPluginLoader(const KPluginLoader & __0);
};
class KPluginName
{
%TypeHeaderCode
#include <kpluginloader.h>
%End
public:
    KPluginName(const QString & name);
    QString name() const;
    bool isValid() const;
    QString errorString() const;
    static KPluginName fromErrorString(const QString & errorString);
private:
};
