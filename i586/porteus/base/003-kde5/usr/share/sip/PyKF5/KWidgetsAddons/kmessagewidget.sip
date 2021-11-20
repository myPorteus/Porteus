class KMessageWidget: QFrame
{
%TypeHeaderCode
#include <kmessagewidget.h>
%End
    // Discarded VAR_DECL on line 89 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 89 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 89 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 89 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 89 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 89 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum MessageType {
        Positive,
        Information,
        Warning,
        Error
    };
    // Modified PARM_DECL on line 112 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KMessageWidget(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 118 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KMessageWidget(const QString & text, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KMessageWidget();
    QString text() const;
    bool wordWrap() const;
    bool isCloseButtonVisible() const;
    KMessageWidget::MessageType messageType() const;
    void addAction(QAction*  action);
    void removeAction(QAction*  action);
    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;
    virtual int heightForWidth(int width) const;
    QIcon icon() const;
    bool isHideAnimationRunning() const;
    bool isShowAnimationRunning() const;
public Q_SLOTS:
    void setText(const QString & text);
    void setWordWrap(bool wordWrap);
    void setCloseButtonVisible(bool visible);
    void setMessageType(KMessageWidget::MessageType type);
    void animatedShow();
    void animatedHide();
    void setIcon(const QIcon & icon);
Q_SIGNALS:
    void linkActivated(const QString & contents);
    void linkHovered(const QString & contents);
    void hideAnimationFinished();
    void showAnimationFinished();
protected:
    virtual void paintEvent(QPaintEvent*  event);
    virtual bool event(QEvent*  event);
    virtual void resizeEvent(QResizeEvent*  event);
private:
    // Discarded CLASS_DECL on line 332 'KMessageWidgetPrivate' (by default forward declaration handling)
    private:
        KMessageWidget(const KMessageWidget &); // Generated
};
