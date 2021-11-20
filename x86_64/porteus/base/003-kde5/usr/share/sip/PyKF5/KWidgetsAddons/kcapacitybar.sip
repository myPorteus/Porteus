// Discarded CLASS_DECL on line 16 'QPaintEvent' (by default forward declaration handling)
class KCapacityBar: QWidget
{
%TypeHeaderCode
#include <kcapacitybar.h>
%End
    // Discarded VAR_DECL on line 36 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 36 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum DrawTextMode {
        DrawTextInline,
        DrawTextOutline
    };
    // Modified PARM_DECL on line 58 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCapacityBar(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 67 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCapacityBar(KCapacityBar::DrawTextMode drawTextMode, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KCapacityBar();
    void setValue(int value);
    int value() const;
    void setText(const QString & text);
    QString text() const;
    void setFillFullBlocks(bool fillFullBlocks);
    bool fillFullBlocks() const;
    void setContinuous(bool continuous);
    bool continuous() const;
    void setBarHeight(int barHeight);
    int barHeight() const;
    void setHorizontalTextAlignment(QFlags<Qt::AlignmentFlag> textAlignment);
    Qt::Alignment horizontalTextAlignment() const;
    void setDrawTextMode(KCapacityBar::DrawTextMode mode);
    KCapacityBar::DrawTextMode drawTextMode() const;
    void drawCapacityBar(QPainter*  p, const QRect & rect) const;
    virtual QSize minimumSizeHint() const;
protected:
    virtual void paintEvent(QPaintEvent*  event);
    virtual void changeEvent(QEvent*  event);
private:
    // Discarded CLASS_DECL on line 219 'KCapacityBarPrivate' (by default forward declaration handling)
    private:
        KCapacityBar(const KCapacityBar &); // Generated
};
