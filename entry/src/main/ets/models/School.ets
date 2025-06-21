import { Building } from "./Building";
import { Type } from "@kit.ArkUI";

@ObservedV2
export class School {
  @Trace id: string = '';
  @Trace name: string = '';
  @Trace desc: string = '';
  @Type(Building)
  @Trace buildings: Building[] = [];
}