#import "template.typ":  *
#import "@preview/modern-nju-thesis:0.3.4": bilingual-bibliography
#show: ifacconf-rules
#show: ifacconf.with(
  title: "基于视觉的三维重建方法综述",//标题
  title_en:"A Comprehensive Review of Vision-Based 3D Methods",//英文标题

  authors: (
    (
      name: "123",
      email: "xiao@bupt.edu.cn",
      affiliation: 1,
    ),
  ),//中文作者

    authors_en: (
    (
      name: "123",
      email: "123@bupt.edu.cn",
      affiliation: 1,
    ),
  ),//英文作者

  affiliations: (
    (
      organization: "北京邮电大学信息与通信工程学院",
      address: "北京市海淀区西土城路10号",
    ),
  ),

    affiliations_en: (
    (
      organization: "School of Information and Communication Engineering, Beijing University of Posts and Telecommunications",
      address: "No. 10 Xitucheng Road, Haidian District, Beijing",
    ),
  ),

  
  abstract: [
    随着三维重建技术的快速发展，特
  ],
  keywords: ("NeRF","3DGS","静态三维重建","动态三维重建","深度学习"),


  abstract_en: [
    With the rap
  ],
  keywords_en: ("NeRF", "3DGS", "static 3D reconstruction", "dynamic 3D reconstruction", "deep learning"),

  sponsor: [/*不填*/],
)
#h(2em)
视觉能力作为人类最重要的感知能力之一，使得我们能够识别和与三维物理世界交互。将三维场景数字化并在计算机中构建，已成为当今许多重要应用的基础。这种技术的重要性可从日益增长的相关研究论文数量中看出，这些论文在国际知名会议和期刊中广泛发表，表明了该领域研究的活跃程度。三维重建技术在多个领域中发挥了重要作用，例如文物保护、文化遗产的复制等，可以避免传统石膏铸模技术的侵入性，同时保护珍贵或精细的文物。

在娱乐产业中，动态三维场景重建可以用于游戏和电影的实时渲染，显著提升用户体验。在医学领域，三维重建技术用于构建基于患者的器官模型，为手术规划提供支持。此外，在机器人导航领域，动态三维场景重建使机器人能够更好地理解其周围环境，提高导航的准确性和安全性。工业设计领域则通过捕捉真实物体的三维几何信息，协助创建精确的数字模型，用于设计和定制个性化产品，同时为设备维护提供数字基础。

与传统基于CAD或数字内容创建软件的人工建模方法不同，三维重建技术从传感器输入（如图像、点云等）开始，无需人工干预即可自动重建三维结构和场景。这种自动化流程的发展可以追溯到19世纪末德国科学家阿尔布雷希特·梅登堡（Albrecht Meydenbauer）和卡尔·普尔弗里希（Carl Pulfrich）对影像测量学的贡献，以及20世纪60年代MIT的Roberts关于从数字图像中提取立体几何结构的研究。这些先驱性的研究奠定了三维重建领域的基础。

三维重建技术可以根据表达方法分为显式表达和隐式表达。显式表达明确定义几何形状和结构，用于直接描述物体的外部或内部几何，但通常需要离散化处理，导致一定的信息丢失。隐式表达则通过函数描述几何，适合处理复杂的几何结构，同时在存储效率上具有优势。两种方法经常结合使用，以综合利用各自的优点，从而提升三维模型的建模和分析能力。

接下来的内容将从静态、动态三维重建方法两个方面展开，探讨技术细节及其应用场景，并分析其挑战与未来趋势。


#figure(
  image("figures/1.png"),
  caption: "激光扫描的三维重建过程"
)


算法优化、实时性能提升的硬件加速方案，以及多模态数据融合的最新进展，均是当前三维重建领域的热点方向。此外，结合实际应用需求优化现有技术，在鲁棒性和高效性之间取得平衡，将是未来研究的关键。

@nyatsanga_comprehensive_2023

#bilingual-bibliography(bibliography: bibliography.with("CG1.bib"))

/*附录
#appendix("123",

1
)

*/

