class KTitleWidget: QWidget
{
%TypeHeaderCode
#include <ktitlewidget.h>
%End
    // Discarded VAR_DECL on line 57 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 57 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 57 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 57 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 57 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 57 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum ImageAlignment {
        ImageLeft,
        ImageRight
    };
    enum MessageType {
        PlainMessage,
        InfoMessage,
        WarningMessage,
        ErrorMessage
    };
    // Modified PARM_DECL on line 96 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KTitleWidget(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KTitleWidget();
    void setWidget(QWidget*  widget);
    QString text() const;
    QString comment() const;
    const QPixmap * pixmap() const;
    QIcon icon() const;
    QSize iconSize() const;
    void setBuddy(QWidget*  buddy);
    int autoHideTimeout() const;
    int level();
public Q_SLOTS:
    void setText(const QString & text, QFlags<Qt::AlignmentFlag> alignment = Qt::AlignVCenter);
    void setText(const QString & text, KTitleWidget::MessageType type);
    void setComment(const QString & comment, KTitleWidget::MessageType type = KTitleWidget::PlainMessage);
    void setIcon(const QIcon & icon, KTitleWidget::ImageAlignment alignment = KTitleWidget::ImageRight);
    void setPixmap(const QPixmap & pixmap, KTitleWidget::ImageAlignment alignment = KTitleWidget::ImageRight);
    void setPixmap(const QString & icon, KTitleWidget::ImageAlignment alignment = KTitleWidget::ImageRight);
    void setPixmap(const QIcon & icon, KTitleWidget::ImageAlignment alignment = KTitleWidget::ImageRight);
    void setIcon(KTitleWidget::MessageType type, KTitleWidget::ImageAlignment alignment = KTitleWidget::ImageRight);
    void setPixmap(KTitleWidget::MessageType type, KTitleWidget::ImageAlignment alignment = KTitleWidget::ImageRight);
    void setIconSize(const QSize & iconSize);
    void setAutoHideTimeout(int msecs);
    void setLevel(int level);
protected:
    virtual void changeEvent(QEvent*  e);
    virtual void showEvent(QShowEvent*  event);
    virtual bool eventFilter(QObject*  object, QEvent*  event);
private:
    // Discarded CLASS_DECL on line 282 'KTitleWidgetPrivate' (by default forward declaration handling)
    KTitleWidget(const KTitleWidget & __0);
};
