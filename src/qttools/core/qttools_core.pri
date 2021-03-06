#############################################################################
##
##  FougTools
##  Copyright FougSys (1 Mar. 2011)
##  contact@fougsys.fr
##
## This software is a computer program whose purpose is to provide utility
## tools for the C++ language and the Qt toolkit.
##
## This software is governed by the CeCILL-C license under French law and
## abiding by the rules of distribution of free software.  You can  use,
## modify and/ or redistribute the software under the terms of the CeCILL-C
## license as circulated by CEA, CNRS and INRIA at the following URL
## "http://www.cecill.info".
##
## As a counterpart to the access to the source code and  rights to copy,
## modify and redistribute granted by the license, users are provided only
## with a limited warranty  and the software's author,  the holder of the
## economic rights,  and the successive licensors  have only  limited
## liability.
##
## In this respect, the user's attention is drawn to the risks associated
## with loading,  using,  modifying and/or developing or reproducing the
## software by the user in light of its specific status of free software,
## that may mean  that it is complicated to manipulate,  and  that  also
## therefore means  that it is reserved for developers  and  experienced
## professionals having in-depth computer knowledge. Users are therefore
## encouraged to load and test the software's suitability as regards their
## requirements in conditions enabling the security of their systems and/or
## data to be ensured and,  more generally, to use and operate it in the
## same conditions as regards security.
##
## The fact that you are presently reading this means that you have had
## knowledge of the CeCILL-C license and that you accept its terms.
##
#############################################################################

HEADERS += \
    $$PWD/abstract_cipher.h \
    $$PWD/abstract_plugin_loader.h \
    $$PWD/abstract_signal_dispatch.h \
    $$PWD/core.h \
    $$PWD/grid_numbering.h \
    $$PWD/grid_struct.h \
    $$PWD/item_model_tools.h \
    $$PWD/log.h \
    $$PWD/log_unqualified.h \
    $$PWD/qlocale_tools.h \
    $$PWD/qobject_tools.h \
    $$PWD/qobject_wrap.h \
    $$PWD/qstring_tools.h \
    $$PWD/qvariant_tools.h \
    $$PWD/runtime_error.h \
    $$PWD/scoped_connection.h \
    $$PWD/singleton.h \
    $$PWD/sleep.h \
    $$PWD/task.h \
    $$PWD/wait_loop.h

SOURCES += \
    $$PWD/abstract_cipher.cpp \
    $$PWD/abstract_plugin_loader.cpp \
    $$PWD/abstract_signal_dispatch.cpp \
    $$PWD/log.cpp \
    $$PWD/qlocale_tools.cpp \
    $$PWD/qobject_tools.cpp \
    $$PWD/qobject_wrap.cpp \
    $$PWD/qstring_tools.cpp \
    $$PWD/runtime_error.cpp \
    $$PWD/scoped_connection.cpp \
    $$PWD/sleep.cpp \
    $$PWD/task.cpp \
    $$PWD/item_model_tools.cpp \
    $$PWD/grid_numbering.cpp \
    $$PWD/grid_struct.cpp \
    $$PWD/wait_loop.cpp
