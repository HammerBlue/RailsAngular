'use strict';

function logDecorator( $delegate ) {

  function decoratedLog(msg) {
    if(ENV != 'prod') {
      return $delegate.log(msg);
    }
  };

  function decoratedInfo(msg) {
    if(ENV != 'prod') {
      return $delegate.info(msg);
    }
  };

  function decoratedWarn(msg) {
    if(ENV != 'prod') {
      return $delegate.warn(msg);
    }
  };

  function decoratedError(msg) {
    if(ENV != 'prod') {
      return $delegate.error(msg);
    }
  };

  function decoratedDebug(msg) {
    if(ENV != 'prod') {
      return $delegate.debug(msg);
    }
  };

  $delegate.log = decoratedLog;
  $delegate.info = decoratedInfo;
  $delegate.warn = decoratedWarn;
  $delegate.error = decoratedError;
  $delegate.debug = decoratedDebug;

  return $delegate;
}
