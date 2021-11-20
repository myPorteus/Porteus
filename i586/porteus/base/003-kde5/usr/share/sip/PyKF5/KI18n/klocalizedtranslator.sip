// Discarded CLASS_DECL on line 15 'KLocalizedTranslatorPrivate' (by default forward declaration handling)
class KLocalizedTranslator: QTranslator
{
%TypeHeaderCode
#include <klocalizedtranslator.h>
%End
    // Discarded VAR_DECL on line 57 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 57 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 57 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 57 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 57 'tr' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
    // Discarded CXX_METHOD on line 57 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[11],function_discard)
public:
    // Modified PARM_DECL on line 59 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KLocalizedTranslator(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KLocalizedTranslator();
    virtual QString translate(const char*  context, const char*  sourceText, const char*  disambiguation = nullptr, int n = -1) const;
    void setTranslationDomain(const QString & translationDomain);
    void addContextToMonitor(const QString & context);
    void removeContextToMonitor(const QString & context);
private:
    private:
        KLocalizedTranslator(const KLocalizedTranslator &); // Generated
};
