import { Building } from '../models/Building';
import { School } from '../models/School';
import { SchoolViewModel } from '../SchoolViewModel';

@Entry
@ComponentV2
struct Index {
  @Local message: string = 'Hello World';
  @Local school: School = new School();

  @Local viewModel: SchoolViewModel = SchoolViewModel.getInstance();

  private controller: TabsController = new TabsController();

  aboutToAppear(): void {

  }

  build() {
    RelativeContainer() {
      Tabs({
        controller: this.controller
      }) {

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
  buildingContent(building: Building) {
    Column() {

    }
    .width('100%')
    .height('100%')
  }
}