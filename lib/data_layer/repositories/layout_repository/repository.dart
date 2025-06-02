// class LayoutRepository extends Singleton with Logging {
//   LayoutRepository() {
//     verbose("LayoutRepository.LayoutRepository");
//   }
//
//   @override
//   LayoutRepository init() => LayoutRepository();
//
//   TarotLayout getLayoutByLayoutName(String name) =>
//       sl<Reactives>().tarotLayoutsByName.value[name] ??
//       TarotLayout.nullLayout(displayName: "No Such Layout");
//
//   void setLayoutByLayoutName(String name) =>
//       sl<Reactives>().tarotLayout.value = getLayoutByLayoutName(name);
//
//   TarotLayout getLayoutByDisplayName(String displayName) =>
//       sl<Reactives>().layoutsByDisplayName.value[displayName] ??
//       TarotLayout.nullLayout(displayName: "No Such Layout");
//
//   void setLayoutByDisplayName(String displayName) =>
//       sl<Reactives>().tarotLayout.value = getLayoutByDisplayName(displayName);
// }
