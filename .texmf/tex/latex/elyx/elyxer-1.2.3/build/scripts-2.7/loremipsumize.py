#!/usr/bin/python
# -*- coding: utf-8 -*-

#   eLyXer -- convert LyX source files to HTML output.
#
#   Copyright (C) 2009 Alex Fernández
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

# --end--
# Alex 20091210
# Lorem-ipsumize a document: replace all alphanumeric texts longer than two words with "Lorem ipsum" and leave the symbols.

import sys



import sys
import codecs



import sys

class Trace(object):
  "A tracing class"

  debugmode = False
  quietmode = False
  showlinesmode = False

  prefix = None

  def debug(cls, message):
    "Show a debug message"
    if not Trace.debugmode or Trace.quietmode:
      return
    Trace.show(message, sys.stdout)

  def message(cls, message):
    "Show a trace message"
    if Trace.quietmode:
      return
    if Trace.prefix and Trace.showlinesmode:
      message = Trace.prefix + message
    Trace.show(message, sys.stdout)

  def error(cls, message):
    "Show an error message"
    message = '* ' + message
    if Trace.prefix and Trace.showlinesmode:
      message = Trace.prefix + message
    Trace.show(message, sys.stderr)

  def fatal(cls, message):
    "Show an error message and terminate"
    Trace.error('FATAL: ' + message)
    exit(-1)

  def show(cls, message, channel):
    "Show a message out of a channel"
    message = message.encode('utf-8')
    channel.write(message + '\n')

  debug = classmethod(debug)
  message = classmethod(message)
  error = classmethod(error)
  fatal = classmethod(fatal)
  show = classmethod(show)



class LineReader(object):
  "Reads a file line by line"

  def __init__(self, filename):
    if isinstance(filename, file):
      self.file = filename
    else:
      self.file = codecs.open(filename, 'rU', 'utf-8')
    self.linenumber = 1
    self.lastline = None
    self.current = None
    self.mustread = True
    self.depleted = False
    try:
      self.readline()
    except UnicodeDecodeError:
      # try compressed file
      import gzip
      self.file = gzip.open(filename, 'rb')
      self.readline()

  def setstart(self, firstline):
    "Set the first line to read."
    for i in range(firstline):
      self.file.readline()
    self.linenumber = firstline

  def setend(self, lastline):
    "Set the last line to read."
    self.lastline = lastline

  def currentline(self):
    "Get the current line"
    if self.mustread:
      self.readline()
    return self.current

  def nextline(self):
    "Go to next line"
    if self.depleted:
      Trace.fatal('Read beyond file end')
    self.mustread = True

  def readline(self):
    "Read a line from elyxer.file"
    self.current = self.file.readline()
    if not isinstance(self.file, codecs.StreamReaderWriter):
      self.current = self.current.decode('utf-8')
    if len(self.current) == 0:
      self.depleted = True
    self.current = self.current.rstrip('\n\r')
    self.linenumber += 1
    self.mustread = False
    Trace.prefix = 'Line ' + unicode(self.linenumber) + ': '
    if self.linenumber % 1000 == 0:
      Trace.message('Parsing')

  def finished(self):
    "Find out if the file is finished"
    if self.lastline and self.linenumber == self.lastline:
      return True
    if self.mustread:
      self.readline()
    return self.depleted

  def close(self):
    self.file.close()

class LineWriter(object):
  "Writes a file as a series of lists"

  file = False

  def __init__(self, filename):
    if isinstance(filename, file):
      self.file = filename
      self.filename = None
    else:
      self.filename = filename

  def write(self, strings):
    "Write a list of strings"
    for string in strings:
      if not isinstance(string, basestring):
        Trace.error('Not a string: ' + unicode(string) + ' in ' + unicode(strings))
        return
      self.writestring(string)

  def writestring(self, string):
    "Write a string"
    if not self.file:
      self.file = codecs.open(self.filename, 'w', "utf-8")
    if self.file == sys.stdout:
      string = string.encode('utf-8')
    self.file.write(string)

  def writeline(self, line):
    "Write a line to file"
    self.writestring(line + '\n')

  def close(self):
    self.file.close()






