// Discarded CLASS_DECL on line 17 'KDEDModulePrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'Kded' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QDBusObjectPath' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'QDBusMessage' (by default forward declaration handling)
class KDEDModule: QObject
{
%TypeHeaderCode
#include <kdedmodule.h>
%End
    // Discarded VAR_DECL on line 37 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 37 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 37 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 46 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDEDModule(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KDEDModule();
    void setModuleName(const QString & name);
    QString moduleName() const;
    static QString moduleForMessage(const QDBusMessage & message);
Q_SIGNALS:
    void moduleDeleted(KDEDModule*  __0);
    void windowRegistered(long long windowId);
    void windowUnregistered(long long windowId);
    void moduleRegistered(const QDBusObjectPath & path);
private:
    private:
        KDEDModule(const KDEDModule &); // Generated
};
