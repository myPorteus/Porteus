class KSqueezedTextLabel: QLabel
{
%TypeHeaderCode
#include <ksqueezedtextlabel.h>
%End
    // Discarded VAR_DECL on line 55 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 55 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 55 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 65 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KSqueezedTextLabel(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 71 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KSqueezedTextLabel(const QString & text, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KSqueezedTextLabel();
    virtual QSize minimumSizeHint() const;
    virtual QSize sizeHint() const;
    void setIndent(int indent);
    void setMargin(int margin);
    virtual void setAlignment(QFlags<Qt::AlignmentFlag> __0);
    Qt::TextElideMode textElideMode() const;
    void setTextElideMode(Qt::TextElideMode mode);
    QString fullText() const;
    bool isSqueezed() const;
    QRect contentsRect() const;
public Q_SLOTS:
    void setText(const QString & text);
    void clear();
protected:
    virtual void mouseReleaseEvent(QMouseEvent*  __0);
    virtual void resizeEvent(QResizeEvent*  __0);
    virtual void contextMenuEvent(QContextMenuEvent*  __0);
    void squeezeTextToLabel();
private:
    // Discarded CLASS_DECL on line 209 'KSqueezedTextLabelPrivate' (by default forward declaration handling)
    private:
        KSqueezedTextLabel(const KSqueezedTextLabel &); // Generated
};
