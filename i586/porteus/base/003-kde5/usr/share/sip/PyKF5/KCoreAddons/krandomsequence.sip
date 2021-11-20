class KRandomSequence
{
%TypeHeaderCode
#include <krandomsequence.h>
%End
public:
    KRandomSequence(int intSeed = 0);
    KRandomSequence(long lngSeed);
    virtual ~KRandomSequence();
    KRandomSequence(const KRandomSequence & a);
    // Discarded CXX_METHOD on line 74 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    // Discarded CXX_METHOD on line 82 'setSeed' (by rules_PyKF5.py:FunctionRuleDb[6],function_discard)
    void setSeed(long lngSeed = 0);
    double getDouble();
    unsigned int getInt(unsigned int max);
    unsigned long getLong(unsigned long max);
    bool getBool();
    // Discarded FUNCTION_TEMPLATE on line 122 'randomize' (by rules_PyKF5.py:FunctionRuleDb[12],function_discard)
    void modulate(int i);
private:
    // Discarded CLASS_DECL on line 157 'KRandomSequencePrivate' (by default forward declaration handling)
};
