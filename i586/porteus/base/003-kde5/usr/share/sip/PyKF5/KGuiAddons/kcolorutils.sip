// Discarded CLASS_DECL on line 16 'QColor' (by default forward declaration handling)
namespace KColorUtils
{
%TypeHeaderCode
#include <kcolorutils.h>
%End
    qreal hue(const QColor & __0);
    qreal chroma(const QColor & __0);
    qreal luma(const QColor & __0);
    void getHcy(const QColor & __0, double*  hue, double*  chroma, double*  luma, double*  alpha = nullptr);
    QColor hcyColor(double hue, double chroma, double luma, double alpha = 1.0);
    qreal contrastRatio(const QColor & __0, const QColor & __1);
    QColor lighten(const QColor & __0, double amount = 0.5, double chromaInverseGain = 1.0);
    QColor darken(const QColor & __0, double amount = 0.5, double chromaGain = 1.0);
    QColor shade(const QColor & __0, double lumaAmount, double chromaAmount = 0.0);
    QColor tint(const QColor & base, const QColor & color, double amount = 0.3);
    QColor mix(const QColor & c1, const QColor & c2, double bias = 0.5);
    QColor overlayColors(const QColor & base, const QColor & paint, QPainter::CompositionMode comp = QPainter::CompositionMode_SourceOver);
};
