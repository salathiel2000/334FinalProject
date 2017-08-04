# Import file "finalMockups"
sketch = Framer.Importer.load("imported/finalMockups@1x", scale: 1)

Utils.globalLayers sketch

flow = new FlowComponent
flow.showNext(onboarding_main)

