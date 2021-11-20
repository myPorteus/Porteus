// Discarded CLASS_DECL on line 20 'QCursor' (by default forward declaration handling)
class KUrlLabel: QLabel
{
%TypeHeaderCode
#include <kurllabel.h>
%End
    // Discarded VAR_DECL on line 62 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 62 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 62 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 62 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 62 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 62 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 78 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KUrlLabel(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 91 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KUrlLabel(const QString & url, const QString & text = QString(), QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KUrlLabel();
    QString url() const;
    QString tipText() const;
    bool useTips() const;
    bool useCursor() const;
    bool isGlowEnabled() const;
    bool isFloatEnabled() const;
    const QPixmap * alternatePixmap() const;
public Q_SLOTS:
    void setUnderline(bool on = true);
    void setUrl(const QString & url);
    virtual void setFont(const QFont & font);
    void setUseTips(bool on = true);
    void setTipText(const QString & tip);
    void setHighlightedColor(const QColor & highcolor);
    void setHighlightedColor(const QString & highcolor);
    void setSelectedColor(const QColor & color);
    void setSelectedColor(const QString & color);
    void setUseCursor(bool on, QCursor*  cursor = nullptr);
    void setGlowEnabled(bool glow = true);
    void setFloatEnabled(bool do_float = true);
    void setAlternatePixmap(const QPixmap & pixmap);
Q_SIGNALS:
    void enteredUrl(const QString & url);
    void enteredUrl();
    void leftUrl(const QString & url);
    void leftUrl();
    void leftClickedUrl(const QString & url);
    void leftClickedUrl();
    void rightClickedUrl(const QString & url);
    void rightClickedUrl();
    void middleClickedUrl(const QString & url);
    void middleClickedUrl();
protected:
    virtual void mouseReleaseEvent(QMouseEvent*  __0);
    virtual void enterEvent(QEvent*  __0);
    virtual void leaveEvent(QEvent*  __0);
    virtual bool event(QEvent*  __0);
private:
    // Discarded CLASS_DECL on line 354 'KUrlLabelPrivate' (by default forward declaration handling)
    private:
        KUrlLabel(const KUrlLabel &); // Generated
};
