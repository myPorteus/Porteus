// Discarded CLASS_DECL on line 15 'QFontMetrics' (by default forward declaration handling)
// Discarded CLASS_DECL on line 16 'QRect' (by default forward declaration handling)
// Discarded CLASS_DECL on line 17 'QString' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QPainter' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'KWordWrapPrivate' (by default forward declaration handling)
class KWordWrap
{
%TypeHeaderCode
#include <kwordwrap.h>
%End
public:
    enum  {
        FadeOut,
        Truncate
    };
    static KWordWrap formatText(QFontMetrics & fm, const QRect & r, int flags, const QString & str, int len = -1);
    QRect boundingRect() const;
    QString wrappedString() const;
    QString truncatedString(bool dots = true) const;
    void drawText(QPainter*  painter, int x, int y, int flags = Qt::AlignLeft) const;
    ~KWordWrap();
    KWordWrap(const KWordWrap & other);
    // Discarded CXX_METHOD on line 114 'operator=' (by Qt5Ruleset.py:FunctionRuleDb[1],function_discard)
    static void drawFadeoutText(QPainter*  p, int x, int y, int maxW, const QString & t);
    static void drawTruncateText(QPainter*  p, int x, int y, int maxW, const QString & t);
private:
};
