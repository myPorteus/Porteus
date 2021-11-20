// Discarded CLASS_DECL on line 19 'KDBusServicePrivate' (by default forward declaration handling)
class KDBusService: QObject
{
%TypeHeaderCode
#include <kdbusservice.h>
%End
    // Discarded VAR_DECL on line 81 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 81 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 81 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 81 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 81 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 81 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    enum StartupOption {
        Unique,
        Multiple,
        NoExitOnFailure,
        Replace
    };
    typedef QFlags<KDBusService::StartupOption> StartupOptions;
    // Modified PARM_DECL on line 145 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDBusService(QFlags<KDBusService::StartupOption> options = KDBusService::Multiple, QObject*  parent /TransferThis/ = nullptr);
    virtual ~KDBusService();
    bool isRegistered() const;
    QString serviceName() const;
    QString errorMessage() const;
    void setExitValue(int value);
Q_SIGNALS:
    void activateRequested(const QStringList & arguments, const QString & workingDirectory);
    void openRequested(const QList<QUrl> & uris);
    void activateActionRequested(const QString & actionName, const QVariant & parameter);
public Q_SLOTS:
    void unregister();
private:
private:
    private:
        KDBusService(const KDBusService &); // Generated
};
// Discarded FUNCTION_DECL on line 274 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
// Discarded FUNCTION_DECL on line 274 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
// Discarded FUNCTION_DECL on line 274 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
