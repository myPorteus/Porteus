// Discarded CLASS_DECL on line 14 'KStatusBarJobTrackerPrivate' (by default forward declaration handling)
class KStatusBarJobTracker: KAbstractWidgetJobTracker
{
%TypeHeaderCode
#include <kstatusbarjobtracker.h>
%End
    // Discarded VAR_DECL on line 24 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 24 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 24 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 24 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 24 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 24 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    enum StatusBarMode {
        NoInformation,
        LabelOnly,
        ProgressOnly
    };
    typedef QFlags<KStatusBarJobTracker::StatusBarMode> StatusBarModes;
    // Modified PARM_DECL on line 47 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KStatusBarJobTracker(QWidget*  parent /TransferThis/ = nullptr, bool button = true);
    virtual ~KStatusBarJobTracker();
    virtual void registerJob(KJob*  job);
    virtual void unregisterJob(KJob*  job);
    virtual QWidget * widget(KJob*  job);
    void setStatusBarMode(QFlags<KStatusBarJobTracker::StatusBarMode> statusBarMode);
public Q_SLOTS:
    // Discarded CXX_METHOD on line 87 'description' (by Qt5Ruleset.py:FunctionRuleDb[7],function_discard)
    virtual void totalAmount(KJob*  job, KJob::Unit unit, unsigned long long amount);
    virtual void percent(KJob*  job, unsigned long percent);
    virtual void speed(KJob*  job, unsigned long value);
    virtual void slotClean(KJob*  job);
private:
    private:
        KStatusBarJobTracker(const KStatusBarJobTracker &); // Generated
};
// Discarded FUNCTION_DECL on line 101 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
// Discarded FUNCTION_DECL on line 101 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
// Discarded FUNCTION_DECL on line 101 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
