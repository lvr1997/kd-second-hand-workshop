package com.springmvc.ex;

public class UserPasswordErrorException extends ServiceException{
    public UserPasswordErrorException() {
        super();
    }

    public UserPasswordErrorException(String message) {
        super(message);
    }

    public UserPasswordErrorException(String message, Throwable cause) {
        super(message, cause);
    }

    public UserPasswordErrorException(Throwable cause) {
        super(cause);
    }

    protected UserPasswordErrorException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
