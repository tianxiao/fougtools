/****************************************************************************
**
**  FougTools
**  Copyright FougSys (1 Mar. 2011)
**  contact@fougsys.fr
**
** This software is a computer program whose purpose is to provide utility
** tools for the C++ language and the Qt toolkit.
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

#ifndef QTTOOLS_SINGLETON_H
#define QTTOOLS_SINGLETON_H

#include <QtCore/QAtomicPointer>
#include <QtCore/QMutex>

namespace qttools {

template<typename T>
class Singleton
{
public:
  static T* instance();
  static void release();

private:
  static QAtomicPointer<T> m_instance;
  static QMutex m_mutex;
};

// --
// -- Implementation
// --

template<typename T>
T* Singleton<T>::instance()
{
  if (!m_instance) {
    m_mutex.lock();
    if (!m_instance)
      m_instance = new T;
    m_mutex.unlock();
  }
  return m_instance;
}

template<typename T>
void Singleton<T>::release()
{
  m_mutex.lock();
  if (m_instance)
    delete m_instance;
  m_instance = NULL;
  m_mutex.unlock();
}

} // namespace qttools

template<typename T>
QAtomicPointer<T> qttools::Singleton<T>::m_instance;

template<typename T>
QMutex qttools::Singleton<T>::m_mutex;

#endif // QTTOOLS_SINGLETON_H
