import { LightningElement, wire } from 'lwc';
import getCoursesWithEnrollments from '@salesforce/apex/CourseService.getCoursesWithEnrollments';

export default class CourseList extends LightningElement {
  courses;
  error;

  @wire(getCoursesWithEnrollments)
  wiredCourses({ error, data }) {
    if (data) {
      this.courses = data;
      this.error = undefined;
    } else if (error) {
      this.error = 'Veri alınamadı: ' + error.body.message;
      this.courses = undefined;
    }
  }
}
