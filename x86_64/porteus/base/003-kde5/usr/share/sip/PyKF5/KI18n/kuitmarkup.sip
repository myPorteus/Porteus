// Discarded CLASS_DECL on line 17 'KuitSetup' (by default forward declaration handling)
namespace Kuit
{
%TypeHeaderCode
#include <kuitmarkup.h>
%End
    enum VisualFormat {
        UndefinedFormat,
        PlainText,
        RichText,
        TermText
    };
    enum TagClass {
        PhraseTag,
        StructTag
    };
    // Discarded TYPEDEF_DECL on line 75 'TagFormatter'
    // Discarded FUNCTION_DECL on line 88 'setupForDomain' (by rules_PyKF5.py:FunctionRuleDb[5],function_discard)
    // Discarded FUNCTION_DECL on line 90 'setupForDomain' (by rules_PyKF5.py:FunctionRuleDb[5],function_discard)
};
// Discarded CLASS_DECL on line 93 'KLocalizedString' (by default forward declaration handling)
// Discarded CLASS_DECL on line 94 'KuitSetupPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 95 'KuitFormatterPrivate' (by default forward declaration handling)
class KuitSetup
{
%TypeHeaderCode
#include <kuitmarkup.h>
%End
public:
    ~KuitSetup();
    // Discarded CXX_METHOD on line 145 'setTagPattern' (by rules_PyKF5.py:FunctionRuleDb[6],function_discard)
    void setTagClass(const QString & tagName, Kuit::TagClass aClass);
    void setFormatForMarker(const QString & marker, Kuit::VisualFormat format);
private:
    KuitSetup(const KuitSetup & __0);
};
