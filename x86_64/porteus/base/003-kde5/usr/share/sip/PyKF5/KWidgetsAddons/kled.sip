// Discarded CLASS_DECL on line 16 'QColor' (by default forward declaration handling)
class KLed: QWidget
{
%TypeHeaderCode
#include <kled.h>
%End
    // Discarded VAR_DECL on line 37 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 37 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 37 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 37 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 37 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 37 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum State {
        Off,
        On
    };
    enum Shape {
        Rectangular,
        Circular
    };
    enum Look {
        Flat,
        Raised,
        Sunken
    };
    // Modified PARM_DECL on line 77 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KLed(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 87 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KLed(const QColor & color, QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 101 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KLed(const QColor & color, KLed::State state, KLed::Look look, KLed::Shape shape, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KLed();
    QColor color() const;
    KLed::State state() const;
    KLed::Look look() const;
    KLed::Shape shape() const;
    int darkFactor() const;
    void setColor(const QColor & color);
    void setState(KLed::State state);
    void setLook(KLed::Look look);
    void setShape(KLed::Shape shape);
    void setDarkFactor(int darkFactor);
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
public Q_SLOTS:
    void toggle();
    void on();
    void off();
protected:
    virtual void paintEvent(QPaintEvent*  __0);
    virtual void resizeEvent(QResizeEvent*  __0);
    void updateCachedPixmap();
private:
private:
    // Discarded CLASS_DECL on line 247 'KLedPrivate' (by default forward declaration handling)
    private:
        KLed(const KLed &); // Generated
};
