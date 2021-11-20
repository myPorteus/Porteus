// Discarded CLASS_DECL on line 16 'KPageModel' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QAbstractItemDelegate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QAbstractItemView' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QModelIndex' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'KPageViewPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'QAbstractItemModel' (by default forward declaration handling)
class KPageView: QWidget
{
%TypeHeaderCode
#include <kpageview.h>
%End
    // Discarded VAR_DECL on line 51 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 51 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 51 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 51 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 51 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 51 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum FaceType {
        Auto,
        Plain,
        List,
        Tree,
        Tabbed
    };
    // Modified PARM_DECL on line 91 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPageView(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KPageView();
    void setModel(QAbstractItemModel*  model);
    QAbstractItemModel * model() const;
    void setFaceType(KPageView::FaceType faceType);
    KPageView::FaceType faceType() const;
    void setCurrentPage(const QModelIndex & index);
    QModelIndex currentPage() const;
    void setItemDelegate(QAbstractItemDelegate*  delegate);
    QAbstractItemDelegate * itemDelegate() const;
    void setDefaultWidget(QWidget*  widget);
    void setPageHeader(QWidget*  header);
    QWidget * pageHeader() const;
    void setPageFooter(QWidget*  footer);
    QWidget * pageFooter() const;
Q_SIGNALS:
    void currentPageChanged(const QModelIndex & current, const QModelIndex & previous);
protected:
    virtual QAbstractItemView * createView();
    virtual bool showPageHeader() const;
    virtual Qt::Alignment viewPosition() const;
    // Discarded CONSTRUCTOR on line 208 'KPageView' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    // Discarded FIELD_DECL on line 209 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
    private:
        KPageView(const KPageView &); // Generated
};
