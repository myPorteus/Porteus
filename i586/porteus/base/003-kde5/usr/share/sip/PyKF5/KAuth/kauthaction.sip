namespace KAuth
{
%TypeHeaderCode
#include <kauthaction.h>
%End
    // Discarded CLASS_DECL on line 20 'ExecuteJob' (by default forward declaration handling)
    // Discarded CLASS_DECL on line 22 'ActionData' (by default forward declaration handling)
    class Action
    {
%TypeHeaderCode
#include <kauthaction.h>
%End
    public:
        // Discarded VAR_DECL on line 72 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
        // Discarded CXX_METHOD on line 72 'qt_check_for_QGADGET_macro' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
        typedef void QtGadgetHelper;
    private:
    public:
        enum AuthStatus {
            DeniedStatus,
            ErrorStatus,
            InvalidStatus,
            AuthorizedStatus,
            AuthRequiredStatus,
            UserCancelledStatus
        };
        enum ExecutionMode {
            ExecuteMode,
            AuthorizeOnlyMode
        };
        enum class AuthDetail {
            DetailOther,
            DetailMessage
        };
        typedef QMap<KAuth::Action::AuthDetail, QVariant> DetailsMap;
        Action();
        Action(const KAuth::Action & action);
        Action(const QString & name);
        Action(const QString & name, const QString & details);
        Action(const QString & name, const QMap<KAuth::Action::AuthDetail, QVariant> & details);
        ~Action();
        // Discarded CXX_METHOD on line 152 'operator=' (by rules_PyKF5.py:FunctionRuleDb[2],function_discard)
        bool operator==(const KAuth::Action & action) const;
        bool operator!=(const KAuth::Action & action) const;
        QString name() const;
        void setName(const QString & name);
        int timeout() const;
        void setTimeout(int timeout);
        void setDetails(const QString & details);
        void setDetailsV2(const QMap<KAuth::Action::AuthDetail, QVariant> & details);
        QString details() const;
        KAuth::Action::DetailsMap detailsV2() const;
        bool isValid() const;
        QString helperId() const;
        void setHelperId(const QString & id);
        bool hasHelper() const;
        void setArguments(const QMap<QString, QVariant> & arguments);
        QVariantMap arguments() const;
        void addArgument(const QString & key, const QVariant & value);
        KAuth::Action::AuthStatus status() const;
        KAuth::ExecuteJob * execute(KAuth::Action::ExecutionMode mode = KAuth::Action::ExecuteMode);
        void // Modified PARM_DECL on line 420 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
        setParentWidget(QWidget*  parent /TransferThis/);
        QWidget * parentWidget() const;
    private:
    };
};
