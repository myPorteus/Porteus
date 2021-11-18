<?xml version='1.0' encoding='UTF-8'?><!-- -*- indent-tabs-mode: nil -*- -->
<!--
This program is free software; you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
details.

You should have received a copy of the GNU Lesser General Public License
along with this program; see the file COPYING.LGPL.  If not, see <http://www.gnu.org/licenses/>.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msg="http://projects.gnome.org/yelp/gettext/"
                xmlns:str="http://exslt.org/strings"
                exclude-result-prefixes="msg str"
                version="1.0">

<!--!!==========================================================================
Localized Strings
-->


<!--++==========================================================================
l10n.msgstr.key
Get a translated message from an ID and a language.
:Revision:version="3.4" date="2012-01-26" status="final"

This key indexes all message translations in a message catalog file. The elements
are indexed by the concatenation of the message id, the string #{__LC__}, and the
#{xml:lang} attribute converted to lowercase.
-->
<xsl:key name="l10n.msgstr.key" match="msg:msgstr"
         use="concat(../@id, '__LC__',
              translate(@xml:lang,
                        'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                        'abcdefghijklmnopqrstuvwxyz'))"/>


<!--@@==========================================================================
l10n.locale
The top-level locale of the document
-->
<xsl:param name="l10n.locale">
  <xsl:choose>
    <xsl:when test="/*/@xml:lang">
      <xsl:value-of select="/*/@xml:lang"/>
    </xsl:when>
    <xsl:when test="/*/@lang">
      <xsl:value-of select="/*/@lang"/>
    </xsl:when>
  </xsl:choose>
</xsl:param>

<xsl:variable name="l10n.locale.list" select="str:tokenize($l10n.locale, '-_@.')"/>


<!--**==========================================================================
l10n.gettext
Looks up the translation for a string
$domain: The domain to look up the string in.
$msgid: The id of the string to look up, often the string in the C locale.
$lang: The locale to use when looking up the translated string.
$number: The cardinality for plural-form lookups.
$form: The form name for plural-form lookups.

REMARK: Lots of documentation is needed
-->
<xsl:template name="l10n.gettext">
  <xsl:param name="domain" select="'yelp-xsl'"/>
  <xsl:param name="msgid"/>
  <xsl:param name="lang" select="(ancestor-or-self::*[@lang][1]/@lang |
                                  ancestor-or-self::*[@xml:lang][1]/@xml:lang)
                                 [last()]"/>
  <xsl:param name="number"/>
  <xsl:param name="form">
    <xsl:if test="$number">
      <xsl:call-template name="l10n.plural.form">
        <xsl:with-param name="number" select="$number"/>
        <xsl:with-param name="lang" select="$lang"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:param>
  <xsl:param name="role" select="''"/>
  <xsl:param name="node" select="."/>
  <xsl:param name="string"/>
  <xsl:param name="format" select="false()"/>

  <xsl:variable name="source" select="."/>
  <xsl:variable name="normlang" select="translate($lang,
                                        '_@.ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                        '---abcdefghijklmnopqrstuvwxyz')"/>
  <xsl:for-each select="document(concat('domains/', $domain, '.xml'))">
    <xsl:variable name="msg" select="key('l10n.msgstr.key', concat($msgid, '__LC__', $normlang))"/>
    <xsl:choose>
      <xsl:when test="$msg">
        <xsl:for-each select="$source">
          <xsl:call-template name="l10n.gettext.msg">
            <xsl:with-param name="msg" select="$msg"/>
            <xsl:with-param name="form" select="$form"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="contains($normlang, '-')">
        <xsl:variable name="newlang">
          <xsl:for-each select="str:split($normlang, '-')[position() != last()]">
            <xsl:if test="position() != 1">
              <xsl:text>-</xsl:text>
            </xsl:if>
            <xsl:value-of select="."/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$source">
          <xsl:call-template name="l10n.gettext">
            <xsl:with-param name="domain" select="$domain"/>
            <xsl:with-param name="msgid" select="$msgid"/>
            <xsl:with-param name="lang" select="$newlang"/>
            <xsl:with-param name="number" select="$number"/>
            <xsl:with-param name="form" select="$form"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="$normlang = 'c'">
        <xsl:variable name="cmsg" select="key('l10n.msgstr.key', concat($msgid, '__LC__'))"/>
        <xsl:choose>
          <xsl:when test="$cmsg">
            <xsl:for-each select="$source">
              <xsl:call-template name="l10n.gettext.msg">
                <xsl:with-param name="msg" select="$cmsg"/>
                <xsl:with-param name="form" select="$form"/>
                <xsl:with-param name="node" select="$node"/>
                <xsl:with-param name="role" select="$role"/>
                <xsl:with-param name="string" select="$string"/>
                <xsl:with-param name="format" select="$format"/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$msgid"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="$source">
          <xsl:call-template name="l10n.gettext">
            <xsl:with-param name="domain" select="$domain"/>
            <xsl:with-param name="msgid" select="$msgid"/>
            <xsl:with-param name="lang" select="'C'"/>
            <xsl:with-param name="number" select="$number"/>
            <xsl:with-param name="form" select="$form"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>

