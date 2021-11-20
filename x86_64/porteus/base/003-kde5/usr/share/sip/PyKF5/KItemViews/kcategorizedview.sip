// Discarded CLASS_DECL on line 16 'KCategoryDrawer' (by default forward declaration handling)
class KCategorizedView: QListView
{
%TypeHeaderCode
#include <kcategorizedview.h>
%End
    // Discarded VAR_DECL on line 70 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 70 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 70 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 70 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 70 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 70 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 76 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCategorizedView(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KCategorizedView();
    virtual void setModel(QAbstractItemModel*  model);
    void setGridSize(const QSize & size);
    void setGridSizeOwn(const QSize & size);
    virtual QRect visualRect(const QModelIndex & index) const;
    KCategoryDrawer * categoryDrawer() const;
    void setCategoryDrawer(KCategoryDrawer*  categoryDrawer);
    int categorySpacing() const;
    void setCategorySpacing(int categorySpacing);
    bool alternatingBlockColors() const;
    void setAlternatingBlockColors(bool enable);
    bool collapsibleBlocks() const;
    void setCollapsibleBlocks(bool enable);
    QModelIndexList block(const QString & category);
    QModelIndexList block(const QModelIndex & representative);
    virtual QModelIndex indexAt(const QPoint & point) const;
    virtual void reset();
protected:
    virtual void paintEvent(QPaintEvent*  event);
    virtual void resizeEvent(QResizeEvent*  event);
    virtual void setSelection(const QRect & rect, QFlags<QItemSelectionModel::SelectionFlag> flags);
    virtual void mouseMoveEvent(QMouseEvent*  event);
    virtual void mousePressEvent(QMouseEvent*  event);
    virtual void mouseReleaseEvent(QMouseEvent*  event);
    virtual void leaveEvent(QEvent*  event);
    virtual void startDrag(QFlags<Qt::DropAction> supportedActions);
    virtual void dragMoveEvent(QDragMoveEvent*  event);
    virtual void dragEnterEvent(QDragEnterEvent*  event);
    virtual void dragLeaveEvent(QDragLeaveEvent*  event);
    virtual void dropEvent(QDropEvent*  event);
    virtual QModelIndex moveCursor(QAbstractItemView::CursorAction cursorAction, QFlags<Qt::KeyboardModifier> modifiers);
    virtual void rowsAboutToBeRemoved(const QModelIndex & parent, int start, int end);
    virtual void updateGeometries();
    virtual void currentChanged(const QModelIndex & current, const QModelIndex & previous);
    virtual void dataChanged(const QModelIndex & topLeft, const QModelIndex & bottomRight, const QVector<int> & roles = QVector<int>());
    virtual void rowsInserted(const QModelIndex & parent, int start, int end);
protected Q_SLOTS:
    virtual void rowsInsertedArtifficial(const QModelIndex & parent, int start, int end);
    virtual void rowsRemoved(const QModelIndex & parent, int start, int end);
    virtual void slotLayoutChanged();
private:
    // Discarded CLASS_DECL on line 317 'KCategorizedViewPrivate' (by default forward declaration handling)
    private:
        KCategorizedView(const KCategorizedView &); // Generated
};
