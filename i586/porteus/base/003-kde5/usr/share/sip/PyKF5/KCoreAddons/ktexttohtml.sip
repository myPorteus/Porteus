namespace KTextToHTML
{
%TypeHeaderCode
#include <ktexttohtml.h>
%End
    enum Option {
        PreserveSpaces,
        ReplaceSmileys,
        IgnoreUrls,
        HighlightText,
        ConvertPhoneNumbers
    };
    typedef QFlags<KTextToHTML::Option> Options;
    // Discarded FUNCTION_DECL on line 60 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
    // Discarded FUNCTION_DECL on line 60 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
    // Discarded FUNCTION_DECL on line 60 'operator|' (by rules_PyKF5.py:FunctionRuleDb[25],function_discard)
    QString convertToHtml(const QString & plainText, const QFlags<KTextToHTML::Option> & options, int maxUrlLen = 4096, int maxAddressLen = 255);
};
