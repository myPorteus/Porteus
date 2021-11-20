// Discarded CLASS_DECL on line 16 'KColorButtonPrivate' (by default forward declaration handling)
class KColorButton: QPushButton
{
%TypeHeaderCode
#include <kcolorbutton.h>
%End
    // Discarded VAR_DECL on line 30 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 30 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 39 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KColorButton(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 44 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KColorButton(const QColor & c, QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 49 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KColorButton(const QColor & c, const QColor & defaultColor, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KColorButton();
    QColor color() const;
    void setColor(const QColor & c);
    void setAlphaChannelEnabled(bool alpha);
    bool isAlphaChannelEnabled() const;
    QColor defaultColor() const;
    void setDefaultColor(const QColor & c);
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
Q_SIGNALS:
    void changed(const QColor & newColor);
protected:
    virtual void paintEvent(QPaintEvent*  pe);
    virtual void dragEnterEvent(QDragEnterEvent*  __0);
    virtual void dropEvent(QDropEvent*  __0);
    virtual void mousePressEvent(QMouseEvent*  e);
    virtual void mouseMoveEvent(QMouseEvent*  e);
    virtual void keyPressEvent(QKeyEvent*  e);
private:
    private:
        KColorButton(const KColorButton &); // Generated
};
