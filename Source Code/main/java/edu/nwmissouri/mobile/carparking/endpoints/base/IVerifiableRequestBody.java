package edu.nwmissouri.mobile.carparking.endpoints.base;

@FunctionalInterface
public interface IVerifiableRequestBody {

    Verified verify();

}
