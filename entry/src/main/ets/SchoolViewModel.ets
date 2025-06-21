import { School } from "./models/School";
import { PersistenceV2, Type } from "@kit.ArkUI";

export const SCHOOL_CACHE_KEY: string = 'school_cache'

@ObservedV2
export class SchoolViewModel {
  static instance: SchoolViewModel;

  @Type(School)
  @Trace currentSchool: School;

  @Trace currentBuildingIndex: number = 0;

  public static getInstance(): SchoolViewModel {
    if (!SchoolViewModel.instance) {
      SchoolViewModel.instance = new SchoolViewModel();
    }
    return SchoolViewModel.instance;
  }

  constructor() {
    this.currentSchool = PersistenceV2.connect(School, SCHOOL_CACHE_KEY, ()=> new School())!;
  }

}