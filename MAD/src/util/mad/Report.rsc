@license{
  Copyright (c) 2009-2015 CWI / HvA
  All rights reserved. This program and the accompanying materials
  are made available under the terms of the Eclipse Public License v1.0
  which accompanies this distribution, and is available at
  http://www.eclipse.org/legal/epl-v10.html
}
/*****************************************************************************/
/*!
* Metric of Added Detail
* @package      util::util::mad::Metric
* @file         utl/MAD.rsc
* @brief        Defines the Metric of Added Detail for Tile Maps
* @contributor  Riemer van Rozen - rozen@cwi.nl - HvA, CREATE-IT / CWI
* @date         May 16th 2018
* @note         Language: Rascal
*/
/*****************************************************************************/
module util::mad::Report

import util::mad::Metric;
import util::mad::AST;

import IO;
import List;
import String;

public str getMadRuleStr(Rule r)
{
  int col = 0;
  str leftStr = "";
  for(str symb <- r.rewriteScore.lhs)
  {
    leftStr += symb;
    col += 1;
    if(col == r.width)
    {
      col = 0;
      leftStr += "\n";
    }
  }
  col = 0;
  str rightStr = "";
  for(str symb <- r.rewriteScore.rhs)
  {
    rightStr += symb;
    col += 1;
    if(col == r.width)
    {
      col = 0;
      rightStr += "\n";
    }
  }  
  m = appendCols(leftStr, " --\> ");
  m = appendCols(m, rightStr);
  return m;
}

str appendCols(str left, str right)
{
  list[str] leftLines = split("\n",left);
  list[str] rightLines = split("\n",right);
  
  int height = max([getHeight(leftLines), getHeight(rightLines)]);
  int leftWidth = getWidth(leftLines);

  str both = "";
  for (line <- [0..height])
  {
    str leftLine = "";
    str rightLine = "";
    if(line < size(leftLines))
    {
      leftLine = leftLines[line];
    }
    if(line < size(rightLines))
    {
      rightLine = rightLines[line];
    }
    both += pad(leftLine,leftWidth) + rightLine + "\n";
  }
  return both;
}

int getHeight(list[str] lines)
 = size(lines);

int getHeight(str s)
  = getHeight(split("\n",s));

int getWidth(list[str] lines)
 = max([size(line) | line <- lines]);

int getWidth(str s)
 = getWidth(split("\n",s));

str pad(str line, int width)
{
  str r = line;
  int lineWidth = size(line);
  if(lineWidth < width)
  {
    for(i <- [lineWidth..width])
    {
      r += " ";
    }
  }
  return r;
}

public str getMadScoreStr(Rule r)
{
  int col = 0;
  m = "";
  for(int score <- r.rewriteScore.score)
  {
    m += score2str(score);
    col += 1;
    if(col == r.width)
    {
      col = 0;
      m += "\n";
    }
  }
  return m;
}

public str score2str(int val)
{
  switch(val)
  {
    case 0: return ".";
    case 1: return "+";
    case -1: return "-";
  }
}

public str getHorBar(int width)
{
  str bar = "";
  for(int i <- [0..width])
  {
    bar+= "-";
  }
  return bar;
}

public str getVertBar(int height)
{
  str bar = "";
  for(int i <- [0..height])
  {
    bar+= " | \n";
  }
  return bar;
}

public void printReport(Rule r)
{
  str ruleStr = getMadRuleStr(r);
  str scoreStr = getMadScoreStr(r);
  int score = sumRuleScore(r);
  int negScore = sumRuleNegScore(r);
  int posScore = sumRulePosScore(r);  
  int reportHeight = getHeight(ruleStr);
  str verticalBar = getVertBar(reportHeight);
  str report = appendCols(ruleStr, verticalBar);
  report = appendCols(report, scoreStr);
  
  int rulesWidth = getWidth(ruleStr);
  int scoreWidth = getWidth(scoreStr);
  int reportWidth = getWidth(report);

  str header = pad("Rule:",rulesWidth) + " | " + pad("MAD heat map:",scoreWidth);
  int headerWidth = getWidth(header);
  int totalWidth = max([headerWidth, reportWidth]);
  str bar = getHorBar(totalWidth);
  
  println("<header>\n<bar>\n<report><bar>\nRule MAD score <score> (+<posScore>-<negScore>)");
}
