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
module util::mad::AST
import List;
import util::mad::Metric;

data Rule = rule(int width, int height, MadRule rewrite)
          | rule(int width, int height, MadRuleScore rewriteScore);

public int sumRuleScore(MadRuleScore rule)
  = sum(rule.score);
  
public int sumRuleNegScore(MadRuleScore rule)
  = sum(0+[-val|val<-rule.score,val==-1]);
  
public int sumRulePosScore(MadRuleScore rule)
  = sum(0+[val|val<-rule.score,val==1]);

public Rule getRuleScore(rule(int width, int height, MadRule rewrite), Detail detail)
  = rule(width, height, getRuleScore(rewrite, detail));
  
public int sumRuleScore(rule(int width, int height, MadRuleScore rewriteScore))
  = sumRuleScore(rewriteScore);
  
public int sumRulePosScore(rule(int width, int height, MadRuleScore rewriteScore))
  = sumRulePosScore(rewriteScore);
  
public int sumRuleNegScore(rule(int width, int height, MadRuleScore rewriteScore))
  = sumRuleNegScore(rewriteScore);