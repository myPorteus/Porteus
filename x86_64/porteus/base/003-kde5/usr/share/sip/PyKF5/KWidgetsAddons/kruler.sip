class KRuler: QAbstractSlider
{
%TypeHeaderCode
#include <kruler.h>
%End
    // Discarded VAR_DECL on line 55 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 55 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum MetricStyle {
        Custom,
        Pixel,
        Inch,
        Millimetres,
        Centimetres,
        Metres
    };
    // Modified PARM_DECL on line 83 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KRuler(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 96 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KRuler(Qt::Orientation orient, QWidget*  parent /TransferThis/ = nullptr, QFlags<Qt::WindowType> f = Qt::WindowFlags());
    // Modified PARM_DECL on line 112 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KRuler(Qt::Orientation orient, int widgetWidth, QWidget*  parent /TransferThis/ = nullptr, QFlags<Qt::WindowType> f = Qt::WindowFlags());
    virtual ~KRuler();
    void setMinValue(int __0);
    int minValue() const;
    void setMaxValue(int __0);
    int maxValue() const;
    void setTinyMarkDistance(int __0);
    int tinyMarkDistance() const;
    void setLittleMarkDistance(int __0);
    int littleMarkDistance() const;
    void setMediumMarkDistance(int __0);
    int mediumMarkDistance() const;
    void setBigMarkDistance(int __0);
    int bigMarkDistance() const;
    void setShowTinyMarks(bool __0);
    bool showTinyMarks() const;
    void setShowLittleMarks(bool __0);
    bool showLittleMarks() const;
    void setShowMediumMarks(bool __0);
    bool showMediumMarks() const;
    void setShowBigMarks(bool __0);
    bool showBigMarks() const;
    void setShowEndMarks(bool __0);
    bool showEndMarks() const;
    void setShowPointer(bool __0);
    bool showPointer() const;
    void setFrameStyle(int __0);
    void setShowEndLabel(bool __0);
    bool showEndLabel() const;
    void setEndLabel(const QString & __0);
    QString endLabel() const;
    void setRulerMetricStyle(KRuler::MetricStyle __0);
    void setPixelPerMark(double rate);
    double pixelPerMark() const;
    void setLength(int __0);
    int length() const;
    void setLengthFixed(bool fix);
    bool lengthFixed() const;
    void slideUp(int count = 1);
    void slideDown(int count = 1);
    void setOffset(int offset);
    int offset() const;
    int endOffset() const;
public Q_SLOTS:
    void slotNewValue(int __0);
    void slotNewOffset(int __0);
    void slotEndOffset(int __0);
protected:
    virtual void paintEvent(QPaintEvent*  __0);
private:
private:
    // Discarded CLASS_DECL on line 386 'KRulerPrivate' (by default forward declaration handling)
    private:
        KRuler(const KRuler &); // Generated
};
