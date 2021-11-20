// Discarded CLASS_DECL on line 18 'KJob' (by default forward declaration handling)
class KJobUiDelegate: QObject
{
%TypeHeaderCode
#include <kjobuidelegate.h>
%End
    // Discarded VAR_DECL on line 33 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 33 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 33 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 33 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 33 'tr' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 33 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public:
    enum Flag {
        AutoHandlingDisabled,
        AutoErrorHandlingEnabled,
        AutoWarningHandlingEnabled,
        AutoHandlingEnabled
    };
    typedef QFlags<KJobUiDelegate::Flag> Flags;
    KJobUiDelegate();
    KJobUiDelegate(QFlags<KJobUiDelegate::Flag> flags);
    virtual ~KJobUiDelegate();
protected:
    virtual bool setJob(KJob*  job);
protected:
    KJob * job() const;
public:
    virtual void showErrorMessage();
    void setAutoErrorHandlingEnabled(bool enable);
    bool isAutoErrorHandlingEnabled() const;
    void setAutoWarningHandlingEnabled(bool enable);
    bool isAutoWarningHandlingEnabled() const;
protected Q_SLOTS:
    virtual void slotWarning(KJob*  job, const QString & plain, const QString & rich);
private:
private:
    // Discarded CLASS_DECL on line 154 'KJobUiDelegatePrivate' (by default forward declaration handling)
    private:
        KJobUiDelegate(const KJobUiDelegate &); // Generated
};
// Discarded FUNCTION_DECL on line 157 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
// Discarded FUNCTION_DECL on line 157 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
// Discarded FUNCTION_DECL on line 157 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
