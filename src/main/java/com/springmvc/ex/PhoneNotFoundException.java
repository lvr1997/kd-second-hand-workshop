package com.springmvc.ex;

public class PhoneNotFoundException extends ServiceException{
    public PhoneNotFoundException() {
        super();
    }

    public PhoneNotFoundException(String message) {
        super(message);
    }

    public PhoneNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }

    public PhoneNotFoundException(Throwable cause) {
        super(cause);
    }

    protected PhoneNotFoundException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
