// Modified CLASS_DECL on line 31 'KSharedConfig' (by rules_PyKF5.py:ContainerRuleDb[19],discard_QSharedData_base):
class KSharedConfig: KConfig
{
%TypeHeaderCode
#include <ksharedconfig.h>
%End
public:
    typedef QExplicitlySharedDataPointer<KSharedConfig> Ptr;
public:
    // Discarded CXX_METHOD on line 61 'openConfig' (by rules_PyKF5.py:FunctionRuleDb[5],function_discard)
    // Discarded CXX_METHOD on line 84 'openStateConfig' (by rules_PyKF5.py:FunctionRuleDb[6],function_discard)
    virtual ~KSharedConfig();
private:
    KSharedConfig(const KSharedConfig & __0);
};
typedef KSharedConfig::Ptr KSharedConfigPtr;