<!--#* l10n.gettext.msg -->
<xsl:template name="l10n.gettext.msg">
  <xsl:param name="msg"/>
  <xsl:param name="form" select="''"/>
  <xsl:param name="node" select="."/>
  <xsl:param name="role" select="''"/>
  <xsl:param name="string"/>
  <xsl:param name="format" select="false()"/>
  <xsl:choose>
    <xsl:when test="not($msg/msg:msgstr)">
      <xsl:call-template name="l10n.gettext.msgstr">
        <xsl:with-param name="msgstr" select="$msg"/>
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="role" select="$role"/>
        <xsl:with-param name="string" select="$string"/>
        <xsl:with-param name="format" select="$format"/>
      </xsl:call-template>
    </xsl:when>
    <!-- FIXME: OPTIMIZE: this needs to be faster -->
    <xsl:when test="$form != '' and $role != ''">
      <xsl:variable name="msgstr_form" select="$msg/msg:msgstr[@form = $form]"/>
      <xsl:choose>
        <xsl:when test="$msgstr_form">
          <xsl:choose>
            <xsl:when test="msgstr_form[@role = $role]">
              <xsl:call-template name="l10n.gettext.msgstr">
                <xsl:with-param name="msgstr"
                                select="msgstr_form[@role = $role][1]"/>
                <xsl:with-param name="node" select="$node"/>
                <xsl:with-param name="role" select="$role"/>
                <xsl:with-param name="string" select="$string"/>
                <xsl:with-param name="format" select="$format"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="msgstr_form[not(@role)]">
              <xsl:call-template name="l10n.gettext.msgstr">
                <xsl:with-param name="msgstr"
                                select="msgstr_form[not(@role)][1]"/>
                <xsl:with-param name="node" select="$node"/>
                <xsl:with-param name="role" select="$role"/>
                <xsl:with-param name="string" select="$string"/>
                <xsl:with-param name="format" select="$format"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="l10n.gettext.msgstr">
                <xsl:with-param name="msgstr"
                                select="msgstr_form[1]"/>
                <xsl:with-param name="node" select="$node"/>
                <xsl:with-param name="role" select="$role"/>
                <xsl:with-param name="string" select="$string"/>
                <xsl:with-param name="format" select="$format"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$msg/msg:msgstr[@role = $role]">
              <xsl:call-template name="l10n.gettext.msgstr">
                <xsl:with-param name="msgstr"
                                select="$msg/msg:msgstr[@role = $role][1]"/>
                <xsl:with-param name="node" select="$node"/>
                <xsl:with-param name="role" select="$role"/>
                <xsl:with-param name="string" select="$string"/>
                <xsl:with-param name="format" select="$format"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="$msg/msg:msgstr[not(@role)]">
              <xsl:call-template name="l10n.gettext.msgstr">
                <xsl:with-param name="msgstr"
                                select="$msg/msg:msgstr[not(@role)][1]"/>
                <xsl:with-param name="node" select="$node"/>
                <xsl:with-param name="role" select="$role"/>
                <xsl:with-param name="string" select="$string"/>
                <xsl:with-param name="format" select="$format"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="l10n.gettext.msgstr">
                <xsl:with-param name="msgstr"
                                select="$msg/msg:msgstr[1]"/>
                <xsl:with-param name="node" select="$node"/>
                <xsl:with-param name="role" select="$role"/>
                <xsl:with-param name="string" select="$string"/>
                <xsl:with-param name="format" select="$format"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="$form != ''">
      <xsl:choose>
        <xsl:when test="$msg/msg:msgstr[@form = $form]">
          <xsl:call-template name="l10n.gettext.msgstr">
            <xsl:with-param name="msgstr"
                            select="$msg/msg:msgstr[@form = $form][1]"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$msg/msg:msgstr[not(@form)]">
          <xsl:call-template name="l10n.gettext.msgstr">
            <xsl:with-param name="msgstr"
                            select="$msg/msg:msgstr[not(@form)][1]"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="l10n.gettext.msgstr">
            <xsl:with-param name="msgstr" select="$msg/msg:msgstr[1]"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="$role != ''">
      <xsl:choose>
        <xsl:when test="$msg/msg:msgstr[@role = $role]">
          <xsl:call-template name="l10n.gettext.msgstr">
            <xsl:with-param name="msgstr"
                            select="$msg/msg:msgstr[@role = $role][1]"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$msg/msg:msgstr[not(@role)]">
          <xsl:call-template name="l10n.gettext.msgstr">
            <xsl:with-param name="msgstr"
                            select="$msg/msg:msgstr[not(@role)][1]"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="l10n.gettext.msgstr">
            <xsl:with-param name="msgstr" select="$msg/msg:msgstr[1]"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$msg/msg:msgstr[not(@role)]">
          <xsl:call-template name="l10n.gettext.msgstr">
            <xsl:with-param name="msgstr"
                            select="$msg/msg:msgstr[not(@role)][1]"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="l10n.gettext.msgstr">
            <xsl:with-param name="msgstr" select="$msg/msg:msgstr[1]"/>
            <xsl:with-param name="node" select="$node"/>
            <xsl:with-param name="role" select="$role"/>
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--#* l10n.gettext.msgstr -->
<xsl:template name="l10n.gettext.msgstr">
  <xsl:param name="msgstr"/>
  <xsl:param name="node" select="."/>
  <xsl:param name="role"/>
  <xsl:param name="string"/>
  <xsl:param name="format" select="false()"/>
  <xsl:choose>
    <xsl:when test="$format">
      <xsl:apply-templates mode="l10n.format.mode" select="$msgstr/node()">
        <xsl:with-param name="node" select="$node"/>
        <xsl:with-param name="string" select="$string"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$msgstr"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--**==========================================================================
