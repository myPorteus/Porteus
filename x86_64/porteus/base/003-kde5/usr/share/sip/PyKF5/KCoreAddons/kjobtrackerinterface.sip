class KJobTrackerInterface: QObject
{
%TypeHeaderCode
#include <kjobtrackerinterface.h>
%End
    // Discarded VAR_DECL on line 27 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 27 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 27 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 27 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 27 'tr' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 27 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public:
    // Modified PARM_DECL on line 35 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KJobTrackerInterface(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KJobTrackerInterface();
public Q_SLOTS:
    virtual void registerJob(KJob*  job);
    virtual void unregisterJob(KJob*  job);
protected Q_SLOTS:
    virtual void finished(KJob*  job);
    virtual void suspended(KJob*  job);
    virtual void resumed(KJob*  job);
    // Discarded CXX_METHOD on line 117 'description' (by rules_PyKF5.py:FunctionRuleDb[16],function_discard)
    virtual void infoMessage(KJob*  job, const QString & plain, const QString & rich);
    virtual void warning(KJob*  job, const QString & plain, const QString & rich);
    virtual void totalAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    virtual void processedAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    virtual void percent(KJob*  job, unsigned long percent);
    virtual void speed(KJob*  job, unsigned long value);
private:
    // Discarded CLASS_DECL on line 178 'KJobTrackerInterfacePrivate' (by default forward declaration handling)
    private:
        KJobTrackerInterface(const KJobTrackerInterface &); // Generated
};
