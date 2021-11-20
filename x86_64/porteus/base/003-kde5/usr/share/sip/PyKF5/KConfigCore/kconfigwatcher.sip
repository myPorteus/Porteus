// Discarded CLASS_DECL on line 18 'KConfigWatcherPrivate' (by default forward declaration handling)
class KConfigWatcher: QObject
{
%TypeHeaderCode
#include <kconfigwatcher.h>
%End
    // Discarded VAR_DECL on line 28 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 28 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 28 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 28 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 28 'tr' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
    // Discarded CXX_METHOD on line 28 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[18],function_discard)
public:
    typedef QSharedPointer<KConfigWatcher> Ptr;
    // Discarded CXX_METHOD on line 37 'create' (by rules_PyKF5.py:FunctionRuleDb[29],function_discard)
    virtual ~KConfigWatcher();
    // Discarded CXX_METHOD on line 45 'config' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
Q_SIGNALS:
    void configChanged(const KConfigGroup & group, const QList<QByteArray> & names);
private:
private:
    KConfigWatcher(const KConfigWatcher & __0);
};
