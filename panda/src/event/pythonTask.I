/**
 * PANDA 3D SOFTWARE
 * Copyright (c) Carnegie Mellon University.  All rights reserved.
 *
 * All use of this software is subject to the terms of the revised BSD
 * license.  You should have received a copy of this license along
 * with this source code in a file named "LICENSE."
 *
 * @file pythonTask.I
 * @author drose
 * @date 2008-09-16
 */

/**
 * If None is passed, calls clear_delay, otherwise sets the delay time.  See
 * AsyncTask::set_delay() and AsyncTask::clear_delay().
 */
INLINE void PythonTask::
set_delay(PyObject *delay) {
  if (delay == Py_None) {
    AsyncTask::clear_delay();
    return;
  }

  PyObject *value = PyNumber_Float(delay);
  if (value == NULL) {
    return;
  }

  AsyncTask::set_delay(PyFloat_AS_DOUBLE(value));
  Py_DECREF(value);
}

/**
 * Returns the delay time if set, None otherwise.  See AsyncTask::has_delay()
 * and AsyncTask::get_delay().
 */
INLINE PyObject *PythonTask::
get_delay() const {
  if (AsyncTask::has_delay()) {
    return PyFloat_FromDouble(AsyncTask::get_delay());
  } else {
    Py_INCREF(Py_None);
    return Py_None;
  }
}
