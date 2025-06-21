import { ClassRoom } from "./ClassRoom";

@ObservedV2
export class Building {
  @Trace id: string = '';
  @Trace name: string = '';
  @Trace desc: string = '';
  @Trace classRooms: ClassRoom[] = [];
}