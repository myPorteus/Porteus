class KXYSelector: QWidget
{
%TypeHeaderCode
#include <kxyselector.h>
%End
    // Discarded VAR_DECL on line 31 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 31 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 40 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KXYSelector(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KXYSelector();
    void setValues(int xPos, int yPos);
    void setXValue(int xPos);
    void setYValue(int yPos);
    void setRange(int minX, int minY, int maxX, int maxY);
    void setMarkerColor(const QColor & col);
    int xValue() const;
    int yValue() const;
    QRect contentsRect() const;
    virtual QSize minimumSizeHint() const;
Q_SIGNALS:
    void valueChanged(int x, int y);
protected:
    virtual void drawContents(QPainter*  __0);
    virtual void drawMarker(QPainter*  p, int xp, int yp);
    virtual void paintEvent(QPaintEvent*  e);
    virtual void mousePressEvent(QMouseEvent*  e);
    virtual void mouseMoveEvent(QMouseEvent*  e);
    virtual void wheelEvent(QWheelEvent*  __0);
    void valuesFromPosition(int x, int y, int & xVal, int & yVal) const;
private:
private:
    // Discarded CLASS_DECL on line 133 'KXYSelectorPrivate' (by default forward declaration handling)
    KXYSelector(const KXYSelector & __0);
};
