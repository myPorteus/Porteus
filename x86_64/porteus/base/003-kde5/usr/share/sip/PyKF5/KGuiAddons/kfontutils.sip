// Discarded CLASS_DECL on line 14 'QPainter' (by default forward declaration handling)
// Discarded CLASS_DECL on line 15 'QSizeF' (by default forward declaration handling)
// Discarded CLASS_DECL on line 16 'QString' (by default forward declaration handling)
namespace KFontUtils
{
%TypeHeaderCode
#include <kfontutils.h>
%End
    enum AdaptFontSizeOption {
        NoFlags,
        DoNotAllowWordWrap
    };
    typedef QFlags<KFontUtils::AdaptFontSizeOption> AdaptFontSizeOptions;
    // Discarded FUNCTION_DECL on line 36 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
    // Discarded FUNCTION_DECL on line 36 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
    // Discarded FUNCTION_DECL on line 36 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
    qreal adaptFontSize(QPainter & painter, const QString & text, double width, double height, double maxFontSize = 28.0, double minFontSize = 1.0, QFlags<KFontUtils::AdaptFontSizeOption> flags = KFontUtils::NoFlags);
    qreal adaptFontSize(QPainter & painter, const QString & text, const QSizeF & availableSize, double maxFontSize = 28.0, double minFontSize = 1.0, QFlags<KFontUtils::AdaptFontSizeOption> flags = KFontUtils::NoFlags);
};
