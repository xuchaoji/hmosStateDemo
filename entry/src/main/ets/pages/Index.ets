import { Building } from '../models/Building';
import { ClassRoom } from '../models/ClassRoom';
import { School } from '../models/School';
import { SchoolViewModel, SCHOOL_CACHE_KEY } from '../SchoolViewModel';
import { PersistenceV2 } from '@kit.ArkUI';
const TAG: string = `DemoIndex`
@Entry
@ComponentV2
struct Index {
  @Local message: string = 'Hello World';

  @Local viewModel: SchoolViewModel = SchoolViewModel.getInstance();


  private controller: TabsController = new TabsController();

  aboutToAppear(): void {
    if (this.viewModel.currentSchool.buildings.length === 0) {
      this.initData();
    }
  }

  async initData() {
    for (let i = 0; i < 2; i++) {
      console.log(TAG, `new building: ${i}`);
      let building: Building = new Building();
      building.id = i + '';
      building.name = `Building_${Math.floor(Math.random() * 900) + 100}`;
      building.desc = `desc_${Math.floor(Math.random() * 900) + 100}`;
      for (let j = 0; j < 1000; j++) {
        console.log(TAG, `new classRoom: ${j}`);
        let classRoom: ClassRoom = new ClassRoom();
        classRoom.id = j + '';
        classRoom.name = `Class_${Math.floor(Math.random() * 900) + 100}`;
        classRoom.desc = `desc_${Math.floor(Math.random() * 900) + 100}`;
        building.classRooms.push(classRoom);
      }
      this.viewModel.currentSchool?.buildings.push(building);
    }
  }

  build() {
    Column() {
      RelativeContainer() {
        Tabs({
          controller: this.controller
        }) {
          Repeat(this.viewModel.currentSchool?.buildings).each((repeatItem) => {
            TabContent() {
              this.buildingContent(repeatItem);
            }.tabBar(this.tabBar(repeatItem.item.name, Number(repeatItem.item.id)))
          })
        }
        .barWidth('100%')
        .barHeight('30vp')
        .barPosition(BarPosition.Start)
        .backgroundBlurStyle(BlurStyle.COMPONENT_THIN)
        .fadingEdge(true)
        .barMode(BarMode.Scrollable)
        .backgroundColor($r('sys.color.comp_background_secondary'))
        .divider({strokeWidth: '1px', color: $r('sys.color.comp_divider')})
        .onChange((index) => {this.viewModel.currentBuildingIndex = index})
      }
      .height('80%')
      .width('100%')
      Row() {
        Button('保存').type(ButtonType.Capsule).onClick((ev) => {
          PersistenceV2.save(SCHOOL_CACHE_KEY)
        })
        Button('清除').type(ButtonType.Capsule).onClick((ev) => {
          this.viewModel.currentSchool.buildings.splice(0, this.viewModel.currentSchool.buildings.length);
          PersistenceV2.save(SCHOOL_CACHE_KEY)
        })
      }
      .width('100%')
      .height('20%')
    }
      .width('100%')
      .height('100%')

  }

  @Builder
  tabBar(title: string, targetIndex: number) {
    Column() {
      Text(title)
        .fontColor(this.viewModel.currentBuildingIndex === targetIndex ?
        $r('sys.color.font_emphasize') : $r('sys.color.font_primary'))
        .fontWeight(this.viewModel.currentBuildingIndex === targetIndex ?
        FontWeight.Bold : FontWeight.Regular)
        .fontSize($r('sys.float.Caption_M'))
    }
    .width(72)
    .height(30)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  buildingContent(repeatItem: RepeatItem<Building>) {
    Column() {
      Text(repeatItem.item.name)
        .fontColor($r('sys.color.font_emphasize'))
        .fontSize($r('sys.float.Caption_L'))
      Text(repeatItem.item.desc)
        .fontColor($r('sys.color.font_primary'))
        .fontSize($r('sys.float.Caption_M'))
      Divider()
      List({space: '16vp'}) {
        Repeat(repeatItem.item.classRooms).each((repeatClass) => {
          ListItem() {
            Text(repeatClass.item.name)
              .fontColor($r('sys.color.font_primary'))
              .fontSize($r('sys.float.Caption_M'))
          }
        })
      }
      .margin({top: '16vp'})
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }
}