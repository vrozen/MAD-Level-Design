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
module util::mad::Metric

alias Detail = rel[str more, str less];
alias MadRule = lrel[str lhs, str rhs];
alias MadRuleScore = lrel[str lhs, str rhs, int score];
  
public MadRuleScore getRuleScore(MadRule rule, Detail detail)
  = [<lhs, rhs, getTileScore(lhs, rhs, detail)> | <lhs, rhs> <- rule];

public int getTileScore(str lhs, str rhs, Detail detail)
{
  if(<rhs,lhs> in detail) return 1;
  else if(<lhs,rhs> in detail) return -1;
  else return 0;
}
