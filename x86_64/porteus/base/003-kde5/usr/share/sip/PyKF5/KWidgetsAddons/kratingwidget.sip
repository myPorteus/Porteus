class KRatingWidget: QFrame
{
%TypeHeaderCode
#include <kratingwidget.h>
%End
    // Discarded VAR_DECL on line 30 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 30 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 42 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KRatingWidget(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KRatingWidget();
    unsigned int rating() const;
    int maxRating() const;
    Qt::Alignment alignment() const;
    Qt::LayoutDirection layoutDirection() const;
    int spacing() const;
    virtual QSize sizeHint() const;
    bool halfStepsEnabled() const;
    QIcon icon() const;
Q_SIGNALS:
    // Discarded CXX_METHOD on line 105 'ratingChanged' (by rules_PyKF5.py:FunctionRuleDb[3],function_discard)
    void ratingChanged(int rating);
public Q_SLOTS:
    void setRating(int rating);
    // Discarded CXX_METHOD on line 120 'setRating' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    void setMaxRating(int max);
    // Discarded CXX_METHOD on line 135 'setMaxRating' (by rules_PyKF5.py:FunctionRuleDb[5],function_discard)
    void setHalfStepsEnabled(bool enabled);
    void setOnlyPaintFullSteps(bool __0);
    void setSpacing(int __0);
    void setAlignment(QFlags<Qt::AlignmentFlag> align);
    void setLayoutDirection(Qt::LayoutDirection direction);
    void setIcon(const QIcon & icon);
    void setCustomPixmap(const QPixmap & pixmap);
    void setPixmap(const QPixmap & __0);
    void setPixmapSize(int size);
protected:
    virtual void mousePressEvent(QMouseEvent*  e);
    virtual void mouseMoveEvent(QMouseEvent*  e);
    virtual void leaveEvent(QEvent*  e);
    virtual void paintEvent(QPaintEvent*  e);
    virtual void resizeEvent(QResizeEvent*  e);
private:
    // Discarded CLASS_DECL on line 204 'KRatingWidgetPrivate' (by default forward declaration handling)
    private:
        KRatingWidget(const KRatingWidget &); // Generated
};
