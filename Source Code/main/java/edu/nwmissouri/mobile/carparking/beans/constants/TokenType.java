package edu.nwmissouri.mobile.carparking.beans.constants;

public enum TokenType {

    RESET_PASSWORD(3 * 24 * 60 * 60 * 1000);

    private final long defaultExpiryTime;

    TokenType(long defaultExpiryTime) {
        this.defaultExpiryTime = defaultExpiryTime;
    }

    public long getDefaultExpiryTime() {
        return defaultExpiryTime;
    }
}
