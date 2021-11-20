// Discarded CLASS_DECL on line 18 'KDBusInterProcessLockPrivate' (by default forward declaration handling)
class KDBusInterProcessLock: QObject
{
%TypeHeaderCode
#include <kdbusinterprocesslock.h>
%End
    // Discarded VAR_DECL on line 53 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 53 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 53 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 53 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 53 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 53 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    KDBusInterProcessLock(const QString & resource);
    virtual ~KDBusInterProcessLock();
    QString resource() const;
    void lock();
    void unlock();
    void waitForLockGranted();
Q_SIGNALS:
    void lockGranted(KDBusInterProcessLock*  lock);
private:
    private:
        KDBusInterProcessLock(const KDBusInterProcessLock &); // Generated
};
