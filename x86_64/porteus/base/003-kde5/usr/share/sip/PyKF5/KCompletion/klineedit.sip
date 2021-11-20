// Discarded CLASS_DECL on line 27 'QAction' (by default forward declaration handling)
// Discarded CLASS_DECL on line 28 'QMenu' (by default forward declaration handling)
// Discarded CLASS_DECL on line 29 'KCompletionBox' (by default forward declaration handling)
// Discarded CLASS_DECL on line 30 'QUrl' (by default forward declaration handling)
// Discarded CLASS_DECL on line 31 'KLineEditPrivate' (by default forward declaration handling)
class KLineEdit: QLineEdit, KCompletionBase
{
%TypeHeaderCode
#include <klineedit.h>
%End
    // Discarded VAR_DECL on line 143 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 143 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 143 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 143 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 143 'tr' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
    // Discarded CXX_METHOD on line 143 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[4],function_discard)
public:
    // Modified PARM_DECL on line 171 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KLineEdit(const QString & string, QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 177 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KLineEdit(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KLineEdit();
    void setUrl(const QUrl & url);
    virtual void setCompletionMode(KCompletion::CompletionMode mode);
    void setCompletionModeDisabled(KCompletion::CompletionMode mode, bool disable = true);
    virtual void setContextMenuEnabled(bool showMenu);
    bool isContextMenuEnabled() const;
    void setUrlDropsEnabled(bool enable);
    bool urlDropsEnabled() const;
    void setTrapReturnKey(bool trap);
    bool trapReturnKey() const;
    virtual KCompletionBox * completionBox(bool create = true);
    virtual void setCompletionObject(KCompletion*  __0, bool handle = true);
    virtual void copy() const;
    void setSqueezedTextEnabled(bool enable);
    bool isSqueezedTextEnabled() const;
    QString originalText() const;
    QString userText() const;
    void setCompletionBox(KCompletionBox*  box);
    void setClickMessage(const QString & msg);
    QString clickMessage() const;
    void setClearButtonShown(bool show);
    bool isClearButtonShown() const;
    QSize clearButtonUsedSize() const;
    void doCompletion(const QString & text);
Q_SIGNALS:
    void completionBoxActivated(const QString & __0);
    void returnPressed(const QString & text);
    void returnKeyPressed(const QString & text);
    void completion(const QString & __0);
    void substringCompletion(const QString & __0);
    void userTextChanged(const QString & __0);
    void textRotation(KCompletionBase::KeyBindingType __0);
    void completionModeChanged(KCompletion::CompletionMode __0);
    void aboutToShowContextMenu(QMenu*  contextMenu);
    void clearButtonClicked();
public Q_SLOTS:
    virtual void setReadOnly(bool __0);
    void rotateText(KCompletionBase::KeyBindingType type);
    virtual void setCompletedText(const QString & __0);
    virtual void setCompletedItems(const QStringList & items, bool autoSuggest = true);
    void setSqueezedText(const QString & text);
    virtual void setText(const QString & __0);
    void setPasswordMode(bool passwordMode = true);
    bool passwordMode() const;
protected Q_SLOTS:
    virtual void makeCompletion(const QString & __0);
    void userCancelled(const QString & cancelText);
protected:
    virtual bool event(QEvent*  __0);
    virtual void resizeEvent(QResizeEvent*  __0);
    virtual void keyPressEvent(QKeyEvent*  __0);
    virtual void mousePressEvent(QMouseEvent*  __0);
    virtual void mouseReleaseEvent(QMouseEvent*  __0);
    virtual void mouseDoubleClickEvent(QMouseEvent*  __0);
    virtual void contextMenuEvent(QContextMenuEvent*  __0);
    QMenu * createStandardContextMenu();
    virtual void setCompletedText(const QString & __0, bool __1);
    void setUserSelection(bool userSelection);
    bool autoSuggest() const;
    virtual void paintEvent(QPaintEvent*  ev);
private:
    private:
        KLineEdit(const KLineEdit &); // Generated
};
