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
module Experiment

import util::mad::Metric;
import util::mad::AST;
import util::mad::Report;

void testIt()
{
  MadRule rewrite = [<"w", "g">, <"g", "w">, <"w", "w">, <"w", "g">,<"w", "g">, <"w", "g">, <"w", "w">, <"w", "g">,<"w", "g">, <"w", "g">, <"w", "w">, <"w", "g">,<"w", "g">, <"w", "g">, <"w", "w">, <"w", "g">];
  MadRule rewrite2 = [<"w", "g">, <"w", "g">, <"w", "w">, <"w", "g">];

  Detail d = {<"g","w">};
  Rule r = rule(4, 4, rewrite);
  Rule r2 = getRuleScore(r, d);
  printReport(r2);
}