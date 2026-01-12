#import "./template/resume_temp.typ": resume
#let data = json("input/data.json")

#resume(data)