l10n.plural.form
Extracts he plural form string for a given cardinality
$number: The cardinality of the plural form
$lang: The locale to use when looking up the translated string

REMARK: Lots of documentation is needed
-->
<xsl:template name="l10n.plural.form">
  <xsl:param name="number" select="1"/>
  <xsl:param name="lang" select="$l10n.locale"/>
  <xsl:variable name="normlang" select="concat(translate($lang,
                                        '_@.ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                        '---abcdefghijklmnopqrstuvwxyz'),
                                        '-')"/>

  <xsl:choose>
    <!-- == pt_BR == -->
    <xsl:when test="starts-with($normlang, 'pt-br-')">
      <xsl:choose>
        <xsl:when test="$number &gt; 1">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>1</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- == ar == -->
    <xsl:when test="starts-with($normlang, 'ar-')">
      <xsl:choose>
        <xsl:when test="$number = 1">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:when test="$number = 2">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <xsl:when test="$number &gt;= 3 and $number &lt; 10">
          <xsl:text>2</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>3</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- == be bs cs ru sr uk == -->
    <xsl:when test="starts-with($normlang, 'be-') or starts-with($normlang, 'bs-') or
                    starts-with($normlang, 'cs-') or starts-with($normlang, 'ru-') or
                    starts-with($normlang, 'sr-') or starts-with($normlang, 'uk-') ">
      <xsl:choose>
        <xsl:when test="($number mod 10 = 1) and ($number mod 100 != 11)">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:when test="($number mod 10 &gt;= 2) and ($number mod 10 &lt;= 4) and
                        (($number mod 100 &lt; 10) or ($number mod 100 &gt;= 20))">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>2</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- == cy == -->
    <xsl:when test="starts-with($normlang, 'cy-')">
      <xsl:choose>
        <xsl:when test="$number != 2">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>1</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- == fa hu ja ko th tr vi zh == -->
    <xsl:when test="starts-with($normlang, 'ja-') or starts-with($normlang, 'ko-') or
                    starts-with($normlang, 'th-') or starts-with($normlang, 'tr-') or
                    starts-with($normlang, 'vi-') or starts-with($normlang, 'zh-') ">
      <xsl:text>0</xsl:text>
    </xsl:when>

    <!-- == fr nso wa == -->
    <xsl:when test="starts-with($normlang, 'fr-') or starts-with($normlang, 'nso-') or
                    starts-with($normlang, 'wa-') ">
      <xsl:choose>
        <xsl:when test="$number &gt; 1">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>0</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- == ga == -->
    <xsl:when test="starts-with($normlang, 'ga-')">
      <xsl:choose>
        <xsl:when test="$number = 1">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:when test="$number = 2">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>2</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- == sk == -->
    <xsl:when test="starts-with($normlang, 'sk-')">
      <xsl:choose>
        <xsl:when test="$number = 1">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:when test="($number &gt;= 2) and ($number &lt;= 4)">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>2</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- == sl == -->
    <xsl:when test="starts-with($normlang, 'sl-')">
      <xsl:choose>
        <xsl:when test="$number mod 100 = 1">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:when test="$number mod 100 = 2">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <xsl:when test="($number mod 100 = 3) or ($number mod 100 = 4)">
          <xsl:text>2</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>3</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- == C == -->
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$number = 1">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>1</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--**==========================================================================
l10n.direction
Determines the text direction for the language of the document
$lang: The locale to use to determine the text direction

