// Discarded CLASS_DECL on line 16 'QIcon' (by default forward declaration handling)
// Discarded CLASS_DECL on line 17 'QPixmap' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QPainter' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QPoint' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QRect' (by default forward declaration handling)
class KRatingPainter
{
%TypeHeaderCode
#include <kratingpainter.h>
%End
public:
    KRatingPainter();
    ~KRatingPainter();
    // Discarded CXX_METHOD on line 53 'operator=' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    int maxRating() const;
    bool halfStepsEnabled() const;
    Qt::Alignment alignment() const;
    Qt::LayoutDirection layoutDirection() const;
    QIcon icon() const;
    bool isEnabled() const;
    QPixmap customPixmap() const;
    int spacing() const;
    void setMaxRating(int max);
    void setHalfStepsEnabled(bool enabled);
    void setAlignment(QFlags<Qt::AlignmentFlag> align);
    void setLayoutDirection(Qt::LayoutDirection direction);
    void setIcon(const QIcon & icon);
    void setEnabled(bool enabled);
    void setCustomPixmap(const QPixmap & pixmap);
    void setSpacing(int spacing);
    void paint(QPainter*  painter, const QRect & rect, int rating, int hoverRating = -1) const;
    int ratingFromPosition(const QRect & rect, const QPoint & pos) const;
    static void paintRating(QPainter*  p, const QRect & rect, QFlags<Qt::AlignmentFlag> align, int rating, int hoverRating = -1);
    static int getRatingFromPosition(const QRect & rect, QFlags<Qt::AlignmentFlag> align, Qt::LayoutDirection direction, const QPoint & pos);
private:
    // Discarded CLASS_DECL on line 205 'KRatingPainterPrivate' (by default forward declaration handling)
    private:
        KRatingPainter(const KRatingPainter &); // Generated
};
