class KSelector: QAbstractSlider
{
%TypeHeaderCode
#include <kselector.h>
%End
    // Discarded VAR_DECL on line 34 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 34 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 34 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 34 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 34 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 34 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 44 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KSelector(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 49 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KSelector(Qt::Orientation o, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KSelector();
    QRect contentsRect() const;
    void setIndent(bool i);
    bool indent() const;
    void setArrowDirection(Qt::ArrowType direction);
    Qt::ArrowType arrowDirection() const;
protected:
    virtual void drawContents(QPainter*  __0);
    virtual void drawArrow(QPainter*  painter, const QPoint & pos);
    virtual void paintEvent(QPaintEvent*  __0);
    virtual void mousePressEvent(QMouseEvent*  e);
    virtual void mouseMoveEvent(QMouseEvent*  e);
    virtual void mouseReleaseEvent(QMouseEvent*  e);
    virtual void wheelEvent(QWheelEvent*  __0);
private:
private:
    // Discarded CLASS_DECL on line 107 'KSelectorPrivate' (by default forward declaration handling)
    KSelector(const KSelector & __0);
};
class KGradientSelector: KSelector
{
%TypeHeaderCode
#include <kselector.h>
%End
    // Discarded VAR_DECL on line 123 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 123 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 123 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 123 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 123 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 123 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 135 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KGradientSelector(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 140 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KGradientSelector(Qt::Orientation o, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KGradientSelector();
    // Discarded CXX_METHOD on line 151 'setStops' (by rules_PyKF5.py:FunctionRuleDb[15],function_discard)
    QGradientStops stops() const;
    void setColors(const QColor & col1, const QColor & col2);
    void setText(const QString & t1, const QString & t2);
    void setFirstColor(const QColor & col);
    void setSecondColor(const QColor & col);
    void setFirstText(const QString & t);
    void setSecondText(const QString & t);
    QColor firstColor() const;
    QColor secondColor() const;
    QString firstText() const;
    QString secondText() const;
protected:
    virtual void drawContents(QPainter*  __0);
    virtual QSize minimumSize() const;
private:
    // Discarded CLASS_DECL on line 189 'KGradientSelectorPrivate' (by default forward declaration handling)
    KGradientSelector(const KGradientSelector & __0);
};
