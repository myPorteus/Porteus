class KNewPasswordWidget: QWidget
{
%TypeHeaderCode
#include <knewpasswordwidget.h>
%End
    // Discarded VAR_DECL on line 64 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 64 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 64 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 64 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 64 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 64 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum PasswordStatus {
        EmptyPasswordNotAllowed,
        PasswordTooShort,
        PasswordNotVerified,
        WeakPassword,
        StrongPassword
    };
    // Modified PARM_DECL on line 96 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KNewPasswordWidget(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KNewPasswordWidget();
    KNewPasswordWidget::PasswordStatus passwordStatus() const;
    bool allowEmptyPasswords() const;
    int minimumPasswordLength() const;
    int maximumPasswordLength() const;
    int reasonablePasswordLength() const;
    int passwordStrengthWarningLevel() const;
    QColor backgroundWarningColor() const;
    bool isPasswordStrengthMeterVisible() const;
    bool isRevealPasswordAvailable() const;
    QString password() const;
public Q_SLOTS:
    void setAllowEmptyPasswords(bool allowed);
    void setMinimumPasswordLength(int minLength);
    void setMaximumPasswordLength(int maxLength);
    void setReasonablePasswordLength(int reasonableLength);
    void setPasswordStrengthWarningLevel(int warningLevel);
    void setBackgroundWarningColor(const QColor & color);
    void setPasswordStrengthMeterVisible(bool visible);
    void setRevealPasswordAvailable(bool reveal);
Q_SIGNALS:
    void passwordStatusChanged();
private:
    // Discarded CLASS_DECL on line 238 'KNewPasswordWidgetPrivate' (by default forward declaration handling)
    KNewPasswordWidget(const KNewPasswordWidget & __0);
};
