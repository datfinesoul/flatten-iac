import * as hcl from "hcl2-parser"

import { readFile } from "fs/promises"

const json = JSON.parse(await readFile('planned.tf.json', 'utf8'))

console.log(json)

for (const [moduleName, moduleValue] of Object.entries(json)) {
  const { resources } = moduleValue
  console.log(resources)
}

