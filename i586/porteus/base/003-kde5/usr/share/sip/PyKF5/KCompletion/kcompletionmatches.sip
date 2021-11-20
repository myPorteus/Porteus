// Discarded CLASS_DECL on line 17 'KCompletionMatchesWrapper' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'KCompletionMatchesPrivate' (by default forward declaration handling)
typedef KSortableList<QString> KCompletionMatchesList;
// Modified CLASS_DECL on line 42 'KCompletionMatches' (by rules_PyKF5.py:ContainerRuleDb[0],_container_discard_base):
class KCompletionMatches
{
%TypeHeaderCode
#include <kcompletionmatches.h>
%End
public:
    // Discarded CXX_METHOD on line 45 'd_func' (by rules_PyKF5.py:FunctionRuleDb[19],function_discard)
    // Discarded CXX_METHOD on line 45 'd_func' (by rules_PyKF5.py:FunctionRuleDb[19],function_discard)
    KCompletionMatches(bool sort);
    KCompletionMatches(const KCompletionMatches & __0);
    // Discarded CXX_METHOD on line 61 'operator=' (by rules_PyKF5.py:FunctionRuleDb[5],function_discard)
    // Discarded CONSTRUCTOR on line 66 'KCompletionMatches' (by rules_PyKF5.py:FunctionRuleDb[3],function_discard)
    ~KCompletionMatches();
    void removeDuplicates();
    QStringList list(bool sort = true) const;
    bool sorting() const;
private:
};
