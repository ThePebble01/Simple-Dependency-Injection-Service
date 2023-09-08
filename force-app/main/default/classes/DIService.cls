public without sharing class DIService {
    @testVisible
    private static Map<String, String> implementationsByInterfaces{
        get{
            if(implementationsByInterfaces == null){
                implementationsByInterfaces = new Map<String, String>();
                for(DI_Binding__mdt diBinding : [SELECT ID, Interface__c, Service__c FROM DI_Binding__mdt]){
                    implementationsByInterfaces.put(diBinding.Interface__c, diBinding.Service__c);
                }
            }
            return implementationsByInterfaces;
        }
        set;
    }
    public static Object returnInstance(String requestedInterface){
        Object service;
        String serviceToInstantiate = returnServiceFromDIBindings(requestedInterface);
         if(serviceToInstantiate != null){
            service = Type.forName(serviceToInstantiate).newInstance();
         }
        return service;
    }
    @testVisible
    private static String returnServiceFromDIBindings(String requestedInterface){
        if(implementationsByInterfaces?.containsKey(requestedInterface)){
            return implementationsByInterfaces?.get(requestedInterface);
        }else{
            throw new DependencyInjectionException();
        }
    }
    @testVisible
    private class DependencyInjectionException extends Exception{}
}
