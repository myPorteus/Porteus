// Discarded CLASS_DECL on line 17 'KCategoryDrawerPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QPainter' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QModelIndex' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'QStyleOption' (by default forward declaration handling)
// Discarded CLASS_DECL on line 23 'KCategorizedView' (by default forward declaration handling)
class KCategoryDrawer: QObject
{
%TypeHeaderCode
#include <kcategorydrawer.h>
%End
    // Discarded VAR_DECL on line 34 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 34 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 34 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 34 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 34 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 34 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    KCategoryDrawer(KCategorizedView*  view);
    virtual ~KCategoryDrawer();
    KCategorizedView * view() const;
    virtual void drawCategory(const QModelIndex & index, int sortRole, const QStyleOption & option, QPainter*  painter) const;
    virtual int categoryHeight(const QModelIndex & index, const QStyleOption & option) const;
    virtual int leftMargin() const;
    virtual int rightMargin() const;
Q_SIGNALS:
    void collapseOrExpandClicked(const QModelIndex & index);
    void actionRequested(int action, const QModelIndex & index);
protected:
    virtual void mouseButtonPressed(const QModelIndex & index, const QRect & blockRect, QMouseEvent*  event);
    virtual void mouseButtonReleased(const QModelIndex & index, const QRect & blockRect, QMouseEvent*  event);
    virtual void mouseMoved(const QModelIndex & index, const QRect & blockRect, QMouseEvent*  event);
    virtual void mouseButtonDoubleClicked(const QModelIndex & index, const QRect & blockRect, QMouseEvent*  event);
    virtual void mouseLeft(const QModelIndex & index, const QRect & blockRect);
private:
    private:
        KCategoryDrawer(const KCategoryDrawer &); // Generated
};
class KCategoryDrawerV3: KCategoryDrawer
{
%TypeHeaderCode
#include <kcategorydrawer.h>
%End
public:
    KCategoryDrawerV3(KCategorizedView*  view);
};
