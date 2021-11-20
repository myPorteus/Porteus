// Discarded CLASS_DECL on line 16 'KPixmapSequence' (by default forward declaration handling)
// Discarded CLASS_DECL on line 17 'QWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QEvent' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QRect' (by default forward declaration handling)
class KPixmapSequenceOverlayPainter: QObject
{
%TypeHeaderCode
#include <kpixmapsequenceoverlaypainter.h>
%End
    // Discarded VAR_DECL on line 36 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 36 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 42 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPixmapSequenceOverlayPainter(QObject*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 43 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPixmapSequenceOverlayPainter(const KPixmapSequence & seq, QObject*  parent /TransferThis/ = nullptr);
    virtual ~KPixmapSequenceOverlayPainter();
    KPixmapSequence sequence() const;
    int interval() const;
    QRect rect() const;
    Qt::Alignment alignment() const;
    QPoint offset() const;
public Q_SLOTS:
    void setSequence(const KPixmapSequence & seq);
    void setInterval(int msecs);
    void setWidget(QWidget*  w);
    void setRect(const QRect & rect);
    void setAlignment(QFlags<Qt::AlignmentFlag> align);
    void setOffset(const QPoint & offset);
    void start();
    void stop();
protected:
    virtual bool eventFilter(QObject*  obj, QEvent*  event);
private:
    // Discarded CLASS_DECL on line 145 'KPixmapSequenceOverlayPainterPrivate' (by default forward declaration handling)
    private:
        KPixmapSequenceOverlayPainter(const KPixmapSequenceOverlayPainter &); // Generated
};
