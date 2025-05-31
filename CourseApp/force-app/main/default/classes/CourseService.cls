public with sharing class CourseService {
    @AuraEnabled(cacheable=true)
    public static List<Course__c> getCoursesWithEnrollments() {
        // Güvenlik kontrolü
        if (!Schema.sObjectType.Course__c.isAccessible()) {
            throw new System.SecurityException('Course nesnesine erişim yok.');
        }

        if (!Schema.sObjectType.Enrollment__c.isAccessible()) {
            throw new System.SecurityException('Enrollment nesnesine erişim yok.');
        }

        return [
            SELECT Id, Name, Description__c, Duration__c,
                (SELECT Id, Name, Employee__r.Name, Progress__c, Completed__c
                 FROM Enrollments__r)
            FROM Course__c
        ];
    }
}
