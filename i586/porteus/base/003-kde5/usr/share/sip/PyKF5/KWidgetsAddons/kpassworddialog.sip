class KPasswordDialog: QDialog
{
%TypeHeaderCode
#include <kpassworddialog.h>
%End
    // Discarded VAR_DECL on line 55 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 55 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum KPasswordDialogFlag {
        NoFlags,
        ShowKeepPassword,
        ShowUsernameLine,
        UsernameReadOnly,
        ShowAnonymousLoginCheckBox,
        ShowDomainLine,
        DomainReadOnly
    };
    typedef QFlags<KPasswordDialog::KPasswordDialogFlag> KPasswordDialogFlags;
    enum ErrorType {
        UnknownError,
        UsernameError,
        PasswordError,
        FatalError,
        DomainError
    };
    // Modified PARM_DECL on line 129 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPasswordDialog(QWidget*  parent /TransferThis/ = nullptr, const QFlags<KPasswordDialog::KPasswordDialogFlag> & flags = KPasswordDialog::NoFlags);
    virtual ~KPasswordDialog();
    void setPrompt(const QString & prompt);
    QString prompt() const;
    void setIcon(const QIcon & icon);
    QIcon icon() const;
    void setPixmap(const QPixmap & __0);
    QPixmap pixmap() const;
    void addCommentLine(const QString & label, const QString & comment);
    void showErrorMessage(const QString & message, const KPasswordDialog::ErrorType type = KPasswordDialog::PasswordError);
    QString password() const;
    void setUsername(const QString & __0);
    QString username() const;
    void setDomain(const QString & __0);
    QString domain() const;
    void setAnonymousMode(bool anonymous);
    bool anonymousMode() const;
    bool keepPassword() const;
    void setKeepPassword(bool b);
    void setUsernameReadOnly(bool readOnly);
    void setPassword(const QString & password);
    void setKnownLogins(const QMap<QString, QString> & knownLogins);
    virtual void accept();
    QDialogButtonBox * buttonBox() const;
    void setUsernameContextHelp(const QString & help);
Q_SIGNALS:
    void gotPassword(const QString & password, bool keep);
    void gotUsernameAndPassword(const QString & username, const QString & password, bool keep);
protected:
    virtual bool checkPassword();
private:
    // Discarded CLASS_DECL on line 332 'KPasswordDialogPrivate' (by default forward declaration handling)
    KPasswordDialog(const KPasswordDialog & __0);
};
// Discarded FUNCTION_DECL on line 337 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 337 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
// Discarded FUNCTION_DECL on line 337 'operator|' (by rules_PyKF5.py:FunctionRuleDb[24],function_discard)
