import { Building } from '../models/Building';
import { School } from '../models/School';
import { SchoolViewModel } from '../SchoolViewModel';

@Entry
@ComponentV2
struct Index {
  @Local message: string = 'Hello World';

  @Local viewModel: SchoolViewModel = SchoolViewModel.getInstance();

  private controller: TabsController = new TabsController();

  aboutToAppear(): void {
    for (let i = 0; i < 100; i++) {
      let building: Building = new Building(i + '', `Name_${Number(Math.random().toPrecision(2)) * 100}`, `Desc_${Number(Math.random().toPrecision(2)) * 100}`);
      this.viewModel.currentSchool.buildings.push(building);
    }
  }

  build() {
    RelativeContainer() {
      Tabs({
        controller: this.controller
      }) {
        Repeat(this.viewModel.currentSchool.buildings).each((repeatItem) => {
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
    .height('100%')
    .width('100%')
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
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }
}