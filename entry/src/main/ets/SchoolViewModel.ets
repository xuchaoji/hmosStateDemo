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
    let start: number = Date.now();
    this.currentSchool = PersistenceV2.connect(School, SCHOOL_CACHE_KEY, ()=> new School())!;
    console.log(`DemoIndex`, `readCache end: cost: ${Date.now() - start} ms`)
  }

}