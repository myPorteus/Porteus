class KDialogJobUiDelegate: KJobUiDelegate
{
%TypeHeaderCode
#include <kdialogjobuidelegate.h>
%End
    // Discarded VAR_DECL on line 27 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 27 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 27 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 27 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 27 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 27 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    KDialogJobUiDelegate();
    KDialogJobUiDelegate(QFlags<KJobUiDelegate::Flag> flags, QWidget*  window);
    virtual ~KDialogJobUiDelegate();
public:
    virtual bool setJob(KJob*  job);
    virtual void setWindow(QWidget*  window);
    QWidget * window() const;
    void updateUserTimestamp(unsigned long time);
    unsigned long userTimestamp() const;
    virtual void showErrorMessage();
protected Q_SLOTS:
    virtual void slotWarning(KJob*  job, const QString & plain, const QString & rich);
private:
    // Discarded CLASS_DECL on line 86 'KDialogJobUiDelegatePrivate' (by default forward declaration handling)
    private:
        KDialogJobUiDelegate(const KDialogJobUiDelegate &); // Generated
};
