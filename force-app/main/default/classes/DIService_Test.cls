@isTest
private class DIService_Test {
    @isTest
    private static void givenTestInterfaceAndServiceWhenReturnInstanceThenAssertService(){
        DIService.implementationsByInterfaces.put('DIService_Test.ITestService', 'DIService_Test.TestService');
        Object result;
        Test.startTest();
        try{
            result = DIService.returnInstance('DIService_Test.ITestService');
        }catch (Exception error){
            Assert.fail('An execption was thrown! '+error.getMessage());
        }
        Test.stopTest();
        Assert.areNotEqual(null, result);
        Assert.isInstanceOfType(result, DIService_Test.ITestService.class);
        Assert.isInstanceOfType(result, DIService_Test.TestService.class);
    }
    @isTest
    private static void givenInterfaceWithoutServiceWhenReturnInstanceThenAssertExceptionThrown(){
        Test.startTest();
        try{
            Object result = DIService.returnInstance('TEST');    
        }catch (DIService.DependencyInjectionException expectedException){
            Assert.isTrue(true);
        }catch (Exception unexpectedException){
            System.debug(unexpectedException);
            Assert.fail('An unexpected exception has been thrown!');
        }
        Test.stopTest();
    }
    public class TestService implements DIService_Test.ITestService{}
    public interface ITestService{}
}