class BibStylesConfig(object):
  "Configuration class from elyxer.config file"

  abbrvnat = {
      
      u'@article':u'$authors. $title. <i>$journal</i>,{ {$volume:}$pages,} $month $year.{ doi: $doi.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'cite':u'$surname($year)', 
      u'default':u'$authors. <i>$title</i>. $publisher, $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      }

  alpha = {
      
      u'@article':u'$authors. $title.{ <i>$journal</i>{, {$volume}{($number)}}{: $pages}{, $year}.}{ <a href="$url">$url</a>.}{ <a href="$filename">$filename</a>.}{ $note.}', 
      u'cite':u'$Sur$YY', 
      u'default':u'$authors. $title.{ <i>$journal</i>,} $year.{ <a href="$url">$url</a>.}{ <a href="$filename">$filename</a>.}{ $note.}', 
      }

  authordate2 = {
      
      u'@article':u'$authors. $year. $title. <i>$journal</i>, <b>$volume</b>($number), $pages.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@book':u'$authors. $year. <i>$title</i>. $publisher.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'cite':u'$surname, $year', 
      u'default':u'$authors. $year. <i>$title</i>. $publisher.{ URL <a href="$url">$url</a>.}{ $note.}', 
      }

  default = {
      
      u'@article':u'$authors: “$title”, <i>$journal</i>,{ pp. $pages,} $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@book':u'{$authors: }<i>$title</i>{ ($editor, ed.)}.{{ $publisher,} $year.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@booklet':u'$authors: <i>$title</i>.{{ $publisher,} $year.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@conference':u'$authors: “$title”, <i>$journal</i>,{ pp. $pages,} $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@inbook':u'$authors: <i>$title</i>.{{ $publisher,} $year.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@incollection':u'$authors: <i>$title</i>{ in <i>$booktitle</i>{ ($editor, ed.)}}.{{ $publisher,} $year.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@inproceedings':u'$authors: “$title”, <i>$journal</i>,{ pp. $pages,} $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@manual':u'$authors: <i>$title</i>.{{ $publisher,} $year.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@mastersthesis':u'$authors: <i>$title</i>.{{ $publisher,} $year.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@misc':u'$authors: <i>$title</i>.{{ $publisher,}{ $howpublished,} $year.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@phdthesis':u'$authors: <i>$title</i>.{{ $publisher,} $year.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@proceedings':u'$authors: “$title”, <i>$journal</i>,{ pp. $pages,} $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@techreport':u'$authors: <i>$title</i>, $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@unpublished':u'$authors: “$title”, <i>$journal</i>, $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'cite':u'$index', 
      u'default':u'$authors: <i>$title</i>.{{ $publisher,} $year.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      }

  defaulttags = {
      u'YY':u'??', u'authors':u'', u'surname':u'', 
      }

  ieeetr = {
      
      u'@article':u'$authors, “$title”, <i>$journal</i>, vol. $volume, no. $number, pp. $pages, $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@book':u'$authors, <i>$title</i>. $publisher, $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'cite':u'$index', 
      u'default':u'$authors, “$title”. $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      }

  plain = {
      
      u'@article':u'$authors. $title.{ <i>$journal</i>{, {$volume}{($number)}}{:$pages}{, $year}.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@book':u'$authors. <i>$title</i>. $publisher,{ $month} $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@incollection':u'$authors. $title.{ In <i>$booktitle</i> {($editor, ed.)}.} $publisher,{ $month} $year.{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'@inproceedings':u'$authors. $title. { <i>$booktitle</i>{, {$volume}{($number)}}{:$pages}{, $year}.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      u'cite':u'$index', 
      u'default':u'{$authors. }$title.{{ $publisher,} $year.}{ URL <a href="$url">$url</a>.}{ $note.}', 
      }

  vancouver = {
      
      u'@article':u'$authors. $title. <i>$journal</i>, $year{;{<b>$volume</b>}{($number)}{:$pages}}.{ URL: <a href="$url">$url</a>.}{ $note.}', 
      u'@book':u'$authors. $title. {$publisher, }$year.{ URL: <a href="$url">$url</a>.}{ $note.}', 
      u'cite':u'$index', 
      u'default':u'$authors. $title; {$publisher, }$year.{ $howpublished.}{ URL: <a href="$url">$url</a>.}{ $note.}', 
      }

class BibTeXConfig(object):
  "Configuration class from elyxer.config file"

  replaced = {
      u'--':u'—', u'..':u'.', 
      }

class ContainerConfig(object):
  "Configuration class from elyxer.config file"

  endings = {
      u'Align':u'\\end_layout', u'BarredText':u'\\bar', 
      u'BoldText':u'\\series', u'Cell':u'</cell', 
      u'ChangeDeleted':u'\\change_unchanged', 
      u'ChangeInserted':u'\\change_unchanged', u'ColorText':u'\\color', 
      u'EmphaticText':u'\\emph', u'Hfill':u'\\hfill', u'Inset':u'\\end_inset', 
      u'Layout':u'\\end_layout', u'LyXFooter':u'\\end_document', 
      u'LyXHeader':u'\\end_header', u'Row':u'</row', u'ShapedText':u'\\shape', 
      u'SizeText':u'\\size', u'StrikeOut':u'\\strikeout', 
      u'TextFamily':u'\\family', u'VersalitasText':u'\\noun', 
      }

  extracttext = {
      u'allowed':[u'StringContainer',u'Constant',u'FormulaConstant',], 
      u'cloned':[u'',], 
      u'extracted':[u'PlainLayout',u'TaggedText',u'Align',u'Caption',u'TextFamily',u'EmphaticText',u'VersalitasText',u'BarredText',u'SizeText',u'ColorText',u'LangLine',u'Formula',u'Bracket',u'RawText',u'BibTag',u'FormulaNumber',u'AlphaCommand',u'EmptyCommand',u'OneParamFunction',u'SymbolFunction',u'TextFunction',u'FontFunction',u'CombiningFunction',u'DecoratingFunction',u'FormulaSymbol',u'BracketCommand',u'TeXCode',], 
      }

  startendings = {
      u'\\begin_deeper':u'\\end_deeper', u'\\begin_inset':u'\\end_inset', 
      u'\\begin_layout':u'\\end_layout', 
      }

  starts = {
      u'':u'StringContainer', u'#LyX':u'BlackBox', u'</lyxtabular':u'BlackBox', 
      u'<cell':u'Cell', u'<column':u'Column', u'<row':u'Row', 
      u'\\align':u'Align', u'\\bar':u'BarredText', 
      u'\\bar default':u'BlackBox', u'\\bar no':u'BlackBox', 
      u'\\begin_body':u'BlackBox', u'\\begin_deeper':u'DeeperList', 
      u'\\begin_document':u'BlackBox', u'\\begin_header':u'LyXHeader', 
      u'\\begin_inset Argument':u'ShortTitle', 
      u'\\begin_inset Box':u'BoxInset', u'\\begin_inset Branch':u'Branch', 
      u'\\begin_inset Caption':u'Caption', 
      u'\\begin_inset CommandInset bibitem':u'BiblioEntry', 
      u'\\begin_inset CommandInset bibtex':u'BibTeX', 
      u'\\begin_inset CommandInset citation':u'BiblioCitation', 
      u'\\begin_inset CommandInset href':u'URL', 
      u'\\begin_inset CommandInset include':u'IncludeInset', 
      u'\\begin_inset CommandInset index_print':u'PrintIndex', 
      u'\\begin_inset CommandInset label':u'Label', 
      u'\\begin_inset CommandInset line':u'LineInset', 
      u'\\begin_inset CommandInset nomencl_print':u'PrintNomenclature', 
      u'\\begin_inset CommandInset nomenclature':u'NomenclatureEntry', 
      u'\\begin_inset CommandInset ref':u'Reference', 
      u'\\begin_inset CommandInset toc':u'TableOfContents', 
      u'\\begin_inset ERT':u'ERT', u'\\begin_inset Flex':u'FlexInset', 
      u'\\begin_inset Flex Chunkref':u'NewfangledChunkRef', 
      u'\\begin_inset Flex Marginnote':u'SideNote', 
      u'\\begin_inset Flex Sidenote':u'SideNote', 
      u'\\begin_inset Flex URL':u'FlexURL', u'\\begin_inset Float':u'Float', 
      u'\\begin_inset FloatList':u'ListOf', u'\\begin_inset Foot':u'Footnote', 
      u'\\begin_inset Formula':u'Formula', 
      u'\\begin_inset FormulaMacro':u'FormulaMacro', 
      u'\\begin_inset Graphics':u'Image', 
      u'\\begin_inset Index':u'IndexReference', 
      u'\\begin_inset Info':u'InfoInset', 
      u'\\begin_inset LatexCommand bibitem':u'BiblioEntry', 
      u'\\begin_inset LatexCommand bibtex':u'BibTeX', 
      u'\\begin_inset LatexCommand cite':u'BiblioCitation', 
      u'\\begin_inset LatexCommand citealt':u'BiblioCitation', 
      u'\\begin_inset LatexCommand citep':u'BiblioCitation', 
      u'\\begin_inset LatexCommand citet':u'BiblioCitation', 
      u'\\begin_inset LatexCommand htmlurl':u'URL', 
      u'\\begin_inset LatexCommand index':u'IndexReference', 
      u'\\begin_inset LatexCommand label':u'Label', 
      u'\\begin_inset LatexCommand nomenclature':u'NomenclatureEntry', 
      u'\\begin_inset LatexCommand prettyref':u'Reference', 
      u'\\begin_inset LatexCommand printindex':u'PrintIndex', 
      u'\\begin_inset LatexCommand printnomenclature':u'PrintNomenclature', 
      u'\\begin_inset LatexCommand ref':u'Reference', 
      u'\\begin_inset LatexCommand tableofcontents':u'TableOfContents', 
      u'\\begin_inset LatexCommand url':u'URL', 
      u'\\begin_inset LatexCommand vref':u'Reference', 
      u'\\begin_inset Marginal':u'SideNote', 
      u'\\begin_inset Newline':u'NewlineInset', 
      u'\\begin_inset Newpage':u'NewPageInset', u'\\begin_inset Note':u'Note', 
      u'\\begin_inset OptArg':u'ShortTitle', 
      u'\\begin_inset Phantom':u'PhantomText', 
      u'\\begin_inset Quotes':u'QuoteContainer', 
      u'\\begin_inset Tabular':u'Table', u'\\begin_inset Text':u'InsetText', 
      u'\\begin_inset VSpace':u'VerticalSpace', u'\\begin_inset Wrap':u'Wrap', 
      u'\\begin_inset listings':u'Listing', 
      u'\\begin_inset script':u'ScriptInset', u'\\begin_inset space':u'Space', 
      u'\\begin_layout':u'Layout', u'\\begin_layout Abstract':u'Abstract', 
      u'\\begin_layout Author':u'Author', 
      u'\\begin_layout Bibliography':u'Bibliography', 
      u'\\begin_layout Chunk':u'NewfangledChunk', 
      u'\\begin_layout Description':u'Description', 
      u'\\begin_layout Enumerate':u'ListItem', 
      u'\\begin_layout Itemize':u'ListItem', u'\\begin_layout List':u'List', 
      u'\\begin_layout LyX-Code':u'LyXCode', 
      u'\\begin_layout Plain':u'PlainLayout', 
      u'\\begin_layout Standard':u'StandardLayout', 
      u'\\begin_layout Title':u'Title', u'\\begin_preamble':u'LyXPreamble', 
      u'\\change_deleted':u'ChangeDeleted', 
      u'\\change_inserted':u'ChangeInserted', 
      u'\\change_unchanged':u'BlackBox', u'\\color':u'ColorText', 
      u'\\color inherit':u'BlackBox', u'\\color none':u'BlackBox', 
      u'\\emph default':u'BlackBox', u'\\emph off':u'BlackBox', 
      u'\\emph on':u'EmphaticText', u'\\emph toggle':u'EmphaticText', 
      u'\\end_body':u'LyXFooter', u'\\family':u'TextFamily', 
      u'\\family default':u'BlackBox', u'\\family roman':u'BlackBox', 
      u'\\hfill':u'Hfill', u'\\labelwidthstring':u'BlackBox', 
      u'\\lang':u'LangLine', u'\\length':u'InsetLength', 
      u'\\lyxformat':u'LyXFormat', u'\\lyxline':u'LyXLine', 
      u'\\newline':u'Newline', u'\\newpage':u'NewPage', 
      u'\\noindent':u'BlackBox', u'\\noun default':u'BlackBox', 
      u'\\noun off':u'BlackBox', u'\\noun on':u'VersalitasText', 
      u'\\paragraph_spacing':u'BlackBox', u'\\series bold':u'BoldText', 
      u'\\series default':u'BlackBox', u'\\series medium':u'BlackBox', 
      u'\\shape':u'ShapedText', u'\\shape default':u'BlackBox', 
      u'\\shape up':u'BlackBox', u'\\size':u'SizeText', 
      u'\\size normal':u'BlackBox', u'\\start_of_appendix':u'StartAppendix', 
      u'\\strikeout default':u'BlackBox', u'\\strikeout on':u'StrikeOut', 
      }

  string = {
      u'startcommand':u'\\', 
      }

  table = {
      u'headers':[u'<lyxtabular',u'<features',], 
      }

class EscapeConfig(object):
  "Configuration class from elyxer.config file"

  chars = {
      u'\n':u'', u' -- ':u' — ', u'\'':u'’', u'---':u'—', u'`':u'‘', 
      }

  commands = {
      u'\\InsetSpace \\space{}':u' ', u'\\InsetSpace \\thinspace{}':u' ', 
      u'\\InsetSpace ~':u' ', u'\\SpecialChar \\-':u'', 
      u'\\SpecialChar \\@.':u'.', u'\\SpecialChar \\ldots{}':u'…', 
      u'\\SpecialChar \\menuseparator':u' ▷ ', 
      u'\\SpecialChar \\nobreakdash-':u'-', u'\\SpecialChar \\slash{}':u'/', 
      u'\\SpecialChar \\textcompwordmark{}':u'', u'\\backslash':u'\\', 
      }

  entities = {
      u'&':u'&amp;', u'<':u'&lt;', u'>':u'&gt;', 
      }

  html = {
      u'/>':u'>', 
      }

  iso885915 = {
      u' ':u'&nbsp;', u' ':u'&emsp;', u' ':u'&#8197;', 
      }

  nonunicode = {
      u' ':u' ', 
      }

class FormulaConfig(object):
  "Configuration class from elyxer.config file"

  alphacommands = {
      u'\\AA':u'Å', u'\\AE':u'Æ', 
      u'\\AmS':u'<span class="versalitas">AmS</span>', u'\\Angstroem':u'Å', 
      u'\\DH':u'Ð', u'\\Koppa':u'Ϟ', u'\\L':u'Ł', u'\\Micro':u'µ', u'\\O':u'Ø', 
      u'\\OE':u'Œ', u'\\Sampi':u'Ϡ', u'\\Stigma':u'Ϛ', u'\\TH':u'Þ', 
      u'\\aa':u'å', u'\\ae':u'æ', u'\\alpha':u'α', u'\\beta':u'β', 
      u'\\delta':u'δ', u'\\dh':u'ð', u'\\digamma':u'ϝ', u'\\epsilon':u'ϵ', 
      u'\\eta':u'η', u'\\eth':u'ð', u'\\gamma':u'γ', u'\\i':u'ı', 
      u'\\imath':u'ı', u'\\iota':u'ι', u'\\j':u'ȷ', u'\\jmath':u'ȷ', 
      u'\\kappa':u'κ', u'\\koppa':u'ϟ', u'\\l':u'ł', u'\\lambda':u'λ', 
      u'\\mu':u'μ', u'\\nu':u'ν', u'\\o':u'ø', u'\\oe':u'œ', u'\\omega':u'ω', 
      u'\\phi':u'φ', u'\\pi':u'π', u'\\psi':u'ψ', u'\\rho':u'ρ', 
      u'\\sampi':u'ϡ', u'\\sigma':u'σ', u'\\ss':u'ß', u'\\stigma':u'ϛ', 
      u'\\tau':u'τ', u'\\tcohm':u'Ω', u'\\textcrh':u'ħ', u'\\th':u'þ', 
      u'\\theta':u'θ', u'\\upsilon':u'υ', u'\\varDelta':u'∆', 
      u'\\varGamma':u'Γ', u'\\varLambda':u'Λ', u'\\varOmega':u'Ω', 
      u'\\varPhi':u'Φ', u'\\varPi':u'Π', u'\\varPsi':u'Ψ', u'\\varSigma':u'Σ', 
      u'\\varTheta':u'Θ', u'\\varUpsilon':u'Υ', u'\\varXi':u'Ξ', 
      u'\\varbeta':u'ϐ', u'\\varepsilon':u'ε', u'\\varkappa':u'ϰ', 
      u'\\varphi':u'φ', u'\\varpi':u'ϖ', u'\\varrho':u'ϱ', u'\\varsigma':u'ς', 
      u'\\vartheta':u'ϑ', u'\\xi':u'ξ', u'\\zeta':u'ζ', 
      }

  array = {
      u'begin':u'\\begin', u'cellseparator':u'&', u'end':u'\\end', 
      u'rowseparator':u'\\\\', 
      }

  bigbrackets = {
      u'(':[u'⎛',u'⎜',u'⎝',], u')':[u'⎞',u'⎟',u'⎠',], u'[':[u'⎡',u'⎢',u'⎣',], 
      u']':[u'⎤',u'⎥',u'⎦',], u'{':[u'⎧',u'⎪',u'⎨',u'⎩',], u'|':[u'|',], 
      u'}':[u'⎫',u'⎪',u'⎬',u'⎭',], u'∥':[u'∥',], 
      }

  bigsymbols = {
      u'∑':[u'⎲',u'⎳',], u'∫':[u'⌠',u'⌡',], 
      }

  bracketcommands = {
      u'\\left':u'span class="symbol"', 
      u'\\left.':u'<span class="leftdot"></span>', 
      u'\\middle':u'span class="symbol"', u'\\right':u'span class="symbol"', 
      u'\\right.':u'<span class="rightdot"></span>', 
      }

  combiningfunctions = {
      u'\\"':u'̈', u'\\\'':u'́', u'\\^':u'̂', u'\\`':u'̀', u'\\acute':u'́', 
      u'\\bar':u'̄', u'\\breve':u'̆', u'\\c':u'̧', u'\\check':u'̌', 
      u'\\dddot':u'⃛', u'\\ddot':u'̈', u'\\dot':u'̇', u'\\grave':u'̀', 
      u'\\hat':u'̂', u'\\mathring':u'̊', u'\\overleftarrow':u'⃖', 
      u'\\overrightarrow':u'⃗', u'\\r':u'̊', u'\\s':u'̩', 
      u'\\textcircled':u'⃝', u'\\textsubring':u'̥', u'\\tilde':u'̃', 
      u'\\v':u'̌', u'\\vec':u'⃗', u'\\~':u'̃', 
      }

  commands = {
      u'\\ ':u' ', u'\\!':u'', u'\\#':u'#', u'\\$':u'$', u'\\%':u'%', 
      u'\\&':u'&', u'\\,':u' ', u'\\:':u' ', u'\\;':u' ', u'\\AC':u'∿', 
      u'\\APLcomment':u'⍝', u'\\APLdownarrowbox':u'⍗', u'\\APLinput':u'⍞', 
      u'\\APLinv':u'⌹', u'\\APLleftarrowbox':u'⍇', u'\\APLlog':u'⍟', 
      u'\\APLrightarrowbox':u'⍈', u'\\APLuparrowbox':u'⍐', u'\\Box':u'□', 
      u'\\Bumpeq':u'≎', u'\\CIRCLE':u'●', u'\\Cap':u'⋒', 
      u'\\CapitalDifferentialD':u'ⅅ', u'\\CheckedBox':u'☑', u'\\Circle':u'○', 
      u'\\Coloneqq':u'⩴', u'\\ComplexI':u'ⅈ', u'\\ComplexJ':u'ⅉ', 
      u'\\Corresponds':u'≙', u'\\Cup':u'⋓', u'\\Delta':u'Δ', u'\\Diamond':u'◇', 
      u'\\Diamondblack':u'◆', u'\\Diamonddot':u'⟐', u'\\DifferentialD':u'ⅆ', 
      u'\\Downarrow':u'⇓', u'\\EUR':u'€', u'\\Euler':u'ℇ', 
      u'\\ExponetialE':u'ⅇ', u'\\Finv':u'Ⅎ', u'\\Game':u'⅁', u'\\Gamma':u'Γ', 
      u'\\Im':u'ℑ', u'\\Join':u'⨝', u'\\LEFTCIRCLE':u'◖', u'\\LEFTcircle':u'◐', 
      u'\\LHD':u'◀', u'\\Lambda':u'Λ', u'\\Lbag':u'⟅', u'\\Leftarrow':u'⇐', 
      u'\\Lleftarrow':u'⇚', u'\\Longleftarrow':u'⟸', 
      u'\\Longleftrightarrow':u'⟺', u'\\Longrightarrow':u'⟹', u'\\Lparen':u'⦅', 
      u'\\Lsh':u'↰', u'\\Mapsfrom':u'⇐|', u'\\Mapsto':u'|⇒', u'\\Omega':u'Ω', 
      u'\\P':u'¶', u'\\Phi':u'Φ', u'\\Pi':u'Π', u'\\Pr':u'Pr', u'\\Psi':u'Ψ', 
      u'\\Qoppa':u'Ϙ', u'\\RHD':u'▶', u'\\RIGHTCIRCLE':u'◗', 
      u'\\RIGHTcircle':u'◑', u'\\Rbag':u'⟆', u'\\Re':u'ℜ', u'\\Rparen':u'⦆', 
      u'\\Rrightarrow':u'⇛', u'\\Rsh':u'↱', u'\\S':u'§', u'\\Sigma':u'Σ', 
      u'\\Square':u'☐', u'\\Subset':u'⋐', u'\\Sun':u'☉', u'\\Supset':u'⋑', 
      u'\\Theta':u'Θ', u'\\Uparrow':u'⇑', u'\\Updownarrow':u'⇕', 
      u'\\Upsilon':u'Υ', u'\\Vdash':u'⊩', u'\\Vert':u'∥', u'\\Vvdash':u'⊪', 
      u'\\XBox':u'☒', u'\\Xi':u'Ξ', u'\\Yup':u'⅄', u'\\\\':u'<br/>', 
      u'\\_':u'_', u'\\aleph':u'ℵ', u'\\amalg':u'∐', u'\\anchor':u'⚓', 
      u'\\angle':u'∠', u'\\aquarius':u'♒', u'\\arccos':u'arccos', 
      u'\\arcsin':u'arcsin', u'\\arctan':u'arctan', u'\\arg':u'arg', 
      u'\\aries':u'♈', u'\\arrowbullet':u'➢', u'\\ast':u'∗', u'\\asymp':u'≍', 
      u'\\backepsilon':u'∍', u'\\backprime':u'‵', u'\\backsimeq':u'⋍', 
      u'\\backslash':u'\\', u'\\ballotx':u'✗', u'\\barwedge':u'⊼', 
      u'\\because':u'∵', u'\\beth':u'ℶ', u'\\between':u'≬', u'\\bigcap':u'∩', 
      u'\\bigcirc':u'○', u'\\bigcup':u'∪', u'\\bigodot':u'⊙', 
      u'\\bigoplus':u'⊕', u'\\bigotimes':u'⊗', u'\\bigsqcup':u'⊔', 
      u'\\bigstar':u'★', u'\\bigtriangledown':u'▽', u'\\bigtriangleup':u'△', 
      u'\\biguplus':u'⊎', u'\\bigvee':u'∨', u'\\bigwedge':u'∧', 
      u'\\biohazard':u'☣', u'\\blacklozenge':u'⧫', u'\\blacksmiley':u'☻', 
      u'\\blacksquare':u'■', u'\\blacktriangle':u'▲', 
      u'\\blacktriangledown':u'▼', u'\\blacktriangleleft':u'◂', 
      u'\\blacktriangleright':u'▶', u'\\blacktriangleup':u'▴', u'\\bot':u'⊥', 
      u'\\bowtie':u'⋈', u'\\box':u'▫', u'\\boxast':u'⧆', u'\\boxbar':u'◫', 
      u'\\boxbox':u'⧈', u'\\boxbslash':u'⧅', u'\\boxcircle':u'⧇', 
      u'\\boxdot':u'⊡', u'\\boxminus':u'⊟', u'\\boxplus':u'⊞', 
      u'\\boxslash':u'⧄', u'\\boxtimes':u'⊠', u'\\bullet':u'•', 
      u'\\bumpeq':u'≏', u'\\cancer':u'♋', u'\\cap':u'∩', u'\\capricornus':u'♑', 
      u'\\cat':u'⁀', u'\\cdot':u'⋅', u'\\cdots':u'⋯', u'\\cent':u'¢', 
      u'\\centerdot':u'∙', u'\\checkmark':u'✓', u'\\chi':u'χ', u'\\circ':u'○', 
      u'\\circeq':u'≗', u'\\circlearrowleft':u'↺', u'\\circlearrowright':u'↻', 
      u'\\circledR':u'®', u'\\circledast':u'⊛', u'\\circledbslash':u'⦸', 
      u'\\circledcirc':u'⊚', u'\\circleddash':u'⊝', u'\\circledgtr':u'⧁', 
      u'\\circledless':u'⧀', u'\\clubsuit':u'♣', u'\\coloneqq':u'≔', 
      u'\\complement':u'∁', u'\\cong':u'≅', u'\\coprod':u'∐', 
      u'\\copyright':u'©', u'\\cos':u'cos', u'\\cosh':u'cosh', u'\\cot':u'cot', 
      u'\\coth':u'coth', u'\\csc':u'csc', u'\\cup':u'∪', u'\\curlyvee':u'⋎', 
      u'\\curlywedge':u'⋏', u'\\curvearrowleft':u'↶', 
      u'\\curvearrowright':u'↷', u'\\dag':u'†', u'\\dagger':u'†', 
      u'\\daleth':u'ℸ', u'\\dashleftarrow':u'⇠', u'\\dashv':u'⊣', 
      u'\\ddag':u'‡', u'\\ddagger':u'‡', u'\\ddots':u'⋱', u'\\deg':u'deg', 
      u'\\det':u'det', u'\\diagdown':u'╲', u'\\diagup':u'╱', 
      u'\\diameter':u'⌀', u'\\diamond':u'◇', u'\\diamondsuit':u'♦', 
      u'\\dim':u'dim', u'\\div':u'÷', u'\\divideontimes':u'⋇', 
      u'\\dotdiv':u'∸', u'\\doteq':u'≐', u'\\doteqdot':u'≑', u'\\dotplus':u'∔', 
      u'\\dots':u'…', u'\\doublebarwedge':u'⌆', u'\\downarrow':u'↓', 
      u'\\downdownarrows':u'⇊', u'\\downharpoonleft':u'⇃', 
      u'\\downharpoonright':u'⇂', u'\\dsub':u'⩤', u'\\earth':u'♁', 
      u'\\eighthnote':u'♪', u'\\ell':u'ℓ', u'\\emptyset':u'∅', 
      u'\\eqcirc':u'≖', u'\\eqcolon':u'≕', u'\\eqsim':u'≂', u'\\euro':u'€', 
      u'\\exists':u'∃', u'\\exp':u'exp', u'\\fallingdotseq':u'≒', 
      u'\\fcmp':u'⨾', u'\\female':u'♀', u'\\flat':u'♭', u'\\forall':u'∀', 
      u'\\fourth':u'⁗', u'\\frown':u'⌢', u'\\frownie':u'☹', u'\\gcd':u'gcd', 
      u'\\gemini':u'♊', u'\\geq)':u'≥', u'\\geqq':u'≧', u'\\geqslant':u'≥', 
      u'\\gets':u'←', u'\\gg':u'≫', u'\\ggg':u'⋙', u'\\gimel':u'ℷ', 
      u'\\gneqq':u'≩', u'\\gnsim':u'⋧', u'\\gtrdot':u'⋗', u'\\gtreqless':u'⋚', 
      u'\\gtreqqless':u'⪌', u'\\gtrless':u'≷', u'\\gtrsim':u'≳', 
      u'\\guillemotleft':u'«', u'\\guillemotright':u'»', u'\\hbar':u'ℏ', 
      u'\\heartsuit':u'♥', u'\\hfill':u'<span class="hfill"> </span>', 
      u'\\hom':u'hom', u'\\hookleftarrow':u'↩', u'\\hookrightarrow':u'↪', 
      u'\\hslash':u'ℏ', u'\\idotsint':u'<span class="bigsymbol">∫⋯∫</span>', 
      u'\\iiint':u'<span class="bigsymbol">∭</span>', 
      u'\\iint':u'<span class="bigsymbol">∬</span>', u'\\imath':u'ı', 
      u'\\inf':u'inf', u'\\infty':u'∞', u'\\intercal':u'⊺', 
      u'\\interleave':u'⫴', u'\\invamp':u'⅋', u'\\invneg':u'⌐', 
      u'\\jmath':u'ȷ', u'\\jupiter':u'♃', u'\\ker':u'ker', u'\\land':u'∧', 
      u'\\landupint':u'<span class="bigsymbol">∱</span>', u'\\lang':u'⟪', 
      u'\\langle':u'⟨', u'\\lblot':u'⦉', u'\\lbrace':u'{', u'\\lbrace)':u'{', 
      u'\\lbrack':u'[', u'\\lceil':u'⌈', u'\\ldots':u'…', u'\\leadsto':u'⇝', 
      u'\\leftarrow)':u'←', u'\\leftarrowtail':u'↢', u'\\leftarrowtobar':u'⇤', 
      u'\\leftharpoondown':u'↽', u'\\leftharpoonup':u'↼', 
      u'\\leftleftarrows':u'⇇', u'\\leftleftharpoons':u'⥢', u'\\leftmoon':u'☾', 
      u'\\leftrightarrow':u'↔', u'\\leftrightarrows':u'⇆', 
      u'\\leftrightharpoons':u'⇋', u'\\leftthreetimes':u'⋋', u'\\leo':u'♌', 
      u'\\leq)':u'≤', u'\\leqq':u'≦', u'\\leqslant':u'≤', u'\\lessdot':u'⋖', 
      u'\\lesseqgtr':u'⋛', u'\\lesseqqgtr':u'⪋', u'\\lessgtr':u'≶', 
      u'\\lesssim':u'≲', u'\\lfloor':u'⌊', u'\\lg':u'lg', u'\\lgroup':u'⟮', 
      u'\\lhd':u'⊲', u'\\libra':u'♎', u'\\lightning':u'↯', u'\\limg':u'⦇', 
      u'\\liminf':u'liminf', u'\\limsup':u'limsup', u'\\ll':u'≪', 
      u'\\llbracket':u'⟦', u'\\llcorner':u'⌞', u'\\lll':u'⋘', u'\\ln':u'ln', 
      u'\\lneqq':u'≨', u'\\lnot':u'¬', u'\\lnsim':u'⋦', u'\\log':u'log', 
      u'\\longleftarrow':u'⟵', u'\\longleftrightarrow':u'⟷', 
      u'\\longmapsto':u'⟼', u'\\longrightarrow':u'⟶', u'\\looparrowleft':u'↫', 
      u'\\looparrowright':u'↬', u'\\lor':u'∨', u'\\lozenge':u'◊', 
      u'\\lrcorner':u'⌟', u'\\ltimes':u'⋉', u'\\lyxlock':u'', u'\\male':u'♂', 
      u'\\maltese':u'✠', u'\\mapsfrom':u'↤', u'\\mapsto':u'↦', 
      u'\\mathcircumflex':u'^', u'\\max':u'max', u'\\measuredangle':u'∡', 
      u'\\medbullet':u'⚫', u'\\medcirc':u'⚪', u'\\mercury':u'☿', u'\\mho':u'℧', 
      u'\\mid':u'∣', u'\\min':u'min', u'\\models':u'⊨', u'\\mp':u'∓', 
      u'\\multimap':u'⊸', u'\\nLeftarrow':u'⇍', u'\\nLeftrightarrow':u'⇎', 
      u'\\nRightarrow':u'⇏', u'\\nVDash':u'⊯', u'\\nabla':u'∇', 
      u'\\napprox':u'≉', u'\\natural':u'♮', u'\\ncong':u'≇', u'\\nearrow':u'↗', 
      u'\\neg':u'¬', u'\\neg)':u'¬', u'\\neptune':u'♆', u'\\nequiv':u'≢', 
      u'\\newline':u'<br/>', u'\\nexists':u'∄', u'\\ngeqslant':u'≱', 
      u'\\ngtr':u'≯', u'\\ngtrless':u'≹', u'\\ni':u'∋', u'\\ni)':u'∋', 
      u'\\nleftarrow':u'↚', u'\\nleftrightarrow':u'↮', u'\\nleqslant':u'≰', 
      u'\\nless':u'≮', u'\\nlessgtr':u'≸', u'\\nmid':u'∤', u'\\nolimits':u'', 
      u'\\nonumber':u'', u'\\not':u'¬', u'\\not<':u'≮', u'\\not=':u'≠', 
      u'\\not>':u'≯', u'\\notbackslash':u'⍀', u'\\notin':u'∉', u'\\notni':u'∌', 
      u'\\notslash':u'⌿', u'\\nparallel':u'∦', u'\\nprec':u'⊀', 
      u'\\nrightarrow':u'↛', u'\\nsim':u'≁', u'\\nsimeq':u'≄', 
      u'\\nsqsubset':u'⊏̸', u'\\nsubseteq':u'⊈', u'\\nsucc':u'⊁', 
      u'\\nsucccurlyeq':u'⋡', u'\\nsupset':u'⊅', u'\\nsupseteq':u'⊉', 
      u'\\ntriangleleft':u'⋪', u'\\ntrianglelefteq':u'⋬', 
      u'\\ntriangleright':u'⋫', u'\\ntrianglerighteq':u'⋭', u'\\nvDash':u'⊭', 
      u'\\nvdash':u'⊬', u'\\nwarrow':u'↖', u'\\odot':u'⊙', 
      u'\\officialeuro':u'€', u'\\oiiint':u'<span class="bigsymbol">∰</span>', 
      u'\\oiint':u'<span class="bigsymbol">∯</span>', 
      u'\\oint':u'<span class="bigsymbol">∮</span>', 
      u'\\ointclockwise':u'<span class="bigsymbol">∲</span>', 
      u'\\ointctrclockwise':u'<span class="bigsymbol">∳</span>', 
      u'\\ominus':u'⊖', u'\\oplus':u'⊕', u'\\oslash':u'⊘', u'\\otimes':u'⊗', 
      u'\\owns':u'∋', u'\\parallel':u'∥', u'\\partial':u'∂', u'\\pencil':u'✎', 
      u'\\perp':u'⊥', u'\\pisces':u'♓', u'\\pitchfork':u'⋔', u'\\pluto':u'♇', 
      u'\\pm':u'±', u'\\pointer':u'➪', u'\\pointright':u'☞', u'\\pounds':u'£', 
      u'\\prec':u'≺', u'\\preccurlyeq':u'≼', u'\\preceq':u'≼', 
      u'\\precsim':u'≾', u'\\prime':u'′', u'\\prompto':u'∝', u'\\qoppa':u'ϙ', 
      u'\\qquad':u'  ', u'\\quad':u' ', u'\\quarternote':u'♩', 
      u'\\radiation':u'☢', u'\\rang':u'⟫', u'\\rangle':u'⟩', u'\\rblot':u'⦊', 
      u'\\rbrace':u'}', u'\\rbrace)':u'}', u'\\rbrack':u']', u'\\rceil':u'⌉', 
      u'\\recycle':u'♻', u'\\rfloor':u'⌋', u'\\rgroup':u'⟯', u'\\rhd':u'⊳', 
      u'\\rightangle':u'∟', u'\\rightarrow)':u'→', u'\\rightarrowtail':u'↣', 
      u'\\rightarrowtobar':u'⇥', u'\\rightharpoondown':u'⇁', 
      u'\\rightharpoonup':u'⇀', u'\\rightharpooondown':u'⇁', 
      u'\\rightharpooonup':u'⇀', u'\\rightleftarrows':u'⇄', 
      u'\\rightleftharpoons':u'⇌', u'\\rightmoon':u'☽', 
      u'\\rightrightarrows':u'⇉', u'\\rightrightharpoons':u'⥤', 
      u'\\rightthreetimes':u'⋌', u'\\rimg':u'⦈', u'\\risingdotseq':u'≓', 
      u'\\rrbracket':u'⟧', u'\\rsub':u'⩥', u'\\rtimes':u'⋊', 
      u'\\sagittarius':u'♐', u'\\saturn':u'♄', u'\\scorpio':u'♏', 
      u'\\searrow':u'↘', u'\\sec':u'sec', u'\\second':u'″', u'\\setminus':u'∖', 
      u'\\sharp':u'♯', u'\\simeq':u'≃', u'\\sin':u'sin', u'\\sinh':u'sinh', 
      u'\\sixteenthnote':u'♬', u'\\skull':u'☠', u'\\slash':u'∕', 
      u'\\smallsetminus':u'∖', u'\\smalltriangledown':u'▿', 
      u'\\smalltriangleleft':u'◃', u'\\smalltriangleright':u'▹', 
      u'\\smalltriangleup':u'▵', u'\\smile':u'⌣', u'\\smiley':u'☺', 
      u'\\spadesuit':u'♠', u'\\spddot':u'¨', u'\\sphat':u'', 
      u'\\sphericalangle':u'∢', u'\\spot':u'⦁', u'\\sptilde':u'~', 
      u'\\sqcap':u'⊓', u'\\sqcup':u'⊔', u'\\sqsubset':u'⊏', 
      u'\\sqsubseteq':u'⊑', u'\\sqsupset':u'⊐', u'\\sqsupseteq':u'⊒', 
      u'\\square':u'□', u'\\sslash':u'⫽', u'\\star':u'⋆', u'\\steaming':u'☕', 
      u'\\subseteqq':u'⫅', u'\\subsetneqq':u'⫋', u'\\succ':u'≻', 
      u'\\succcurlyeq':u'≽', u'\\succeq':u'≽', u'\\succnsim':u'⋩', 
      u'\\succsim':u'≿', u'\\sun':u'☼', u'\\sup':u'sup', u'\\supseteqq':u'⫆', 
      u'\\supsetneqq':u'⫌', u'\\surd':u'√', u'\\swarrow':u'↙', 
      u'\\swords':u'⚔', u'\\talloblong':u'⫾', u'\\tan':u'tan', 
      u'\\tanh':u'tanh', u'\\taurus':u'♉', u'\\textasciicircum':u'^', 
      u'\\textasciitilde':u'~', u'\\textbackslash':u'\\', 
      u'\\textcopyright':u'©\'', u'\\textdegree':u'°', u'\\textellipsis':u'…', 
      u'\\textemdash':u'—', u'\\textendash':u'—', u'\\texteuro':u'€', 
      u'\\textgreater':u'>', u'\\textless':u'<', u'\\textordfeminine':u'ª', 
      u'\\textordmasculine':u'º', u'\\textquotedblleft':u'“', 
      u'\\textquotedblright':u'”', u'\\textquoteright':u'’', 
      u'\\textregistered':u'®', u'\\textrightarrow':u'→', 
      u'\\textsection':u'§', u'\\texttrademark':u'™', 
      u'\\texttwosuperior':u'²', u'\\textvisiblespace':u' ', 
      u'\\therefore':u'∴', u'\\third':u'‴', u'\\top':u'⊤', u'\\triangle':u'△', 
      u'\\triangleleft':u'⊲', u'\\trianglelefteq':u'⊴', u'\\triangleq':u'≜', 
      u'\\triangleright':u'▷', u'\\trianglerighteq':u'⊵', 
      u'\\twoheadleftarrow':u'↞', u'\\twoheadrightarrow':u'↠', 
      u'\\twonotes':u'♫', u'\\udot':u'⊍', u'\\ulcorner':u'⌜', u'\\unlhd':u'⊴', 
      u'\\unrhd':u'⊵', u'\\unrhl':u'⊵', u'\\uparrow':u'↑', 
      u'\\updownarrow':u'↕', u'\\upharpoonleft':u'↿', u'\\upharpoonright':u'↾', 
      u'\\uplus':u'⊎', u'\\upuparrows':u'⇈', u'\\uranus':u'♅', 
      u'\\urcorner':u'⌝', u'\\vDash':u'⊨', u'\\varclubsuit':u'♧', 
      u'\\vardiamondsuit':u'♦', u'\\varheartsuit':u'♥', u'\\varnothing':u'∅', 
      u'\\varspadesuit':u'♤', u'\\vdash':u'⊢', u'\\vdots':u'⋮', u'\\vee':u'∨', 
      u'\\vee)':u'∨', u'\\veebar':u'⊻', u'\\vert':u'∣', u'\\virgo':u'♍', 
      u'\\warning':u'⚠', u'\\wasylozenge':u'⌑', u'\\wedge':u'∧', 
      u'\\wedge)':u'∧', u'\\wp':u'℘', u'\\wr':u'≀', u'\\yen':u'¥', 
      u'\\yinyang':u'☯', u'\\{':u'{', u'\\|':u'∥', u'\\}':u'}', 
      }

  decoratedcommand = {
      
      }

  decoratingfunctions = {
      u'\\overleftarrow':u'⟵', u'\\overrightarrow':u'⟶', u'\\widehat':u'^', 
      }

  endings = {
      u'bracket':u'}', u'complex':u'\\]', u'endafter':u'}', 
      u'endbefore':u'\\end{', u'squarebracket':u']', 
      }

  environments = {
      u'align':[u'r',u'l',], u'eqnarray':[u'r',u'c',u'l',], 
      u'gathered':[u'l',u'l',], 
      }

  fontfunctions = {
      u'\\boldsymbol':u'b', u'\\mathbb':u'span class="blackboard"', 
      u'\\mathbb{A}':u'𝔸', u'\\mathbb{B}':u'𝔹', u'\\mathbb{C}':u'ℂ', 
      u'\\mathbb{D}':u'𝔻', u'\\mathbb{E}':u'𝔼', u'\\mathbb{F}':u'𝔽', 
      u'\\mathbb{G}':u'𝔾', u'\\mathbb{H}':u'ℍ', u'\\mathbb{J}':u'𝕁', 
      u'\\mathbb{K}':u'𝕂', u'\\mathbb{L}':u'𝕃', u'\\mathbb{N}':u'ℕ', 
      u'\\mathbb{O}':u'𝕆', u'\\mathbb{P}':u'ℙ', u'\\mathbb{Q}':u'ℚ', 
      u'\\mathbb{R}':u'ℝ', u'\\mathbb{S}':u'𝕊', u'\\mathbb{T}':u'𝕋', 
      u'\\mathbb{W}':u'𝕎', u'\\mathbb{Z}':u'ℤ', u'\\mathbf':u'b', 
      u'\\mathcal':u'span class="scriptfont"', u'\\mathcal{B}':u'ℬ', 
      u'\\mathcal{E}':u'ℰ', u'\\mathcal{F}':u'ℱ', u'\\mathcal{H}':u'ℋ', 
      u'\\mathcal{I}':u'ℐ', u'\\mathcal{L}':u'ℒ', u'\\mathcal{M}':u'ℳ', 
      u'\\mathcal{R}':u'ℛ', u'\\mathfrak':u'span class="fraktur"', 
      u'\\mathfrak{C}':u'ℭ', u'\\mathfrak{F}':u'𝔉', u'\\mathfrak{H}':u'ℌ', 
      u'\\mathfrak{I}':u'ℑ', u'\\mathfrak{R}':u'ℜ', u'\\mathfrak{Z}':u'ℨ', 
      u'\\mathit':u'i', u'\\mathring{A}':u'Å', u'\\mathring{U}':u'Ů', 
      u'\\mathring{a}':u'å', u'\\mathring{u}':u'ů', u'\\mathring{w}':u'ẘ', 
      u'\\mathring{y}':u'ẙ', u'\\mathrm':u'span class="mathrm"', 
      u'\\mathscr':u'span class="scriptfont"', u'\\mathscr{B}':u'ℬ', 
      u'\\mathscr{E}':u'ℰ', u'\\mathscr{F}':u'ℱ', u'\\mathscr{H}':u'ℋ', 
      u'\\mathscr{I}':u'ℐ', u'\\mathscr{L}':u'ℒ', u'\\mathscr{M}':u'ℳ', 
      u'\\mathscr{R}':u'ℛ', u'\\mathsf':u'span class="mathsf"', 
      u'\\mathtt':u'tt', 
      }

  hybridfunctions = {
      
      u'\\binom':[u'{$1}{$2}',u'f2{(}f0{f1{$1}f1{$2}}f2{)}',u'span class="binom"',u'span class="binomstack"',u'span class="bigsymbol"',], 
      u'\\boxed':[u'{$1}',u'f0{$1}',u'span class="boxed"',], 
      u'\\cfrac':[u'[$p!]{$1}{$2}',u'f0{f3{(}f1{$1}f3{)/(}f2{$2}f3{)}}',u'span class="fullfraction"',u'span class="numerator align-$p"',u'span class="denominator"',u'span class="ignored"',], 
      u'\\color':[u'{$p!}{$1}',u'f0{$1}',u'span style="color: $p;"',], 
      u'\\colorbox':[u'{$p!}{$1}',u'f0{$1}',u'span class="colorbox" style="background: $p;"',], 
      u'\\dbinom':[u'{$1}{$2}',u'(f0{f1{f2{$1}}f1{f2{ }}f1{f2{$2}}})',u'span class="binomial"',u'span class="binomrow"',u'span class="binomcell"',], 
      u'\\dfrac':[u'{$1}{$2}',u'f0{f3{(}f1{$1}f3{)/(}f2{$2}f3{)}}',u'span class="fullfraction"',u'span class="numerator"',u'span class="denominator"',u'span class="ignored"',], 
      u'\\displaystyle':[u'{$1}',u'f0{$1}',u'span class="displaystyle"',], 
      u'\\fbox':[u'{$1}',u'f0{$1}',u'span class="fbox"',], 
      u'\\fboxrule':[u'{$p!}',u'f0{}',u'ignored',], 
      u'\\fboxsep':[u'{$p!}',u'f0{}',u'ignored',], 
      u'\\fcolorbox':[u'{$p!}{$q!}{$1}',u'f0{$1}',u'span class="boxed" style="border-color: $p; background: $q;"',], 
      u'\\frac':[u'{$1}{$2}',u'f0{f3{(}f1{$1}f3{)/(}f2{$2}f3{)}}',u'span class="fraction"',u'span class="numerator"',u'span class="denominator"',u'span class="ignored"',], 
      u'\\framebox':[u'[$p!][$q!]{$1}',u'f0{$1}',u'span class="framebox align-$q" style="width: $p;"',], 
      u'\\href':[u'[$o]{$u!}{$t!}',u'f0{$t}',u'a href="$u"',], 
      u'\\hspace':[u'{$p!}',u'f0{ }',u'span class="hspace" style="width: $p;"',], 
      u'\\leftroot':[u'{$p!}',u'f0{ }',u'span class="leftroot" style="width: $p;px"',], 
      u'\\nicefrac':[u'{$1}{$2}',u'f0{f1{$1}⁄f2{$2}}',u'span class="fraction"',u'sup class="numerator"',u'sub class="denominator"',u'span class="ignored"',], 
      u'\\parbox':[u'[$p!]{$w!}{$1}',u'f0{1}',u'div class="Boxed" style="width: $w;"',], 
      u'\\raisebox':[u'{$p!}{$1}',u'f0{$1.font}',u'span class="raisebox" style="vertical-align: $p;"',], 
      u'\\renewenvironment':[u'{$1!}{$2!}{$3!}',u'',], 
      u'\\rule':[u'[$v!]{$w!}{$h!}',u'f0/',u'hr class="line" style="width: $w; height: $h;"',], 
      u'\\scriptscriptstyle':[u'{$1}',u'f0{$1}',u'span class="scriptscriptstyle"',], 
      u'\\scriptstyle':[u'{$1}',u'f0{$1}',u'span class="scriptstyle"',], 
      u'\\sqrt':[u'[$0]{$1}',u'f0{f1{$0}f2{√}f4{(}f3{$1}f4{)}}',u'span class="sqrt"',u'sup class="root"',u'span class="radical"',u'span class="root"',u'span class="ignored"',], 
      u'\\stackrel':[u'{$1}{$2}',u'f0{f1{$1}f2{$2}}',u'span class="stackrel"',u'span class="upstackrel"',u'span class="downstackrel"',], 
      u'\\tbinom':[u'{$1}{$2}',u'(f0{f1{f2{$1}}f1{f2{ }}f1{f2{$2}}})',u'span class="binomial"',u'span class="binomrow"',u'span class="binomcell"',], 
      u'\\textcolor':[u'{$p!}{$1}',u'f0{$1}',u'span style="color: $p;"',], 
      u'\\textstyle':[u'{$1}',u'f0{$1}',u'span class="textstyle"',], 
      u'\\unit':[u'[$0]{$1}',u'$0f0{$1.font}',u'span class="unit"',], 
      u'\\unitfrac':[u'[$0]{$1}{$2}',u'$0f0{f1{$1.font}⁄f2{$2.font}}',u'span class="fraction"',u'sup class="unit"',u'sub class="unit"',], 
      u'\\uproot':[u'{$p!}',u'f0{ }',u'span class="uproot" style="width: $p;px"',], 
      u'\\url':[u'{$u!}',u'f0{$u}',u'a href="$u"',], 
      u'\\vspace':[u'{$p!}',u'f0{ }',u'span class="vspace" style="height: $p;"',], 
      }

  hybridsizes = {
      u'\\binom':u'$1+$2', u'\\cfrac':u'$1+$2', u'\\dbinom':u'$1+$2+1', 
      u'\\dfrac':u'$1+$2', u'\\frac':u'$1+$2', u'\\tbinom':u'$1+$2+1', 
      }

  labelfunctions = {
      u'\\label':u'a name="#"', 
      }

  limitcommands = {
      u'\\biginterleave':u'⫼', u'\\bigsqcap':u'⨅', u'\\fint':u'⨏', 
      u'\\iiiint':u'⨌', u'\\int':u'∫', u'\\intop':u'∫', u'\\lim':u'lim', 
      u'\\prod':u'∏', u'\\smallint':u'∫', u'\\sqint':u'⨖', u'\\sum':u'∑', 
      u'\\varointclockwise':u'∲', u'\\varprod':u'⨉', u'\\zcmp':u'⨟', 
      u'\\zhide':u'⧹', u'\\zpipe':u'⨠', u'\\zproject':u'⨡', 
      }

  misccommands = {
      u'\\limits':u'LimitPreviousCommand', u'\\newcommand':u'MacroDefinition', 
      u'\\renewcommand':u'MacroDefinition', 
      u'\\setcounter':u'SetCounterFunction', u'\\tag':u'FormulaTag', 
      u'\\tag*':u'FormulaTag', 
      }

  modified = {
      u'\n':u'', u' ':u'', u'$':u'', u'&':u'	', u'\'':u'’', u'+':u' + ', 
      u',':u', ', u'-':u' − ', u'/':u' ⁄ ', u'<':u' &lt; ', u'=':u' = ', 
      u'>':u' &gt; ', u'@':u'', u'~':u'', 
      }

  onefunctions = {
      u'\\Big':u'span class="bigsymbol"', u'\\Bigg':u'span class="hugesymbol"', 
      u'\\bar':u'span class="bar"', u'\\begin{array}':u'span class="arraydef"', 
      u'\\big':u'span class="symbol"', u'\\bigg':u'span class="largesymbol"', 
      u'\\bigl':u'span class="bigsymbol"', u'\\bigr':u'span class="bigsymbol"', 
      u'\\centering':u'span class="align-center"', 
      u'\\ensuremath':u'span class="ensuremath"', 
      u'\\hphantom':u'span class="phantom"', 
      u'\\noindent':u'span class="noindent"', 
      u'\\overbrace':u'span class="overbrace"', 
      u'\\overline':u'span class="overline"', 
      u'\\phantom':u'span class="phantom"', 
      u'\\underbrace':u'span class="underbrace"', u'\\underline':u'u', 
      u'\\vphantom':u'span class="phantom"', 
      }

  spacedcommands = {
      u'\\Bot':u'⫫', u'\\Doteq':u'≑', u'\\DownArrowBar':u'⤓', 
      u'\\DownLeftTeeVector':u'⥞', u'\\DownLeftVectorBar':u'⥖', 
      u'\\DownRightTeeVector':u'⥟', u'\\DownRightVectorBar':u'⥗', 
      u'\\Equal':u'⩵', u'\\LeftArrowBar':u'⇤', u'\\LeftDownTeeVector':u'⥡', 
      u'\\LeftDownVectorBar':u'⥙', u'\\LeftTeeVector':u'⥚', 
      u'\\LeftTriangleBar':u'⧏', u'\\LeftUpTeeVector':u'⥠', 
      u'\\LeftUpVectorBar':u'⥘', u'\\LeftVectorBar':u'⥒', 
      u'\\Leftrightarrow':u'⇔', u'\\Longmapsfrom':u'⟽', u'\\Longmapsto':u'⟾', 
      u'\\MapsDown':u'↧', u'\\MapsUp':u'↥', u'\\Nearrow':u'⇗', 
      u'\\NestedGreaterGreater':u'⪢', u'\\NestedLessLess':u'⪡', 
      u'\\NotGreaterLess':u'≹', u'\\NotGreaterTilde':u'≵', 
      u'\\NotLessTilde':u'≴', u'\\Nwarrow':u'⇖', u'\\Proportion':u'∷', 
      u'\\RightArrowBar':u'⇥', u'\\RightDownTeeVector':u'⥝', 
      u'\\RightDownVectorBar':u'⥕', u'\\RightTeeVector':u'⥛', 
      u'\\RightTriangleBar':u'⧐', u'\\RightUpTeeVector':u'⥜', 
      u'\\RightUpVectorBar':u'⥔', u'\\RightVectorBar':u'⥓', 
      u'\\Rightarrow':u'⇒', u'\\Same':u'⩶', u'\\Searrow':u'⇘', 
      u'\\Swarrow':u'⇙', u'\\Top':u'⫪', u'\\UpArrowBar':u'⤒', u'\\VDash':u'⊫', 
      u'\\approx':u'≈', u'\\approxeq':u'≊', u'\\backsim':u'∽', u'\\barin':u'⋶', 
      u'\\barleftharpoon':u'⥫', u'\\barrightharpoon':u'⥭', u'\\bij':u'⤖', 
      u'\\coloneq':u'≔', u'\\corresponds':u'≙', u'\\curlyeqprec':u'⋞', 
      u'\\curlyeqsucc':u'⋟', u'\\dashrightarrow':u'⇢', u'\\dlsh':u'↲', 
      u'\\downdownharpoons':u'⥥', u'\\downuparrows':u'⇵', 
      u'\\downupharpoons':u'⥯', u'\\drsh':u'↳', u'\\eqslantgtr':u'⪖', 
      u'\\eqslantless':u'⪕', u'\\equiv':u'≡', u'\\ffun':u'⇻', u'\\finj':u'⤕', 
      u'\\ge':u'≥', u'\\geq':u'≥', u'\\ggcurly':u'⪼', u'\\gnapprox':u'⪊', 
      u'\\gneq':u'⪈', u'\\gtrapprox':u'⪆', u'\\hash':u'⋕', u'\\iddots':u'⋰', 
      u'\\implies':u' ⇒ ', u'\\in':u'∈', u'\\le':u'≤', u'\\leftarrow':u'←', 
      u'\\leftarrowtriangle':u'⇽', u'\\leftbarharpoon':u'⥪', 
      u'\\leftrightarrowtriangle':u'⇿', u'\\leftrightharpoon':u'⥊', 
      u'\\leftrightharpoondown':u'⥐', u'\\leftrightharpoonup':u'⥎', 
      u'\\leftrightsquigarrow':u'↭', u'\\leftslice':u'⪦', 
      u'\\leftsquigarrow':u'⇜', u'\\leftupdownharpoon':u'⥑', u'\\leq':u'≤', 
      u'\\lessapprox':u'⪅', u'\\llcurly':u'⪻', u'\\lnapprox':u'⪉', 
      u'\\lneq':u'⪇', u'\\longmapsfrom':u'⟻', u'\\multimapboth':u'⧟', 
      u'\\multimapdotbothA':u'⊶', u'\\multimapdotbothB':u'⊷', 
      u'\\multimapinv':u'⟜', u'\\nVdash':u'⊮', u'\\ne':u'≠', u'\\neq':u'≠', 
      u'\\ngeq':u'≱', u'\\nleq':u'≰', u'\\nni':u'∌', u'\\not\\in':u'∉', 
      u'\\notasymp':u'≭', u'\\npreceq':u'⋠', u'\\nsqsubseteq':u'⋢', 
      u'\\nsqsupseteq':u'⋣', u'\\nsubset':u'⊄', u'\\nsucceq':u'⋡', 
      u'\\pfun':u'⇸', u'\\pinj':u'⤔', u'\\precapprox':u'⪷', u'\\preceqq':u'⪳', 
      u'\\precnapprox':u'⪹', u'\\precnsim':u'⋨', u'\\propto':u'∝', 
      u'\\psur':u'⤀', u'\\rightarrow':u'→', u'\\rightarrowtriangle':u'⇾', 
      u'\\rightbarharpoon':u'⥬', u'\\rightleftharpoon':u'⥋', 
      u'\\rightslice':u'⪧', u'\\rightsquigarrow':u'⇝', 
      u'\\rightupdownharpoon':u'⥏', u'\\sim':u'~', u'\\strictfi':u'⥼', 
      u'\\strictif':u'⥽', u'\\subset':u'⊂', u'\\subseteq':u'⊆', 
      u'\\subsetneq':u'⊊', u'\\succapprox':u'⪸', u'\\succeqq':u'⪴', 
      u'\\succnapprox':u'⪺', u'\\supset':u'⊃', u'\\supseteq':u'⊇', 
      u'\\supsetneq':u'⊋', u'\\times':u'×', u'\\to':u'→', 
      u'\\updownarrows':u'⇅', u'\\updownharpoons':u'⥮', u'\\upupharpoons':u'⥣', 
      u'\\vartriangleleft':u'⊲', u'\\vartriangleright':u'⊳', 
      }

  starts = {
      u'beginafter':u'}', u'beginbefore':u'\\begin{', u'bracket':u'{', 
      u'command':u'\\', u'comment':u'%', u'complex':u'\\[', u'simple':u'$', 
      u'squarebracket':u'[', u'unnumbered':u'*', 
      }

  symbolfunctions = {
      u'^':u'sup', u'_':u'sub', 
      }

  textfunctions = {
      u'\\mbox':u'span class="mbox"', u'\\text':u'span class="text"', 
      u'\\textbf':u'b', u'\\textipa':u'span class="textipa"', u'\\textit':u'i', 
      u'\\textnormal':u'span class="textnormal"', 
      u'\\textrm':u'span class="textrm"', 
      u'\\textsc':u'span class="versalitas"', 
      u'\\textsf':u'span class="textsf"', u'\\textsl':u'i', u'\\texttt':u'tt', 
      u'\\textup':u'span class="normal"', 
      }

  unmodified = {
      
      u'characters':[u'.',u'*',u'€',u'(',u')',u'[',u']',u':',u'·',u'!',u';',u'|',u'§',u'"',], 
      }

  urls = {
      u'googlecharts':u'http://chart.googleapis.com/chart?cht=tx&chl=', 
      }

class GeneralConfig(object):
  "Configuration class from elyxer.config file"

  version = {
      u'date':u'2011-08-31', u'lyxformat':u'413', u'number':u'1.2.3', 
      }

class HeaderConfig(object):
  "Configuration class from elyxer.config file"

  parameters = {
      u'beginpreamble':u'\\begin_preamble', u'branch':u'\\branch', 
      u'documentclass':u'\\textclass', u'endbranch':u'\\end_branch', 
      u'endpreamble':u'\\end_preamble', u'language':u'\\language', 
      u'lstset':u'\\lstset', u'outputchanges':u'\\output_changes', 
      u'paragraphseparation':u'\\paragraph_separation', 
      u'pdftitle':u'\\pdf_title', u'secnumdepth':u'\\secnumdepth', 
      u'tocdepth':u'\\tocdepth', 
      }

  styles = {
      
      u'article':[u'article',u'aastex',u'aapaper',u'acmsiggraph',u'sigplanconf',u'achemso',u'amsart',u'apa',u'arab-article',u'armenian-article',u'article-beamer',u'chess',u'dtk',u'elsarticle',u'heb-article',u'IEEEtran',u'iopart',u'kluwer',u'scrarticle-beamer',u'scrartcl',u'extarticle',u'paper',u'mwart',u'revtex4',u'spie',u'svglobal3',u'ltugboat',u'agu-dtd',u'jgrga',u'agums',u'entcs',u'egs',u'ijmpc',u'ijmpd',u'singlecol-new',u'doublecol-new',u'isprs',u'tarticle',u'jsarticle',u'jarticle',u'jss',u'literate-article',u'siamltex',u'cl2emult',u'llncs',u'svglobal',u'svjog',u'svprobth',], 
      u'book':[u'book',u'amsbook',u'scrbook',u'extbook',u'tufte-book',u'report',u'extreport',u'scrreprt',u'memoir',u'tbook',u'jsbook',u'jbook',u'mwbk',u'svmono',u'svmult',u'treport',u'jreport',u'mwrep',], 
      }

class ImageConfig(object):
  "Configuration class from elyxer.config file"

  converters = {
      
      u'imagemagick':u'convert[ -density $scale][ -define $format:use-cropbox=true] "$input" "$output"', 
      u'inkscape':u'inkscape "$input" --export-png="$output"', 
      }

  cropboxformats = {
      u'.eps':u'ps', u'.pdf':u'pdf', u'.ps':u'ps', 
      }

  formats = {
      u'default':u'.png', u'vector':[u'.svg',u'.eps',], 
      }

class LayoutConfig(object):
  "Configuration class from elyxer.config file"

  groupable = {
      
      u'allowed':[u'StringContainer',u'Constant',u'TaggedText',u'Align',u'TextFamily',u'EmphaticText',u'VersalitasText',u'BarredText',u'SizeText',u'ColorText',u'LangLine',u'Formula',], 
      }

class NewfangleConfig(object):
  "Configuration class from elyxer.config file"

  constants = {
      u'chunkref':u'chunkref{', u'endcommand':u'}', u'endmark':u'&gt;', 
      u'startcommand':u'\\', u'startmark':u'=&lt;', 
      }

class NumberingConfig(object):
  "Configuration class from elyxer.config file"

  layouts = {
      
      u'ordered':[u'Chapter',u'Section',u'Subsection',u'Subsubsection',u'Paragraph',], 
      u'roman':[u'Part',u'Book',], 
      }

  sequence = {
      u'symbols':[u'*',u'**',u'†',u'‡',u'§',u'§§',u'¶',u'¶¶',u'#',u'##',], 
      }

class StyleConfig(object):
  "Configuration class from elyxer.config file"

  hspaces = {
      u'\\enskip{}':u' ', u'\\hfill{}':u'<span class="hfill"> </span>', 
      u'\\hspace*{\\fill}':u' ', u'\\hspace*{}':u'', u'\\hspace{}':u' ', 
      u'\\negthinspace{}':u'', u'\\qquad{}':u'  ', u'\\quad{}':u' ', 
      u'\\space{}':u' ', u'\\thinspace{}':u' ', u'~':u' ', 
      }

  quotes = {
      u'ald':u'»', u'als':u'›', u'ard':u'«', u'ars':u'‹', u'eld':u'&ldquo;', 
      u'els':u'&lsquo;', u'erd':u'&rdquo;', u'ers':u'&rsquo;', u'fld':u'«', 
      u'fls':u'‹', u'frd':u'»', u'frs':u'›', u'gld':u'„', u'gls':u'‚', 
      u'grd':u'“', u'grs':u'‘', u'pld':u'„', u'pls':u'‚', u'prd':u'”', 
      u'prs':u'’', u'sld':u'”', u'srd':u'”', 
      }

  referenceformats = {
      u'eqref':u'(@↕)', u'formatted':u'¶↕', u'nameref':u'$↕', u'pageref':u'#↕', 
      u'ref':u'@↕', u'vpageref':u'on-page#↕', u'vref':u'@on-page#↕', 
      }

  size = {
      u'ignoredtexts':[u'col',u'text',u'line',u'page',u'theight',u'pheight',], 
      }

  vspaces = {
      u'bigskip':u'<div class="bigskip"> </div>', 
      u'defskip':u'<div class="defskip"> </div>', 
      u'medskip':u'<div class="medskip"> </div>', 
      u'smallskip':u'<div class="smallskip"> </div>', 
      u'vfill':u'<div class="vfill"> </div>', 
      }

class TOCConfig(object):
  "Configuration class from elyxer.config file"

  extractplain = {
      
      u'allowed':[u'StringContainer',u'Constant',u'TaggedText',u'Align',u'TextFamily',u'EmphaticText',u'VersalitasText',u'BarredText',u'SizeText',u'ColorText',u'LangLine',u'Formula',], 
      u'cloned':[u'',], u'extracted':[u'',], 
      }

  extracttitle = {
      u'allowed':[u'StringContainer',u'Constant',u'Space',], 
      u'cloned':[u'TextFamily',u'EmphaticText',u'VersalitasText',u'BarredText',u'SizeText',u'ColorText',u'LangLine',u'Formula',], 
      u'extracted':[u'PlainLayout',u'TaggedText',u'Align',u'Caption',u'StandardLayout',u'FlexInset',], 
      }

class TagConfig(object):
  "Configuration class from elyxer.config file"

  barred = {
      u'under':u'u', 
      }

  family = {
      u'sans':u'span class="sans"', u'typewriter':u'tt', 
      }

  flex = {
      u'CharStyle:Code':u'span class="code"', 
      u'CharStyle:MenuItem':u'span class="menuitem"', 
      u'Code':u'span class="code"', u'MenuItem':u'span class="menuitem"', 
      u'Noun':u'span class="noun"', u'Strong':u'span class="strong"', 
      }

  group = {
      u'layouts':[u'Quotation',u'Quote',], 
      }

  layouts = {
      u'Center':u'div', u'Chapter':u'h?', u'Date':u'h2', u'Paragraph':u'div', 
      u'Part':u'h1', u'Quotation':u'blockquote', u'Quote':u'blockquote', 
      u'Section':u'h?', u'Subsection':u'h?', u'Subsubsection':u'h?', 
      }

  listitems = {
      u'Enumerate':u'ol', u'Itemize':u'ul', 
      }

  notes = {
      u'Comment':u'', u'Greyedout':u'span class="greyedout"', u'Note':u'', 
      }

  script = {
      u'subscript':u'sub', u'superscript':u'sup', 
      }

  shaped = {
      u'italic':u'i', u'slanted':u'i', u'smallcaps':u'span class="versalitas"', 
      }

class TranslationConfig(object):
  "Configuration class from elyxer.config file"

  constants = {
      u'Appendix':u'Appendix', u'Book':u'Book', u'Chapter':u'Chapter', 
      u'Paragraph':u'Paragraph', u'Part':u'Part', u'Section':u'Section', 
      u'Subsection':u'Subsection', u'Subsubsection':u'Subsubsection', 
      u'abstract':u'Abstract', u'bibliography':u'Bibliography', 
      u'figure':u'figure', u'float-algorithm':u'Algorithm ', 
      u'float-figure':u'Figure ', u'float-listing':u'Listing ', 
      u'float-table':u'Table ', u'float-tableau':u'Tableau ', 
      u'footnotes':u'Footnotes', u'generated-by':u'Document generated by ', 
      u'generated-on':u' on ', u'index':u'Index', 
      u'jsmath-enable':u'Please enable JavaScript on your browser.', 
      u'jsmath-requires':u' requires JavaScript to correctly process the mathematics on this page. ', 
      u'jsmath-warning':u'Warning: ', u'list-algorithm':u'List of Algorithms', 
      u'list-figure':u'List of Figures', u'list-table':u'List of Tables', 
      u'list-tableau':u'List of Tableaux', u'main-page':u'Main page', 
      u'next':u'Next', u'nomenclature':u'Nomenclature', 
      u'on-page':u' on page ', u'prev':u'Prev', u'references':u'References', 
      u'toc':u'Table of Contents', u'toc-for':u'Contents for ', u'up':u'Up', 
      }

  languages = {
      u'american':u'en', u'british':u'en', u'deutsch':u'de', u'dutch':u'nl', 
      u'english':u'en', u'french':u'fr', u'ngerman':u'de', u'spanish':u'es', 
      }






class Globable(object):
  """A bit of text which can be globbed (lumped together in bits).
  Methods current(), skipcurrent(), checkfor() and isout() have to be
  implemented by subclasses."""

  leavepending = False

  def __init__(self):
    self.endinglist = EndingList()

  def checkbytemark(self):
    "Check for a Unicode byte mark and skip it."
    if self.finished():
      return
    if ord(self.current()) == 0xfeff:
      self.skipcurrent()

  def isout(self):
    "Find out if we are out of the position yet."
    Trace.error('Unimplemented isout()')
    return True

  def current(self):
    "Return the current character."
    Trace.error('Unimplemented current()')
    return ''

  def checkfor(self, string):
    "Check for the given string in the current position."
    Trace.error('Unimplemented checkfor()')
    return False

  def finished(self):
    "Find out if the current text has finished."
    if self.isout():
      if not self.leavepending:
        self.endinglist.checkpending()
      return True
    return self.endinglist.checkin(self)

  def skipcurrent(self):
    "Return the current character and skip it."
    Trace.error('Unimplemented skipcurrent()')
    return ''

  def glob(self, currentcheck):
    "Glob a bit of text that satisfies a check on the current char."
    glob = ''
    while not self.finished() and currentcheck():
      glob += self.skipcurrent()
    return glob

  def globalpha(self):
    "Glob a bit of alpha text"
    return self.glob(lambda: self.current().isalpha())

  def globnumber(self):
    "Glob a row of digits."
    return self.glob(lambda: self.current().isdigit())

  def isidentifier(self):
    "Return if the current character is alphanumeric or _."
    if self.current().isalnum() or self.current() == '_':
      return True
    return False

  def globidentifier(self):
    "Glob alphanumeric and _ symbols."
    return self.glob(self.isidentifier)

  def isvalue(self):
    "Return if the current character is a value character:"
    "not a bracket or a space."
    if self.current().isspace():
      return False
    if self.current() in '{}()':
      return False
    return True

  def globvalue(self):
    "Glob a value: any symbols but brackets."
    return self.glob(self.isvalue)

  def skipspace(self):
    "Skip all whitespace at current position."
    return self.glob(lambda: self.current().isspace())

  def globincluding(self, magicchar):
    "Glob a bit of text up to (including) the magic char."
    glob = self.glob(lambda: self.current() != magicchar) + magicchar
    self.skip(magicchar)
    return glob

  def globexcluding(self, excluded):
    "Glob a bit of text up until (excluding) any excluded character."
    return self.glob(lambda: self.current() not in excluded)

  def pushending(self, ending, optional = False):
    "Push a new ending to the bottom"
    self.endinglist.add(ending, optional)

  def popending(self, expected = None):
    "Pop the ending found at the current position"
    if self.isout() and self.leavepending:
      return expected
    ending = self.endinglist.pop(self)
    if expected and expected != ending:
      Trace.error('Expected ending ' + expected + ', got ' + ending)
    self.skip(ending)
    return ending

  def nextending(self):
    "Return the next ending in the queue."
    nextending = self.endinglist.findending(self)
    if not nextending:
      return None
    return nextending.ending

class EndingList(object):
  "A list of position endings"

  def __init__(self):
    self.endings = []

  def add(self, ending, optional = False):
    "Add a new ending to the list"
    self.endings.append(PositionEnding(ending, optional))

  def pickpending(self, pos):
    "Pick any pending endings from a parse position."
    self.endings += pos.endinglist.endings

  def checkin(self, pos):
    "Search for an ending"
    if self.findending(pos):
      return True
    return False

  def pop(self, pos):
    "Remove the ending at the current position"
    if pos.isout():
      Trace.error('No ending out of bounds')
      return ''
    ending = self.findending(pos)
    if not ending:
      Trace.error('No ending at ' + pos.current())
      return ''
    for each in reversed(self.endings):
      self.endings.remove(each)
      if each == ending:
        return each.ending
      elif not each.optional:
        Trace.error('Removed non-optional ending ' + each)
    Trace.error('No endings left')
    return ''

  def findending(self, pos):
    "Find the ending at the current position"
    if len(self.endings) == 0:
      return None
    for index, ending in enumerate(reversed(self.endings)):
      if ending.checkin(pos):
        return ending
      if not ending.optional:
        return None
    return None

  def checkpending(self):
    "Check if there are any pending endings"
    if len(self.endings) != 0:
      Trace.error('Pending ' + unicode(self) + ' left open')

  def __unicode__(self):
    "Printable representation"
    string = 'endings ['
    for ending in self.endings:
      string += unicode(ending) + ','
    if len(self.endings) > 0:
      string = string[:-1]
    return string + ']'

class PositionEnding(object):
  "An ending for a parsing position"

  def __init__(self, ending, optional):
    self.ending = ending
    self.optional = optional

  def checkin(self, pos):
    "Check for the ending"
    return pos.checkfor(self.ending)

  def __unicode__(self):
    "Printable representation"
    string = 'Ending ' + self.ending
    if self.optional:
      string += ' (optional)'
    return string



class Position(Globable):
  """A position in a text to parse.
  Including those in Globable, functions to implement by subclasses are:
  skip(), identifier(), extract(), isout() and current()."""

  def __init__(self):
    Globable.__init__(self)

  def skip(self, string):
    "Skip a string"
    Trace.error('Unimplemented skip()')

  def identifier(self):
    "Return an identifier for the current position."
    Trace.error('Unimplemented identifier()')
    return 'Error'

  def extract(self, length):
    "Extract the next string of the given length, or None if not enough text,"
    "without advancing the parse position."
    Trace.error('Unimplemented extract()')
    return None

  def checkfor(self, string):
    "Check for a string at the given position."
    return string == self.extract(len(string))

  def checkforlower(self, string):
    "Check for a string in lower case."
    extracted = self.extract(len(string))
    if not extracted:
      return False
    return string.lower() == self.extract(len(string)).lower()

  def skipcurrent(self):
    "Return the current character and skip it."
    current = self.current()
    self.skip(current)
    return current

  def next(self):
    "Advance the position and return the next character."
    self.skipcurrent()
    return self.current()

  def checkskip(self, string):
    "Check for a string at the given position; if there, skip it"
    if not self.checkfor(string):
      return False
    self.skip(string)
    return True

  def error(self, message):
    "Show an error message and the position identifier."
    Trace.error(message + ': ' + self.identifier())

class TextPosition(Position):
  "A parse position based on a raw text."

  def __init__(self, text):
    "Create the position from elyxer.some text."
    Position.__init__(self)
    self.pos = 0
    self.text = text
    self.checkbytemark()

  def skip(self, string):
    "Skip a string of characters."
    self.pos += len(string)

  def identifier(self):
    "Return a sample of the remaining text."
    length = 30
    if self.pos + length > len(self.text):
      length = len(self.text) - self.pos
    return '*' + self.text[self.pos:self.pos + length] + '*'

  def isout(self):
    "Find out if we are out of the text yet."
    return self.pos >= len(self.text)

  def current(self):
    "Return the current character, assuming we are not out."
    return self.text[self.pos]

  def extract(self, length):
    "Extract the next string of the given length, or None if not enough text."
    if self.pos + length > len(self.text):
      return None
    return self.text[self.pos : self.pos + length]

class FilePosition(Position):
  "A parse position based on an underlying file."

  def __init__(self, filename):
    "Create the position from a file."
    Position.__init__(self)
    self.reader = LineReader(filename)
    self.pos = 0
    self.checkbytemark()

  def skip(self, string):
    "Skip a string of characters."
    length = len(string)
    while self.pos + length > len(self.reader.currentline()):
      length -= len(self.reader.currentline()) - self.pos + 1
      self.nextline()
    self.pos += length

  def currentline(self):
    "Get the current line of the underlying file."
    return self.reader.currentline()

  def nextline(self):
    "Go to the next line."
    self.reader.nextline()
    self.pos = 0

  def linenumber(self):
    "Return the line number of the file."
    return self.reader.linenumber + 1

  def identifier(self):
    "Return the current line and line number in the file."
    before = self.reader.currentline()[:self.pos - 1]
    after = self.reader.currentline()[self.pos:]
    return 'line ' + unicode(self.getlinenumber()) + ': ' + before + '*' + after

  def isout(self):
    "Find out if we are out of the text yet."
    if self.pos > len(self.reader.currentline()):
      if self.pos > len(self.reader.currentline()) + 1:
        Trace.error('Out of the line ' + self.reader.currentline() + ': ' + unicode(self.pos))
      self.nextline()
    return self.reader.finished()

  def current(self):
    "Return the current character, assuming we are not out."
    if self.pos == len(self.reader.currentline()):
      return '\n'
    if self.pos > len(self.reader.currentline()):
      Trace.error('Out of the line ' + self.reader.currentline() + ': ' + unicode(self.pos))
      return '*'
    return self.reader.currentline()[self.pos]

  def extract(self, length):
    "Extract the next string of the given length, or None if not enough text."
    if self.pos + length > len(self.reader.currentline()):
      return None
    return self.reader.currentline()[self.pos : self.pos + length]



files = list()

def getreader(filename):
  "Get a reader for lines"
  if filename in files:
    # already parsed; skip
    return None
  files.append(filename)
  return LineReader(filename)

def readargs(args):
  "Read arguments from the command line"
  del args[0]
  if len(args) == 0:
    usage()
    return None, None
  if args[0] == '-h' or args[0] == '--help':
    usage()
    return None, None
  reader = getreader(args[0])
  del args[0]
  fileout = sys.stdout
  if len(args) > 0:
    fileout = args[0]
    del args[0]
  if len(args) > 0:
    usage()
    return
  writer = LineWriter(fileout)
  return reader, writer

def usage():
  "Show command line help."
  Trace.error('Usage: loremipsumize.py filein [fileout]')
  Trace.error('Mask your document using nonsensical words (Lorem Ipsum).')
  Trace.error('Part of the eLyXer package (http://elyxer.nongnu.org/).')
  Trace.error('  Options:')
  Trace.error('    --help: show this message and quit.')
  return

class LoremIpsumizer(object):

  starts = '@\\'

  def loremipsumize(self, reader, writer):
    "Convert all texts longer than two words to 'lorem ipsum'."
    if not reader:
      return
    while not reader.finished():
      line = self.processline(reader.currentline())
      writer.writeline(line)
      reader.nextline()
    reader.close()

  def processline(self, line):
    "Process a single line and return the result."
    if len(line) == 0:
      return ''
    if line[0] in LoremIpsumizer.starts:
      return line
    pos = TextPosition(line)
    result = ''
    while not pos.finished():
      result += self.parsepos(pos)
    return result

  def parsepos(self, pos):
    "Parse the current position, return the result."
    if pos.current().isalpha() or pos.current().isdigit():
      alpha = pos.glob(lambda current: current.isalpha() or current.isspace() or current.isdigit())
      if len(alpha.split()) > 2:
        return "lorem ipsum"
      return alpha
    if pos.current().isspace():
      return pos.skipspace()
    return pos.skipcurrent()

reader, writer = readargs(sys.argv)
if reader:
  LoremIpsumizer().loremipsumize(reader, writer)
  writer.close()


