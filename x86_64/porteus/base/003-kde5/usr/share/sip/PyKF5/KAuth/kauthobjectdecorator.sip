namespace KAuth
{
%TypeHeaderCode
#include <kauthobjectdecorator.h>
%End
    // Discarded CLASS_DECL on line 18 'ObjectDecoratorPrivate' (by default forward declaration handling)
    class ObjectDecorator: QObject
    {
%TypeHeaderCode
#include <kauthobjectdecorator.h>
%End
        // Discarded VAR_DECL on line 29 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
        // Discarded CXX_METHOD on line 29 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
        // Discarded CXX_METHOD on line 29 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
        // Discarded CXX_METHOD on line 29 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
        // Discarded CXX_METHOD on line 29 'tr' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
        // Discarded CXX_METHOD on line 29 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[1],function_discard)
    public:
        // Modified PARM_DECL on line 36 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
        ObjectDecorator(QObject*  parent /TransferThis/);
        virtual ~ObjectDecorator();
        KAuth::Action authAction() const;
        void setAuthAction(const KAuth::Action & action);
        void setAuthAction(const QString & actionName);
    Q_SIGNALS:
        void authorized(const KAuth::Action & action);
    private:
    private:
        ObjectDecorator(const KAuth::ObjectDecorator &); // Generated
    };
};
