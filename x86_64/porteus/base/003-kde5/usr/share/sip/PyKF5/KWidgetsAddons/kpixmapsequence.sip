// Discarded CLASS_DECL on line 16 'QPixmap' (by default forward declaration handling)
class KPixmapSequence
{
%TypeHeaderCode
#include <kpixmapsequence.h>
%End
public:
    KPixmapSequence();
    KPixmapSequence(const KPixmapSequence & other);
    KPixmapSequence(const QPixmap & pixmap, const QSize & frameSize = QSize());
    KPixmapSequence(const QString & fullPath, int size);
    ~KPixmapSequence();
    // Discarded CXX_METHOD on line 70 'operator=' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    bool isValid() const;
    bool isEmpty() const;
    QSize frameSize() const;
    int frameCount() const;
    QPixmap frameAt(int index) const;
private:
    // Discarded CLASS_DECL on line 104 'KPixmapSequencePrivate' (by default forward declaration handling)
};
