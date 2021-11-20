// Discarded CLASS_DECL on line 15 'QAction' (by default forward declaration handling)
class KPasswordLineEdit: QWidget
{
%TypeHeaderCode
#include <kpasswordlineedit.h>
%End
    // Discarded VAR_DECL on line 36 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 36 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 47 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPasswordLineEdit(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KPasswordLineEdit();
    void setPassword(const QString & password);
    QString password() const;
    void clear();
    void setClearButtonEnabled(bool clear);
    bool isClearButtonEnabled() const;
    void setEchoMode(QLineEdit::EchoMode mode);
    QLineEdit::EchoMode echoMode() const;
    void setRevealPasswordAvailable(bool reveal);
    bool isRevealPasswordAvailable() const;
    QAction * toggleEchoModeAction() const;
    QLineEdit * lineEdit() const;
Q_SIGNALS:
    void echoModeChanged(QLineEdit::EchoMode echoMode);
    void passwordChanged(const QString & password);
private:
    // Discarded CLASS_DECL on line 122 'KPasswordLineEditPrivate' (by default forward declaration handling)
    private:
        KPasswordLineEdit(const KPasswordLineEdit &); // Generated
};
