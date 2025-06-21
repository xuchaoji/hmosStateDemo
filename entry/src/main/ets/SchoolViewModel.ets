import { School } from "./models/School";

@ObservedV2
export class SchoolViewModel {
  static instance: SchoolViewModel;

  @Trace currentSchool: School = new School();

  @Trace currentBuildingIndex: number = 0;

  public static getInstance(): SchoolViewModel {
    if (!SchoolViewModel.instance) {
      SchoolViewModel.instance = new SchoolViewModel();
    }
    return SchoolViewModel.instance;
  }

  constructor() {
  }


}