REMARK: Lots of documentation is needed
-->
<xsl:template name="l10n.direction">
  <xsl:param name="lang" select="$l10n.locale"/>
  <xsl:variable name="direction">
    <xsl:for-each select="/*">
      <xsl:call-template name="l10n.gettext">
        <xsl:with-param name="msgid" select="'default:LTR'"/>
        <xsl:with-param name="lang" select="$lang"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="$direction = 'default:RTL'">
      <xsl:text>rtl</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>ltr</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--**==========================================================================
l10n.align.start
Determines the start alignment
$direction: The text direction

REMARK: Lots of documentation is needed
-->
<xsl:template name="l10n.align.start">
  <xsl:param name="direction">
    <xsl:call-template name="l10n.direction"/>
  </xsl:param>
  <xsl:choose>
    <xsl:when test="$direction = 'rtl'">
      <xsl:text>right</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>left</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--**==========================================================================
l10n.align.end
Determines the end alignment
$direction: The text direction

REMARK: Lots of documentation is needed
-->
<xsl:template name="l10n.align.end">
  <xsl:param name="direction">
    <xsl:call-template name="l10n.direction"/>
  </xsl:param>
  <xsl:choose>
    <xsl:when test="$direction = 'rtl'">
      <xsl:text>left</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>right</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--**==========================================================================
l10n.arrow.previous
FIXME
$direction: The text direction

REMARK: Lots of documentation is needed
-->
<xsl:template name="l10n.arrow.previous">
  <xsl:param name="direction">
    <xsl:call-template name="l10n.direction"/>
  </xsl:param>
  <xsl:choose>
    <xsl:when test="$direction = 'rlt'">
      <xsl:text>&#x25C0;&#x00A0;&#x00A0;</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>&#x00A0;&#x00A0;&#x25B6;</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--**==========================================================================
l10n.arrow.next
FIXME
$direction: The text direction

REMARK: Lots of documentation is needed
-->
<xsl:template name="l10n.arrow.next">
  <xsl:param name="direction">
    <xsl:call-template name="l10n.direction"/>
  </xsl:param>
  <xsl:choose>
    <xsl:when test="$direction = 'rlt'">
      <xsl:text>&#x00A0;&#x00A0;&#x25B6;</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>&#x25C0;&#x00A0;&#x00A0;</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--%%==========================================================================
l10n.format.mode
FIXME
$node: The node being processed in the original document
$string: String content to use for certain message format nodes

REMARK: Lots and lots of documentation is needed
-->
<xsl:template mode="l10n.format.mode" match="*">
  <xsl:param name="node"/>
  <xsl:apply-templates mode="l10n.format.mode">
    <xsl:with-param name="node" select="$node"/>
  </xsl:apply-templates>
</xsl:template>

<!-- = l10n.format.mode % msg:node = -->
<xsl:template mode="l10n.format.mode" match="msg:node">
  <xsl:param name="node"/>
  <xsl:apply-templates select="$node/node()"/>
</xsl:template>

<!-- = l10n.format.mode % msg:string = -->
<xsl:template mode="l10n.format.mode" match="msg:string">
  <xsl:param name="string"/>
  <xsl:value-of select="$string"/>
</xsl:template>

</xsl:stylesheet>
