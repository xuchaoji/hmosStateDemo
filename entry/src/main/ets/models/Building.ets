import { ClassRoom } from "./ClassRoom";
import { Type } from "@kit.ArkUI";

@ObservedV2
export class Building {
  @Trace id: string = '';
  @Trace name: string = '';
  @Trace desc: string = '';
  @Type(ClassRoom)
  @Trace classRooms: ClassRoom[] = [];
}