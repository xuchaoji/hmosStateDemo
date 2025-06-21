import { Building } from "./Building";

@ObservedV2
export class School {
  @Trace id: string = '';
  @Trace name: string = '';
  @Trace desc: string = '';
  @Trace buildings: Building[] = [];
}