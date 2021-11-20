namespace KAuth
{
%TypeHeaderCode
#include <kauthactionreply.h>
%End
    // Discarded CLASS_DECL on line 320 'ActionReplyData' (by default forward declaration handling)
    class ActionReply
    {
%TypeHeaderCode
#include <kauthactionreply.h>
%End
    public:
        enum Type {
            KAuthErrorType,
            HelperErrorType,
            SuccessType
        };
        static const KAuth::ActionReply SuccessReply();
        static const KAuth::ActionReply HelperErrorReply();
        static const KAuth::ActionReply HelperErrorReply(int error);
        static const KAuth::ActionReply NoResponderReply();
        static const KAuth::ActionReply NoSuchActionReply();
        static const KAuth::ActionReply InvalidActionReply();
        static const KAuth::ActionReply AuthorizationDeniedReply();
        static const KAuth::ActionReply UserCancelledReply();
        static const KAuth::ActionReply HelperBusyReply();
        static const KAuth::ActionReply AlreadyStartedReply();
        static const KAuth::ActionReply DBusErrorReply();
        enum Error {
            NoError,
            NoResponderError,
            NoSuchActionError,
            InvalidActionError,
            AuthorizationDeniedError,
            UserCancelledError,
            HelperBusyError,
            AlreadyStartedError,
            DBusError,
            BackendError
        };
        ActionReply();
        ActionReply(KAuth::ActionReply::Type type);
        // Discarded CONSTRUCTOR on line 400 'ActionReply' (by rules_PyKF5.py:FunctionRuleDb[0],function_discard)
        ActionReply(const KAuth::ActionReply & reply);
        virtual ~ActionReply();
        void setData(const QMap<QString, QVariant> & data);
        QVariantMap data() const;
        void addData(const QString & key, const QVariant & value);
        KAuth::ActionReply::Type type() const;
        void setType(KAuth::ActionReply::Type type);
        bool succeeded() const;
        bool failed() const;
        int error() const;
        KAuth::ActionReply::Error errorCode() const;
        void setError(int error);
        void setErrorCode(KAuth::ActionReply::Error errorCode);
        QString errorDescription() const;
        void setErrorDescription(const QString & error);
        QByteArray serialized() const;
        static KAuth::ActionReply deserialize(const QByteArray & data);
        // Discarded CXX_METHOD on line 560 'operator=' (by rules_PyKF5.py:FunctionRuleDb[2],function_discard)
        bool operator==(const KAuth::ActionReply & reply) const;
        bool operator!=(const KAuth::ActionReply & reply) const;
    private:
    };
};
// Discarded STRUCT_DECL on line 598 'QMetaTypeId' (by Qt5Ruleset.py:ContainerRuleDb[0],container_discard)
