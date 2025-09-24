import sys, os.path, cairosvg

if len(sys.argv) not in [ 3, 4 ]:
  print('two args must be specified: input and output file paths')
  exit(1)

input_file, output_file = sys.argv[1], sys.argv[2]
if not os.path.isfile(input_file):
  print(f'no such file `{input_file}`')
  exit(1)

try:
  size = sys.argv[3]
except Exception as ex:
  size = 256

cairosvg.svg2png(
  url=input_file,
  write_to=output_file,
  output_width=size, output_height=size, 
)
print(f"""
successfully converted
`{input_file}` into `{output_file}`
with size `{size}`
""")
