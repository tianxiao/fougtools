/****************************************************************************
**
**  FougTools
**  Copyright FougSys (1 Mar. 2011)
**  contact@fougsys.fr
**
** This software is a computer program whose purpose is to provide utility
** tools for the C++ language, the Qt and Open Cascade toolkits.
**
** This software is governed by the CeCILL-C license under French law and
** abiding by the rules of distribution of free software.  You can  use,
** modify and/ or redistribute the software under the terms of the CeCILL-C
** license as circulated by CEA, CNRS and INRIA at the following URL
** "http://www.cecill.info".
**
** As a counterpart to the access to the source code and  rights to copy,
** modify and redistribute granted by the license, users are provided only
** with a limited warranty  and the software's author,  the holder of the
** economic rights,  and the successive licensors  have only  limited
** liability.
**
** In this respect, the user's attention is drawn to the risks associated
** with loading,  using,  modifying and/or developing or reproducing the
** software by the user in light of its specific status of free software,
** that may mean  that it is complicated to manipulate,  and  that  also
** therefore means  that it is reserved for developers  and  experienced
** professionals having in-depth computer knowledge. Users are therefore
** encouraged to load and test the software's suitability as regards their
** requirements in conditions enabling the security of their systems and/or
** data to be ensured and,  more generally, to use and operate it in the
** same conditions as regards security.
**
** The fact that you are presently reading this means that you have had
** knowledge of the CeCILL-C license and that you accept its terms.
**
****************************************************************************/

#ifndef OCC_MAKE_WIRE_FROM_EDGES_H
#define OCC_MAKE_WIRE_FROM_EDGES_H

#include "occtools/occtools.h"
#include <ShapeExtend_WireData.hxx>
#include <ShapeFix_Wire.hxx>
#include <TopoDS_Wire.hxx>
#include <algorithm>
#include <boost/bind.hpp>

namespace occ {

template<typename _FWD_ITERATOR_>
TopoDS_Wire makeWireFromEdges(_FWD_ITERATOR_ beginEdge, _FWD_ITERATOR_ endEdge)
{
  typedef void(ShapeExtend_WireData::* WireDataMemFun_t)(const TopoDS_Edge&,
                                                         const Standard_Integer);

  // Create a wire from the edges
  Handle_ShapeExtend_WireData wireData = new ShapeExtend_WireData;
  std::for_each(beginEdge, endEdge,
                boost::bind((WireDataMemFun_t)&ShapeExtend_WireData::Add,
                            wireData.operator->(), _1, 0));
  ShapeFix_Wire fixWire;
  fixWire.Load(wireData);
  fixWire.Perform();
  fixWire.FixReorder();
  fixWire.FixConnected();
  return fixWire.WireAPIMake();
}

} // namespace occ

#endif // OCC_MAKE_WIRE_FROM_EDGES_H