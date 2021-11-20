// Discarded CLASS_DECL on line 19 'QWidget' (by default forward declaration handling)
class KNewPasswordDialog: QDialog
{
%TypeHeaderCode
#include <knewpassworddialog.h>
%End
    // Discarded VAR_DECL on line 60 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 60 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 60 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 60 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 60 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 60 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 68 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KNewPasswordDialog(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KNewPasswordDialog();
    void setPrompt(const QString & prompt);
    QString prompt() const;
    void setIcon(const QIcon & icon);
    QIcon icon() const;
    void setPixmap(const QPixmap & __0);
    QPixmap pixmap() const;
    void setAllowEmptyPasswords(bool allowed);
    bool allowEmptyPasswords() const;
    void setMinimumPasswordLength(int minLength);
    int minimumPasswordLength() const;
    void setMaximumPasswordLength(int maxLength);
    int maximumPasswordLength() const;
    void setReasonablePasswordLength(int reasonableLength);
    int reasonablePasswordLength() const;
    void setPasswordStrengthWarningLevel(int warningLevel);
    int passwordStrengthWarningLevel() const;
    void setBackgroundWarningColor(const QColor & color);
    QColor backgroundWarningColor() const;
    QString password() const;
    void setRevealPasswordAvailable(bool reveal);
    bool isRevealPasswordAvailable() const;
    virtual void accept();
protected:
    virtual bool checkPassword(const QString & __0);
    bool checkAndGetPassword(QString*  pwd);
Q_SIGNALS:
    void newPassword(const QString & password);
private:
    // Discarded CLASS_DECL on line 259 'KNewPasswordDialogPrivate' (by default forward declaration handling)
    private:
        KNewPasswordDialog(const KNewPasswordDialog &); // Generated
};
