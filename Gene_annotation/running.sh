/home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/Augustus/scripts/bamToWig.py -b /home/kang1234/genome/Gene_annotation/braker_4/merged.s.bam -g /home/kang1234/genome/Gene_annotation/braker_4/genome.fa -o /home/kang1234/genome/Gene_annotation/braker_4/merged.wig 2> /home/kang1234/genome/Gene_annotation/braker_4/errors/bamToWig.err
cat /home/kang1234/genome/Gene_annotation/braker_4/merged.wig | perl /home/kang1234/software/Augustus/scripts/wig2hints.pl --margin=10 --minthresh=2 --minscore=4 --prune=0.1 --src=W --type=ep --UCSC=/home/kang1234/genome/Gene_annotation/braker_4/unstranded.track --radius=4.5 --pri=4 --strand="." > /home/kang1234/genome/Gene_annotation/braker_4/ep.hints 2> /home/kang1234/genome/Gene_annotation/braker_4/errors/wig2hints.err
cat /home/kang1234/genome/Gene_annotation/braker_4/ep.hints >> /home/kang1234/genome/Gene_annotation/braker_4/hintsfile.gff 2> /home/kang1234/genome/Gene_annotation/braker_4/errors/cat_exonpart_to_hintsfile.err
#**********************************************************************************
#                               PREDICTING GENES WITH AUGUSTUS (UTRS)              
#**********************************************************************************
cd /home/kang1234/genome/Gene_annotation/braker_4
perl /home/kang1234/software/Augustus/scripts/createAugustusJoblist.pl --sequences=/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio.lst --wrap="#!/bin/bash" --overlap=5000 --chunksize=2500000 --outputdir=/home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr --joblist=/home/kang1234/genome/Gene_annotation/braker_4/ab_initio_utr.job.lst --jobprefix=aug_ab_initio_ --command "/home/kang1234/software/Augustus/bin/augustus --species=Labroides_dimidiatus_5 --AUGUSTUS_CONFIG_PATH=/home/kang1234/software/Augustus/config --UTR=on  --exonnames=on --codingseq=on  --softmasking=1" 2>/home/kang1234/genome/Gene_annotation/braker_4/errors/createAugustusJoblist_ab_initio_utr.stderr
cd ..
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_1
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_2
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_3
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_5
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_6
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_7
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_8
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_9
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_10
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_11
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_12
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_13
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_14
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_15
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_16
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_17
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_18
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_19
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_20
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_21
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_22
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_23
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_24
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_25
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_26
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_27
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_28
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_29
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_30
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_31
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_32
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_33
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_34
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_35
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_36
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_37
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_38
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_39
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_40
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_41
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_42
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_43
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_44
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_45
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_46
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_47
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_48
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_49
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_50
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_51
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_52
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_53
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_54
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_55
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_56
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_57
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_58
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_59
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_60
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_61
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_62
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_63
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_64
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_65
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_66
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_67
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_68
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_69
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_70
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_71
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_72
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_73
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_74
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_75
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_76
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_77
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_78
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_79
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_80
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_81
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_82
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_83
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_84
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_85
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_86
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_87
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_88
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_89
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_90
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_91
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_92
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_93
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_94
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_95
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_96
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_97
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_98
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_99
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_100
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_101
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_102
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_103
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_104
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_105
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_106
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_107
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_108
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_109
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_110
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_111
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_112
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_113
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_114
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_115
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_116
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_117
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_118
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_119
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_120
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_121
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_122
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_123
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_124
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_125
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_126
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_127
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_128
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_129
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_130
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_131
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_132
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_133
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_134
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_135
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_136
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_137
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_138
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_139
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_140
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_141
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_142
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_143
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_144
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_145
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_146
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_147
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_148
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_149
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_150
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_151
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_152
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_153
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_154
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_155
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_156
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_157
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_158
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_159
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_160
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_161
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_162
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_163
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_164
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_165
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_166
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_167
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_168
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_169
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_170
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_171
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_172
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_173
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_174
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_175
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_176
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_177
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_178
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_179
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_180
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_181
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_182
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_183
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_184
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_185
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_186
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_187
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_188
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_189
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_190
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_191
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_192
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_193
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_194
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_195
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_196
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_197
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_198
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_199
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_200
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_201
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_202
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_203
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_204
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_205
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_206
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_207
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_208
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_209
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_210
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_211
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_212
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_213
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_214
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_215
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_216
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_217
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_218
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_219
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_220
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_221
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_222
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_223
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_224
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_225
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_226
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_227
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_228
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_229
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_230
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_231
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_232
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_233
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_234
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_235
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_236
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_237
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_238
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_239
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_240
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_241
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_242
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_243
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_244
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_245
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_246
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_247
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_248
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_249
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_250
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_251
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_252
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_253
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_254
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_255
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_256
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_257
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_258
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_259
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_260
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_261
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_262
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_263
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_264
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_265
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_266
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_267
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_268
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_269
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_270
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_271
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_272
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_273
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_274
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_275
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_276
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_277
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_278
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_279
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_280
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_281
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_282
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_283
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_284
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_285
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_286
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_287
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_288
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_289
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_290
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_291
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_292
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_293
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_294
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_295
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_296
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_297
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_298
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_299
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_300
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_301
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_302
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_303
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_304
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_305
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_306
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_307
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_308
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_309
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_310
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_311
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_312
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_313
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_314
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_315
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_316
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_317
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_318
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_319
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_320
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_321
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_322
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_323
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_324
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_325
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_326
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_327
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_328
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_329
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_330
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_331
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_332
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_333
/home/kang1234/genome/Gene_annotation/braker_4/aug_ab_initio_334
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/29.001.Scx22uW_45.fa.1..34031.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/3.001.Scx22uW_39.fa.1..48957.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/22.001.Scx22uW_56.fa.1..14875.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.001.Scx22uW_22.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.002.Scx22uW_22.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.003.Scx22uW_22.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.004.Scx22uW_22.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.005.Scx22uW_22.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.006.Scx22uW_22.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.007.Scx22uW_22.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.008.Scx22uW_22.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.009.Scx22uW_22.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.010.Scx22uW_22.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/36.011.Scx22uW_22.fa.24950001..26281198.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/9.001.Scx22uW_55.fa.1..24980.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.001.Scx22uW_3.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.002.Scx22uW_3.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.003.Scx22uW_3.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.004.Scx22uW_3.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.005.Scx22uW_3.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.006.Scx22uW_3.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.007.Scx22uW_3.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.008.Scx22uW_3.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.009.Scx22uW_3.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.010.Scx22uW_3.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.011.Scx22uW_3.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.012.Scx22uW_3.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.013.Scx22uW_3.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/34.014.Scx22uW_3.fa.32435001..34671299.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/13.001.Scx22uW_16.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/13.002.Scx22uW_16.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/13.003.Scx22uW_16.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/13.004.Scx22uW_16.fa.7485001..9034515.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/20.001.Scx22uW_46.fa.1..65043.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/45.001.Scx22uW_23.fa.1..481081.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/28.001.Scx22uW_54.fa.1..19076.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/10.001.Scx22uW_44.fa.1..25000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.001.Scx22uW_33.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.002.Scx22uW_33.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.003.Scx22uW_33.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.004.Scx22uW_33.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.005.Scx22uW_33.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.006.Scx22uW_33.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.007.Scx22uW_33.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.008.Scx22uW_33.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.009.Scx22uW_33.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.010.Scx22uW_33.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.011.Scx22uW_33.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.012.Scx22uW_33.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.013.Scx22uW_33.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.014.Scx22uW_33.fa.32435001..34935000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.015.Scx22uW_33.fa.34930001..37430000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/57.016.Scx22uW_33.fa.37425001..38942715.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.001.Scx22uW_17.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.002.Scx22uW_17.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.003.Scx22uW_17.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.004.Scx22uW_17.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.005.Scx22uW_17.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.006.Scx22uW_17.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.007.Scx22uW_17.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.008.Scx22uW_17.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.009.Scx22uW_17.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.010.Scx22uW_17.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.011.Scx22uW_17.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.012.Scx22uW_17.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.013.Scx22uW_17.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/4.014.Scx22uW_17.fa.32435001..32910995.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/37.001.Scx22uW_8.fa.1..287854.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.001.Scx22uW_4.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.002.Scx22uW_4.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.003.Scx22uW_4.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.004.Scx22uW_4.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.005.Scx22uW_4.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.006.Scx22uW_4.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.007.Scx22uW_4.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.008.Scx22uW_4.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.009.Scx22uW_4.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.010.Scx22uW_4.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.011.Scx22uW_4.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.012.Scx22uW_4.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/53.013.Scx22uW_4.fa.29940001..29993208.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/43.001.Scx22uW_38.fa.1..36416.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/41.001.Scx22uW_24.fa.1..257049.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.001.Scx22uW_31.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.002.Scx22uW_31.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.003.Scx22uW_31.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.004.Scx22uW_31.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.005.Scx22uW_31.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.006.Scx22uW_31.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.007.Scx22uW_31.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.008.Scx22uW_31.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.009.Scx22uW_31.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.010.Scx22uW_31.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.011.Scx22uW_31.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.012.Scx22uW_31.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.013.Scx22uW_31.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/38.014.Scx22uW_31.fa.32435001..33849204.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.001.Scx22uW_47.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.002.Scx22uW_47.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.003.Scx22uW_47.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.004.Scx22uW_47.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.005.Scx22uW_47.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.006.Scx22uW_47.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.007.Scx22uW_47.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.008.Scx22uW_47.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.009.Scx22uW_47.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.010.Scx22uW_47.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.011.Scx22uW_47.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.012.Scx22uW_47.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.013.Scx22uW_47.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.014.Scx22uW_47.fa.32435001..34935000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.015.Scx22uW_47.fa.34930001..37430000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/7.016.Scx22uW_47.fa.37425001..37806931.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/51.001.Scx22uW_6.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/51.002.Scx22uW_6.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/51.003.Scx22uW_6.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/51.004.Scx22uW_6.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/51.005.Scx22uW_6.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/51.006.Scx22uW_6.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/51.007.Scx22uW_6.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/51.008.Scx22uW_6.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/51.009.Scx22uW_6.fa.19960001..20319096.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/25.001.Scx22uW_51.fa.1..22216.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/5.001.Scx22uW_1.fa.1..196302.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/56.001.Scx22uW_29.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/56.002.Scx22uW_29.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/56.003.Scx22uW_29.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/56.004.Scx22uW_29.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/56.005.Scx22uW_29.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/56.006.Scx22uW_29.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/56.007.Scx22uW_29.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/56.008.Scx22uW_29.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/56.009.Scx22uW_29.fa.19960001..22317280.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/32.001.Scx22uW_7.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/32.002.Scx22uW_7.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/32.003.Scx22uW_7.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/32.004.Scx22uW_7.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/32.005.Scx22uW_7.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/32.006.Scx22uW_7.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/32.007.Scx22uW_7.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/32.008.Scx22uW_7.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/32.009.Scx22uW_7.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/32.010.Scx22uW_7.fa.22455001..22631291.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.001.Scx22uW_15.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.002.Scx22uW_15.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.003.Scx22uW_15.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.004.Scx22uW_15.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.005.Scx22uW_15.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.006.Scx22uW_15.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.007.Scx22uW_15.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.008.Scx22uW_15.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.009.Scx22uW_15.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.010.Scx22uW_15.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.011.Scx22uW_15.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.012.Scx22uW_15.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.013.Scx22uW_15.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/6.014.Scx22uW_15.fa.32435001..33590197.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/27.001.Scx22uW_42.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/27.002.Scx22uW_42.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/27.003.Scx22uW_42.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/27.004.Scx22uW_42.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/27.005.Scx22uW_42.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/27.006.Scx22uW_42.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/27.007.Scx22uW_42.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/27.008.Scx22uW_42.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/27.009.Scx22uW_42.fa.19960001..21630436.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/18.001.Scx22uW_14.fa.1..133904.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/33.001.Scx22uW_49.fa.1..26599.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/24.001.Scx22uW_52.fa.1..27141.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/14.001.Scx22uW_35.fa.1..25848.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/11.001.Scx22uW_37.fa.1..140339.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.001.Scx22uW_34.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.002.Scx22uW_34.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.003.Scx22uW_34.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.004.Scx22uW_34.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.005.Scx22uW_34.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.006.Scx22uW_34.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.007.Scx22uW_34.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.008.Scx22uW_34.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.009.Scx22uW_34.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.010.Scx22uW_34.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.011.Scx22uW_34.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.012.Scx22uW_34.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.013.Scx22uW_34.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.014.Scx22uW_34.fa.32435001..34935000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.015.Scx22uW_34.fa.34930001..37430000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/19.016.Scx22uW_34.fa.37425001..37698886.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.001.Scx22uW_5.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.002.Scx22uW_5.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.003.Scx22uW_5.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.004.Scx22uW_5.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.005.Scx22uW_5.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.006.Scx22uW_5.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.007.Scx22uW_5.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.008.Scx22uW_5.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.009.Scx22uW_5.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.010.Scx22uW_5.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.011.Scx22uW_5.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.012.Scx22uW_5.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.013.Scx22uW_5.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/8.014.Scx22uW_5.fa.32435001..34837406.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.001.Scx22uW_28.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.002.Scx22uW_28.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.003.Scx22uW_28.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.004.Scx22uW_28.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.005.Scx22uW_28.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.006.Scx22uW_28.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.007.Scx22uW_28.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.008.Scx22uW_28.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.009.Scx22uW_28.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.010.Scx22uW_28.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.011.Scx22uW_28.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.012.Scx22uW_28.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/1.013.Scx22uW_28.fa.29940001..32000296.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.001.Scx22uW_2.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.002.Scx22uW_2.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.003.Scx22uW_2.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.004.Scx22uW_2.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.005.Scx22uW_2.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.006.Scx22uW_2.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.007.Scx22uW_2.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.008.Scx22uW_2.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.009.Scx22uW_2.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.010.Scx22uW_2.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/31.011.Scx22uW_2.fa.24950001..26865403.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.001.Scx22uW_19.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.002.Scx22uW_19.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.003.Scx22uW_19.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.004.Scx22uW_19.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.005.Scx22uW_19.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.006.Scx22uW_19.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.007.Scx22uW_19.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.008.Scx22uW_19.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.009.Scx22uW_19.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.010.Scx22uW_19.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.011.Scx22uW_19.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/47.012.Scx22uW_19.fa.27445001..29942532.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.001.Scx22uW_10.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.002.Scx22uW_10.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.003.Scx22uW_10.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.004.Scx22uW_10.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.005.Scx22uW_10.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.006.Scx22uW_10.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.007.Scx22uW_10.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.008.Scx22uW_10.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.009.Scx22uW_10.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.010.Scx22uW_10.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.011.Scx22uW_10.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/42.012.Scx22uW_10.fa.27445001..29873134.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/49.001.Scx22uW_50.fa.1..22977.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/26.001.Scx22uW_43.fa.1..23818.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/35.001.Scx22uW_30.fa.1..25059.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/12.001.Scx22uW_41.fa.1..126321.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.001.Scx22uW_32.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.002.Scx22uW_32.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.003.Scx22uW_32.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.004.Scx22uW_32.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.005.Scx22uW_32.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.006.Scx22uW_32.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.007.Scx22uW_32.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.008.Scx22uW_32.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.009.Scx22uW_32.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.010.Scx22uW_32.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.011.Scx22uW_32.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.012.Scx22uW_32.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/50.013.Scx22uW_32.fa.29940001..30138231.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.001.Scx22uW_12.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.002.Scx22uW_12.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.003.Scx22uW_12.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.004.Scx22uW_12.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.005.Scx22uW_12.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.006.Scx22uW_12.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.007.Scx22uW_12.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.008.Scx22uW_12.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.009.Scx22uW_12.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.010.Scx22uW_12.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.011.Scx22uW_12.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.012.Scx22uW_12.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.013.Scx22uW_12.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/44.014.Scx22uW_12.fa.32435001..33898938.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/40.001.Scx22uW_21.fa.1..241660.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/52.001.Scx22uW_53.fa.1..25992.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/55.001.Scx22uW_40.fa.1..39990.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/21.001.Scx22uW_27.fa.1..18132.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/2.001.Scx22uW_18.fa.1..1128361.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.001.Scx22uW_11.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.002.Scx22uW_11.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.003.Scx22uW_11.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.004.Scx22uW_11.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.005.Scx22uW_11.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.006.Scx22uW_11.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.007.Scx22uW_11.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.008.Scx22uW_11.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.009.Scx22uW_11.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.010.Scx22uW_11.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.011.Scx22uW_11.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.012.Scx22uW_11.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.013.Scx22uW_11.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/54.014.Scx22uW_11.fa.32435001..34615709.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/15.001.Scx22uW_57.fa.1..15336.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/39.001.Scx22uW_25.fa.1..132850.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/30.001.Scx22uW_36.fa.1..33945.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/48.001.Scx22uW_48.fa.1..35746.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.001.Scx22uW_20.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.002.Scx22uW_20.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.003.Scx22uW_20.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.004.Scx22uW_20.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.005.Scx22uW_20.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.006.Scx22uW_20.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.007.Scx22uW_20.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.008.Scx22uW_20.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.009.Scx22uW_20.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.010.Scx22uW_20.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.011.Scx22uW_20.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.012.Scx22uW_20.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.013.Scx22uW_20.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.014.Scx22uW_20.fa.32435001..34935000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/16.015.Scx22uW_20.fa.34930001..35083332.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.001.Scx22uW_9.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.002.Scx22uW_9.fa.2495001..4995000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.003.Scx22uW_9.fa.4990001..7490000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.004.Scx22uW_9.fa.7485001..9985000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.005.Scx22uW_9.fa.9980001..12480000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.006.Scx22uW_9.fa.12475001..14975000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.007.Scx22uW_9.fa.14970001..17470000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.008.Scx22uW_9.fa.17465001..19965000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.009.Scx22uW_9.fa.19960001..22460000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.010.Scx22uW_9.fa.22455001..24955000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.011.Scx22uW_9.fa.24950001..27450000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.012.Scx22uW_9.fa.27445001..29945000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.013.Scx22uW_9.fa.29940001..32440000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/46.014.Scx22uW_9.fa.32435001..33588937.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/23.001.Scx22uW_26.fa.1..23658.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_ab_initio_tmp_utr/17.001.Scx22uW_13.fa.1..100469.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
perl /home/kang1234/software/Augustus/scripts/join_aug_pred.pl < /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff > /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr.gff | perl -ne 'if(m/\tAUGUSTUS\t/) {print $_;}' | perl /home/kang1234/software/Augustus/scripts/gtf2gff.pl --printExon --out=/home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr.tmp.gtf 2>/home/kang1234/genome/Gene_annotation/braker_4/errors/gtf2gff.augustus.ab_initio_utr.gtf.stderr
/home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/Augustus/scripts/getAnnoFastaFromJoingenes.py -g /home/kang1234/genome/Gene_annotation/braker_4/genome.fa -f /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr.gtf -o /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr 1> /home/kang1234/genome/Gene_annotation/braker_4/getAnnoFastaFromJoingenes.augustus.ab_initio_utr__utrtmp.stdout 2>/home/kang1234/genome/Gene_annotation/braker_4/errors/getAnnoFastaFromJoingenes.augustus.ab_initio_utr__utrtmp.stderr
/home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/Augustus/scripts/fix_in_frame_stop_codon_genes.py -g /home/kang1234/genome/Gene_annotation/braker_4/genome.fa -t /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr.gtf -b /home/kang1234/genome/Gene_annotation/braker_4/bad_genes.lst -o augustus.ab_initio_utr_fix_ifs_ -s Labroides_dimidiatus_5 -m on --UTR on --print_utr on -a /home/kang1234/software/Augustus/config -C /usr/bin -A /home/kang1234/software/Augustus/bin -S /home/kang1234/software/Augustus/scripts  > /home/kang1234/genome/Gene_annotation/braker_4/fix_in_frame_stop_codon_genes_augustus.ab_initio_utr.log 2> /home/kang1234/genome/Gene_annotation/braker_4/errors/fix_in_frame_stop_codon_genes_augustus.ab_initio_utr.err
mv /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr_fix_ifs_.gtf /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr.gtf
rm /home/kang1234/genome/Gene_annotation/braker_4/bad_genes.lst
/home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/Augustus/scripts/getAnnoFastaFromJoingenes.py -g /home/kang1234/genome/Gene_annotation/braker_4/genome.fa -f /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr.gtf -o /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr 1> /home/kang1234/genome/Gene_annotation/braker_4/getAnnoFastaFromJoingenes.augustus.ab_initio_utr__utr.stdout 2>/home/kang1234/genome/Gene_annotation/braker_4/errors/getAnnoFastaFromJoingenes.augustus.ab_initio_utr__utr.stderr
cp /home/kang1234/software/BRAKER/scripts/cfg/rnaseq_utr.cfg /home/kang1234/genome/Gene_annotation/braker_4/species/Labroides_dimidiatus_5/ex1_utr.cfg
cd /home/kang1234/genome/Gene_annotation/braker_4
perl /home/kang1234/software/Augustus/scripts/createAugustusJoblist.pl --sequences=/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr.lst --wrap="#!/bin/bash" --overlap=500000 --chunksize=2500000 --outputdir=/home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr --joblist=/home/kang1234/genome/Gene_annotation/braker_4/hints_utr.job.lst --jobprefix=aug_hints_utr_ --partitionHints --command "/home/kang1234/software/Augustus/bin/augustus --species=Labroides_dimidiatus_5 --AUGUSTUS_CONFIG_PATH=/home/kang1234/software/Augustus/config --extrinsicCfgFile=/home/kang1234/software/BRAKER/scripts/cfg/rnaseq_utr.cfg --alternatives-from-evidence=true --UTR=on --exonnames=on --codingseq=on --allow_hinted_splicesites=gcag,atac  --softmasking=1" 2>/home/kang1234/genome/Gene_annotation/braker_4/errors/createAugustusJoblist_hints_utr.stderr
cd ..
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_1
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_2
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_3
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_4
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_5
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_6
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_7
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_8
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_9
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_10
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_11
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_12
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_13
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_14
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_15
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_16
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_17
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_18
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_19
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_20
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_21
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_22
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_23
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_24
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_25
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_26
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_27
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_28
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_29
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_30
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_31
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_32
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_33
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_34
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_35
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_36
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_37
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_38
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_39
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_40
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_41
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_42
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_43
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_44
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_45
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_46
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_47
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_48
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_49
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_50
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_51
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_52
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_53
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_54
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_55
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_56
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_57
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_58
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_59
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_60
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_61
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_62
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_63
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_64
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_65
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_66
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_67
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_68
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_69
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_70
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_71
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_72
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_73
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_74
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_75
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_76
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_77
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_78
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_79
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_80
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_81
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_82
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_83
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_84
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_85
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_86
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_87
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_88
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_89
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_90
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_91
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_92
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_93
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_94
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_95
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_96
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_97
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_98
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_99
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_100
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_101
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_102
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_103
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_104
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_105
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_106
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_107
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_108
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_109
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_110
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_111
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_112
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_113
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_114
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_115
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_116
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_117
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_118
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_119
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_120
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_121
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_122
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_123
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_124
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_125
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_126
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_127
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_128
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_129
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_130
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_131
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_132
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_133
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_134
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_135
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_136
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_137
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_138
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_139
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_140
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_141
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_142
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_143
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_144
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_145
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_146
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_147
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_148
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_149
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_150
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_151
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_152
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_153
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_154
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_155
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_156
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_157
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_158
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_159
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_160
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_161
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_162
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_163
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_164
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_165
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_166
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_167
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_168
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_169
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_170
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_171
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_172
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_173
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_174
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_175
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_176
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_177
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_178
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_179
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_180
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_181
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_182
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_183
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_184
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_185
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_186
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_187
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_188
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_189
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_190
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_191
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_192
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_193
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_194
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_195
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_196
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_197
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_198
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_199
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_200
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_201
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_202
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_203
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_204
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_205
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_206
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_207
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_208
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_209
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_210
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_211
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_212
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_213
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_214
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_215
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_216
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_217
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_218
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_219
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_220
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_221
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_222
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_223
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_224
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_225
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_226
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_227
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_228
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_229
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_230
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_231
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_232
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_233
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_234
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_235
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_236
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_237
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_238
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_239
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_240
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_241
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_242
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_243
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_244
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_245
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_246
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_247
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_248
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_249
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_250
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_251
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_252
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_253
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_254
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_255
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_256
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_257
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_258
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_259
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_260
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_261
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_262
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_263
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_264
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_265
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_266
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_267
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_268
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_269
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_270
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_271
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_272
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_273
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_274
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_275
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_276
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_277
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_278
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_279
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_280
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_281
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_282
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_283
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_284
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_285
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_286
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_287
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_288
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_289
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_290
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_291
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_292
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_293
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_294
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_295
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_296
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_297
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_298
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_299
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_300
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_301
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_302
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_303
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_304
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_305
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_306
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_307
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_308
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_309
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_310
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_311
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_312
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_313
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_314
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_315
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_316
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_317
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_318
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_319
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_320
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_321
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_322
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_323
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_324
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_325
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_326
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_327
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_328
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_329
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_330
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_331
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_332
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_333
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_334
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_335
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_336
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_337
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_338
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_339
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_340
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_341
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_342
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_343
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_344
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_345
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_346
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_347
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_348
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_349
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_350
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_351
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_352
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_353
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_354
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_355
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_356
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_357
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_358
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_359
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_360
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_361
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_362
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_363
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_364
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_365
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_366
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_367
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_368
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_369
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_370
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_371
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_372
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_373
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_374
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_375
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_376
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_377
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_378
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_379
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_380
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_381
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_382
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_383
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_384
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_385
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_386
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_387
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_388
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_389
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_390
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_391
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_392
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_393
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_394
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_395
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_396
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_397
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_398
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_399
/home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_400
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/22.001.Scx22uW_56.fa.1..14875.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/3.001.Scx22uW_39.fa.1..48957.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/29.001.Scx22uW_45.fa.1..34031.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.001.Scx22uW_33.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.002.Scx22uW_33.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.003.Scx22uW_33.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.004.Scx22uW_33.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.005.Scx22uW_33.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.006.Scx22uW_33.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.007.Scx22uW_33.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.008.Scx22uW_33.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.009.Scx22uW_33.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.010.Scx22uW_33.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.011.Scx22uW_33.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.012.Scx22uW_33.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.013.Scx22uW_33.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.014.Scx22uW_33.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.015.Scx22uW_33.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.016.Scx22uW_33.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.017.Scx22uW_33.fa.32000001..34500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.018.Scx22uW_33.fa.34000001..36500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.019.Scx22uW_33.fa.36000001..38500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/57.020.Scx22uW_33.fa.38000001..38942715.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/10.001.Scx22uW_44.fa.1..25000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/28.001.Scx22uW_54.fa.1..19076.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/45.001.Scx22uW_23.fa.1..481081.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/20.001.Scx22uW_46.fa.1..65043.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/13.001.Scx22uW_16.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/13.002.Scx22uW_16.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/13.003.Scx22uW_16.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/13.004.Scx22uW_16.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/13.005.Scx22uW_16.fa.8000001..9034515.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.001.Scx22uW_3.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.002.Scx22uW_3.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.003.Scx22uW_3.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.004.Scx22uW_3.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.005.Scx22uW_3.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.006.Scx22uW_3.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.007.Scx22uW_3.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.008.Scx22uW_3.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.009.Scx22uW_3.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.010.Scx22uW_3.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.011.Scx22uW_3.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.012.Scx22uW_3.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.013.Scx22uW_3.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.014.Scx22uW_3.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.015.Scx22uW_3.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.016.Scx22uW_3.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.017.Scx22uW_3.fa.32000001..34500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/34.018.Scx22uW_3.fa.34000001..34671299.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/9.001.Scx22uW_55.fa.1..24980.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.001.Scx22uW_22.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.002.Scx22uW_22.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.003.Scx22uW_22.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.004.Scx22uW_22.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.005.Scx22uW_22.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.006.Scx22uW_22.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.007.Scx22uW_22.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.008.Scx22uW_22.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.009.Scx22uW_22.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.010.Scx22uW_22.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.011.Scx22uW_22.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.012.Scx22uW_22.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/36.013.Scx22uW_22.fa.24000001..26281198.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.001.Scx22uW_31.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.002.Scx22uW_31.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.003.Scx22uW_31.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.004.Scx22uW_31.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.005.Scx22uW_31.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.006.Scx22uW_31.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.007.Scx22uW_31.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.008.Scx22uW_31.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.009.Scx22uW_31.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.010.Scx22uW_31.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.011.Scx22uW_31.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.012.Scx22uW_31.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.013.Scx22uW_31.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.014.Scx22uW_31.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.015.Scx22uW_31.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.016.Scx22uW_31.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/38.017.Scx22uW_31.fa.32000001..33849204.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.001.Scx22uW_47.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.002.Scx22uW_47.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.003.Scx22uW_47.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.004.Scx22uW_47.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.005.Scx22uW_47.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.006.Scx22uW_47.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.007.Scx22uW_47.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.008.Scx22uW_47.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.009.Scx22uW_47.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.010.Scx22uW_47.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.011.Scx22uW_47.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.012.Scx22uW_47.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.013.Scx22uW_47.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.014.Scx22uW_47.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.015.Scx22uW_47.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.016.Scx22uW_47.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.017.Scx22uW_47.fa.32000001..34500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.018.Scx22uW_47.fa.34000001..36500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/7.019.Scx22uW_47.fa.36000001..37806931.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/41.001.Scx22uW_24.fa.1..257049.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/43.001.Scx22uW_38.fa.1..36416.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/37.001.Scx22uW_8.fa.1..287854.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.001.Scx22uW_4.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.002.Scx22uW_4.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.003.Scx22uW_4.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.004.Scx22uW_4.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.005.Scx22uW_4.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.006.Scx22uW_4.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.007.Scx22uW_4.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.008.Scx22uW_4.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.009.Scx22uW_4.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.010.Scx22uW_4.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.011.Scx22uW_4.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.012.Scx22uW_4.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.013.Scx22uW_4.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.014.Scx22uW_4.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/53.015.Scx22uW_4.fa.28000001..29993208.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.001.Scx22uW_17.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.002.Scx22uW_17.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.003.Scx22uW_17.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.004.Scx22uW_17.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.005.Scx22uW_17.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.006.Scx22uW_17.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.007.Scx22uW_17.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.008.Scx22uW_17.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.009.Scx22uW_17.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.010.Scx22uW_17.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.011.Scx22uW_17.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.012.Scx22uW_17.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.013.Scx22uW_17.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.014.Scx22uW_17.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.015.Scx22uW_17.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.016.Scx22uW_17.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/4.017.Scx22uW_17.fa.32000001..32910995.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/33.001.Scx22uW_49.fa.1..26599.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/18.001.Scx22uW_14.fa.1..133904.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.001.Scx22uW_42.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.002.Scx22uW_42.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.003.Scx22uW_42.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.004.Scx22uW_42.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.005.Scx22uW_42.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.006.Scx22uW_42.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.007.Scx22uW_42.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.008.Scx22uW_42.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.009.Scx22uW_42.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.010.Scx22uW_42.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/27.011.Scx22uW_42.fa.20000001..21630436.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.001.Scx22uW_15.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.002.Scx22uW_15.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.003.Scx22uW_15.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.004.Scx22uW_15.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.005.Scx22uW_15.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.006.Scx22uW_15.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.007.Scx22uW_15.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.008.Scx22uW_15.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.009.Scx22uW_15.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.010.Scx22uW_15.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.011.Scx22uW_15.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.012.Scx22uW_15.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.013.Scx22uW_15.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.014.Scx22uW_15.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.015.Scx22uW_15.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.016.Scx22uW_15.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/6.017.Scx22uW_15.fa.32000001..33590197.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.001.Scx22uW_7.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.002.Scx22uW_7.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.003.Scx22uW_7.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.004.Scx22uW_7.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.005.Scx22uW_7.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.006.Scx22uW_7.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.007.Scx22uW_7.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.008.Scx22uW_7.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.009.Scx22uW_7.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.010.Scx22uW_7.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.011.Scx22uW_7.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/32.012.Scx22uW_7.fa.22000001..22631291.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.001.Scx22uW_29.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.002.Scx22uW_29.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.003.Scx22uW_29.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.004.Scx22uW_29.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.005.Scx22uW_29.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.006.Scx22uW_29.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.007.Scx22uW_29.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.008.Scx22uW_29.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.009.Scx22uW_29.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.010.Scx22uW_29.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/56.011.Scx22uW_29.fa.20000001..22317280.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/5.001.Scx22uW_1.fa.1..196302.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/25.001.Scx22uW_51.fa.1..22216.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/51.001.Scx22uW_6.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/51.002.Scx22uW_6.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/51.003.Scx22uW_6.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/51.004.Scx22uW_6.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/51.005.Scx22uW_6.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/51.006.Scx22uW_6.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/51.007.Scx22uW_6.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/51.008.Scx22uW_6.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/51.009.Scx22uW_6.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/51.010.Scx22uW_6.fa.18000001..20319096.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.001.Scx22uW_2.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.002.Scx22uW_2.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.003.Scx22uW_2.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.004.Scx22uW_2.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.005.Scx22uW_2.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.006.Scx22uW_2.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.007.Scx22uW_2.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.008.Scx22uW_2.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.009.Scx22uW_2.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.010.Scx22uW_2.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.011.Scx22uW_2.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.012.Scx22uW_2.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.013.Scx22uW_2.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/31.014.Scx22uW_2.fa.26000001..26865403.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.001.Scx22uW_5.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.002.Scx22uW_5.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.003.Scx22uW_5.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.004.Scx22uW_5.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.005.Scx22uW_5.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.006.Scx22uW_5.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.007.Scx22uW_5.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.008.Scx22uW_5.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.009.Scx22uW_5.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.010.Scx22uW_5.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.011.Scx22uW_5.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.012.Scx22uW_5.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.013.Scx22uW_5.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.014.Scx22uW_5.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.015.Scx22uW_5.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.016.Scx22uW_5.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.017.Scx22uW_5.fa.32000001..34500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/8.018.Scx22uW_5.fa.34000001..34837406.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.001.Scx22uW_28.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.002.Scx22uW_28.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.003.Scx22uW_28.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.004.Scx22uW_28.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.005.Scx22uW_28.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.006.Scx22uW_28.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.007.Scx22uW_28.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.008.Scx22uW_28.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.009.Scx22uW_28.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.010.Scx22uW_28.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.011.Scx22uW_28.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.012.Scx22uW_28.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.013.Scx22uW_28.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.014.Scx22uW_28.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.015.Scx22uW_28.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/1.016.Scx22uW_28.fa.30000001..32000296.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.001.Scx22uW_34.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.002.Scx22uW_34.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.003.Scx22uW_34.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.004.Scx22uW_34.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.005.Scx22uW_34.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.006.Scx22uW_34.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.007.Scx22uW_34.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.008.Scx22uW_34.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.009.Scx22uW_34.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.010.Scx22uW_34.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.011.Scx22uW_34.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.012.Scx22uW_34.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.013.Scx22uW_34.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.014.Scx22uW_34.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.015.Scx22uW_34.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.016.Scx22uW_34.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.017.Scx22uW_34.fa.32000001..34500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.018.Scx22uW_34.fa.34000001..36500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/19.019.Scx22uW_34.fa.36000001..37698886.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/11.001.Scx22uW_37.fa.1..140339.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/14.001.Scx22uW_35.fa.1..25848.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/24.001.Scx22uW_52.fa.1..27141.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.001.Scx22uW_12.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.002.Scx22uW_12.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.003.Scx22uW_12.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.004.Scx22uW_12.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.005.Scx22uW_12.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.006.Scx22uW_12.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.007.Scx22uW_12.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.008.Scx22uW_12.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.009.Scx22uW_12.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.010.Scx22uW_12.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.011.Scx22uW_12.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.012.Scx22uW_12.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.013.Scx22uW_12.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.014.Scx22uW_12.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.015.Scx22uW_12.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.016.Scx22uW_12.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/44.017.Scx22uW_12.fa.32000001..33898938.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/12.001.Scx22uW_41.fa.1..126321.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.001.Scx22uW_32.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.002.Scx22uW_32.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.003.Scx22uW_32.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.004.Scx22uW_32.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.005.Scx22uW_32.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.006.Scx22uW_32.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.007.Scx22uW_32.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.008.Scx22uW_32.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.009.Scx22uW_32.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.010.Scx22uW_32.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.011.Scx22uW_32.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.012.Scx22uW_32.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.013.Scx22uW_32.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.014.Scx22uW_32.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/50.015.Scx22uW_32.fa.28000001..30138231.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/49.001.Scx22uW_50.fa.1..22977.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/26.001.Scx22uW_43.fa.1..23818.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/35.001.Scx22uW_30.fa.1..25059.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.001.Scx22uW_10.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.002.Scx22uW_10.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.003.Scx22uW_10.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.004.Scx22uW_10.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.005.Scx22uW_10.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.006.Scx22uW_10.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.007.Scx22uW_10.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.008.Scx22uW_10.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.009.Scx22uW_10.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.010.Scx22uW_10.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.011.Scx22uW_10.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.012.Scx22uW_10.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.013.Scx22uW_10.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.014.Scx22uW_10.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/42.015.Scx22uW_10.fa.28000001..29873134.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.001.Scx22uW_19.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.002.Scx22uW_19.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.003.Scx22uW_19.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.004.Scx22uW_19.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.005.Scx22uW_19.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.006.Scx22uW_19.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.007.Scx22uW_19.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.008.Scx22uW_19.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.009.Scx22uW_19.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.010.Scx22uW_19.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.011.Scx22uW_19.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.012.Scx22uW_19.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.013.Scx22uW_19.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.014.Scx22uW_19.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/47.015.Scx22uW_19.fa.28000001..29942532.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/15.001.Scx22uW_57.fa.1..15336.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.001.Scx22uW_11.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.002.Scx22uW_11.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.003.Scx22uW_11.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.004.Scx22uW_11.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.005.Scx22uW_11.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.006.Scx22uW_11.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.007.Scx22uW_11.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.008.Scx22uW_11.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.009.Scx22uW_11.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.010.Scx22uW_11.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.011.Scx22uW_11.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.012.Scx22uW_11.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.013.Scx22uW_11.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.014.Scx22uW_11.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.015.Scx22uW_11.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.016.Scx22uW_11.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.017.Scx22uW_11.fa.32000001..34500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/54.018.Scx22uW_11.fa.34000001..34615709.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/2.001.Scx22uW_18.fa.1..1128361.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/21.001.Scx22uW_27.fa.1..18132.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/55.001.Scx22uW_40.fa.1..39990.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/52.001.Scx22uW_53.fa.1..25992.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/40.001.Scx22uW_21.fa.1..241660.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/17.001.Scx22uW_13.fa.1..100469.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/23.001.Scx22uW_26.fa.1..23658.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/48.001.Scx22uW_48.fa.1..35746.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.001.Scx22uW_20.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.002.Scx22uW_20.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.003.Scx22uW_20.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.004.Scx22uW_20.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.005.Scx22uW_20.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.006.Scx22uW_20.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.007.Scx22uW_20.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.008.Scx22uW_20.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.009.Scx22uW_20.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.010.Scx22uW_20.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.011.Scx22uW_20.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.012.Scx22uW_20.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.013.Scx22uW_20.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.014.Scx22uW_20.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.015.Scx22uW_20.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.016.Scx22uW_20.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.017.Scx22uW_20.fa.32000001..34500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/16.018.Scx22uW_20.fa.34000001..35083332.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.001.Scx22uW_9.fa.1..2500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.002.Scx22uW_9.fa.2000001..4500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.003.Scx22uW_9.fa.4000001..6500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.004.Scx22uW_9.fa.6000001..8500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.005.Scx22uW_9.fa.8000001..10500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.006.Scx22uW_9.fa.10000001..12500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.007.Scx22uW_9.fa.12000001..14500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.008.Scx22uW_9.fa.14000001..16500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.009.Scx22uW_9.fa.16000001..18500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.010.Scx22uW_9.fa.18000001..20500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.011.Scx22uW_9.fa.20000001..22500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.012.Scx22uW_9.fa.22000001..24500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.013.Scx22uW_9.fa.24000001..26500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.014.Scx22uW_9.fa.26000001..28500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.015.Scx22uW_9.fa.28000001..30500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.016.Scx22uW_9.fa.30000001..32500000.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/46.017.Scx22uW_9.fa.32000001..33588937.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/30.001.Scx22uW_36.fa.1..33945.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus_tmp_utr/39.001.Scx22uW_25.fa.1..132850.gff >> /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff
perl /home/kang1234/software/Augustus/scripts/join_aug_pred.pl < /home/kang1234/genome/Gene_annotation/braker_4/augustus.tmp1.gff > /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr.gff
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr.gff | perl -ne 'if(m/\tAUGUSTUS\t/) {print $_;}' | perl /home/kang1234/software/Augustus/scripts/gtf2gff.pl --printExon --out=/home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr.tmp.gtf 2>/home/kang1234/genome/Gene_annotation/braker_4/errors/gtf2gff.augustus.hints_utr.gtf.stderr
/home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/Augustus/scripts/getAnnoFastaFromJoingenes.py -g /home/kang1234/genome/Gene_annotation/braker_4/genome.fa -f /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr.gtf -o /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr 1> /home/kang1234/genome/Gene_annotation/braker_4/getAnnoFastaFromJoingenes.augustus.hints_utr_tmp.stdout 2>/home/kang1234/genome/Gene_annotation/braker_4/errors/getAnnoFastaFromJoingenes.augustus.hints_utr_tmp.stderr
/home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/Augustus/scripts/fix_in_frame_stop_codon_genes.py -g /home/kang1234/genome/Gene_annotation/braker_4/genome.fa -t /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr.gtf -b /home/kang1234/genome/Gene_annotation/braker_4/bad_genes.lst -o augustus.hints_utr_fix_ifs_ -s Labroides_dimidiatus_5 -m on --UTR on --print_utr on -a /home/kang1234/software/Augustus/config -C /usr/bin -A /home/kang1234/software/Augustus/bin -S /home/kang1234/software/Augustus/scripts -H /home/kang1234/genome/Gene_annotation/braker_4/hintsfile.gff -e /home/kang1234/software/BRAKER/scripts/cfg/rnaseq_utr.cfg  > /home/kang1234/genome/Gene_annotation/braker_4/fix_in_frame_stop_codon_genes_augustus.hints_utr.log 2> /home/kang1234/genome/Gene_annotation/braker_4/errors/fix_in_frame_stop_codon_genes_augustus.hints_utr.err
mv /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr_fix_ifs_.gtf /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr.gtf
rm /home/kang1234/genome/Gene_annotation/braker_4/bad_genes.lst
/home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/Augustus/scripts/getAnnoFastaFromJoingenes.py -g /home/kang1234/genome/Gene_annotation/braker_4/genome.fa -f /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr.gtf -o /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr 1> /home/kang1234/genome/Gene_annotation/braker_4/getAnnoFastaFromJoingenes.augustus.hints_utr_hints_utr.stdout 2>/home/kang1234/genome/Gene_annotation/braker_4/errors/getAnnoFastaFromJoingenes.augustus.hints_utr_hints_utr.stderr
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_320
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_38
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_43
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_203
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_74
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_61
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_107
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_6
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_49
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_195
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_335
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_243
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_79
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_144
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_339
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_111
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_298
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_108
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_308
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_65
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_3
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_19
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_247
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_85
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_31
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_183
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_274
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_292
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_296
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_209
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_157
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_131
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_311
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_279
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_129
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_333
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_302
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_252
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_202
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_214
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_365
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_393
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_50
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_48
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_64
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_53
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_379
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_316
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_219
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_253
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_73
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_147
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_237
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_27
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_142
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_39
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_145
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_330
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_205
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_360
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_334
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_36
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_101
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_294
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_303
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_1
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_174
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_114
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_141
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_130
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_96
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_383
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_10
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_88
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_204
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_4
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_322
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_179
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_113
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_268
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_236
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_359
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_66
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_25
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_70
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_375
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_329
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_345
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_182
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_271
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_341
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_116
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_181
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_92
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_160
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_380
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_256
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_68
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_153
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_397
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_261
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_389
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_197
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_89
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_267
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_315
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_381
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_307
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_394
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_117
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_310
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_123
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_367
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_11
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_98
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_222
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_357
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_326
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_151
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_257
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_248
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_166
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_102
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_37
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_347
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_112
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_32
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_353
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_193
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_342
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_224
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_161
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_231
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_346
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_75
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_291
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_312
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_230
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_132
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_233
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_165
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_100
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_284
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_103
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_51
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_175
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_133
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_275
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_240
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_396
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_135
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_323
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_362
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_344
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_110
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_343
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_299
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_270
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_76
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_216
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_206
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_14
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_139
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_187
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_45
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_95
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_370
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_24
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_84
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_69
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_264
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_262
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_159
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_391
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_286
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_29
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_40
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_324
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_143
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_328
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_55
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_15
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_276
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_71
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_8
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_220
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_361
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_281
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_242
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_198
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_373
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_90
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_177
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_273
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_399
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_327
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_382
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_180
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_356
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_278
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_272
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_67
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_378
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_5
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_388
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_392
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_34
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_150
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_170
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_229
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_168
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_227
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_118
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_289
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_78
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_86
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_384
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_372
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_387
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_9
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_355
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_400
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_58
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_44
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_319
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_33
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_221
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_152
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_351
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_385
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_172
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_288
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_22
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_140
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_363
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_244
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_28
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_47
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_81
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_105
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_309
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_295
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_155
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_337
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_124
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_377
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_259
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_287
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_249
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_269
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_336
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_42
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_338
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_215
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_317
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_134
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_91
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_21
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_196
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_225
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_171
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_83
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_106
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_332
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_300
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_12
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_154
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_122
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_149
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_188
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_97
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_325
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_63
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_239
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_241
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_305
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_301
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_169
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_213
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_199
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_94
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_13
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_321
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_2
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_371
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_176
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_250
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_138
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_178
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_201
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_194
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_173
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_77
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_162
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_260
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_285
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_354
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_282
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_238
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_57
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_210
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_109
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_125
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_200
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_148
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_35
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_352
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_366
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_297
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_258
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_223
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_72
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_167
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_218
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_235
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_246
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_60
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_293
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_185
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_146
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_369
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_331
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_41
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_212
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_192
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_254
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_232
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_7
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_283
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_314
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_104
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_121
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_376
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_137
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_126
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_398
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_263
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_228
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_290
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_16
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_251
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_217
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_186
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_119
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_368
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_189
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_226
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_234
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_59
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_386
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_99
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_277
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_265
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_87
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_128
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_304
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_340
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_306
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_158
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_163
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_54
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_191
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_395
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_120
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_20
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_80
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_18
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_245
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_266
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_350
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_364
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_62
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_190
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_348
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_23
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_56
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_318
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_280
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_390
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_164
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_313
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_156
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_115
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_255
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_349
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_211
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_52
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_82
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_26
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_374
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_184
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_127
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_17
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_136
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_207
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_358
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_46
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_30
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_93
rm /home/kang1234/genome/Gene_annotation/braker_4/aug_hints_utr_208
perl /home/kang1234/software/BRAKER/scripts/merge_transcript_sets.pl /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr.gtf /home/kang1234/genome/Gene_annotation/braker_4/GeneMark-ET/genemark.f.multi_anchored.gtf 1> /home/kang1234/genome/Gene_annotation/braker_4/braker_utr.gtf 2>/home/kang1234/genome/Gene_annotation/braker_4/errors/merge_transcripts_multi_anchored_utr.stderr
mv /home/kang1234/genome/Gene_annotation/braker_4/braker_utr.gtf /home/kang1234/genome/Gene_annotation/braker_4/step2.gtf
perl /home/kang1234/software/BRAKER/scripts/merge_transcript_sets.pl /home/kang1234/genome/Gene_annotation/braker_4/step2.gtf /home/kang1234/genome/Gene_annotation/braker_4/GeneMark-ET/genemark.f.single_anchored.gtf 1> /home/kang1234/genome/Gene_annotation/braker_4/braker_utr.gtf 2>/home/kang1234/genome/Gene_annotation/braker_4/errors/merge_transcripts_single_anchored_utr.stderr
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio.gtf | perl -ne 'if(m/\tAUGUSTUS\t/ or m/\tAnnotationFinalizer\t/ or m/\tGUSHR\t/ or m/\tGeneMark.hmm\t/) {print $_;}' | perl /home/kang1234/software/Augustus/scripts/gtf2gff.pl --gff3 --out=/home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio.gff3 >> /home/kang1234/genome/Gene_annotation/braker_4/gtf2gff3.log 2>> /home/kang1234/genome/Gene_annotation/braker_4/errors/gtf2gff3.err
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints.gtf | perl -ne 'if(m/\tAUGUSTUS\t/ or m/\tAnnotationFinalizer\t/ or m/\tGUSHR\t/ or m/\tGeneMark.hmm\t/) {print $_;}' | perl /home/kang1234/software/Augustus/scripts/gtf2gff.pl --gff3 --out=/home/kang1234/genome/Gene_annotation/braker_4/augustus.hints.gff3 >> /home/kang1234/genome/Gene_annotation/braker_4/gtf2gff3.log 2>> /home/kang1234/genome/Gene_annotation/braker_4/errors/gtf2gff3.err
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr.gtf | perl -ne 'if(m/\tAUGUSTUS\t/ or m/\tAnnotationFinalizer\t/ or m/\tGUSHR\t/ or m/\tGeneMark.hmm\t/) {print $_;}' | perl /home/kang1234/software/Augustus/scripts/gtf2gff.pl --gff3 --out=/home/kang1234/genome/Gene_annotation/braker_4/augustus.ab_initio_utr.gff3 >> /home/kang1234/genome/Gene_annotation/braker_4/gtf2gff3.log 2>> /home/kang1234/genome/Gene_annotation/braker_4/errors/gtf2gff3.err
cat /home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr.gtf | perl -ne 'if(m/\tAUGUSTUS\t/ or m/\tAnnotationFinalizer\t/ or m/\tGUSHR\t/ or m/\tGeneMark.hmm\t/) {print $_;}' | perl /home/kang1234/software/Augustus/scripts/gtf2gff.pl --gff3 --out=/home/kang1234/genome/Gene_annotation/braker_4/augustus.hints_utr.gff3 >> /home/kang1234/genome/Gene_annotation/braker_4/gtf2gff3.log 2>> /home/kang1234/genome/Gene_annotation/braker_4/errors/gtf2gff3.err
cat /home/kang1234/genome/Gene_annotation/braker_4/braker.gtf | perl -ne 'if(m/\tAUGUSTUS\t/ or m/\tAnnotationFinalizer\t/ or m/\tGUSHR\t/ or m/\tGeneMark.hmm\t/) {print $_;}' | perl /home/kang1234/software/Augustus/scripts/gtf2gff.pl --gff3 --out=/home/kang1234/genome/Gene_annotation/braker_4/braker.gff3 >> /home/kang1234/genome/Gene_annotation/braker_4/gtf2gff3.log 2>> /home/kang1234/genome/Gene_annotation/braker_4/errors/gtf2gff3.err
cat /home/kang1234/genome/Gene_annotation/braker_4/braker_utr.gtf | perl -ne 'if(m/\tAUGUSTUS\t/ or m/\tAnnotationFinalizer\t/ or m/\tGUSHR\t/ or m/\tGeneMark.hmm\t/) {print $_;}' | perl /home/kang1234/software/Augustus/scripts/gtf2gff.pl --gff3 --out=/home/kang1234/genome/Gene_annotation/braker_4/braker_utr.gff3 >> /home/kang1234/genome/Gene_annotation/braker_4/gtf2gff3.log 2>> /home/kang1234/genome/Gene_annotation/braker_4/errors/gtf2gff3.err
#**********************************************************************************
#                               GENERATING TRACK DATA HUB                          
#**********************************************************************************
/home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/MakeHub/make_hub.py -g /home/kang1234/genome/Gene_annotation/braker_4/genome.fa -e jlkang@hku.hk -l hub_Lab -L Labroides_dimidiatus_5 -X /home/kang1234/genome/Gene_annotation/braker_4 -P  > /home/kang1234/genome/Gene_annotation/braker_4/makehub.log 2> /home/kang1234/genome/Gene_annotation/braker_4/errors/makehub.err
BAM tracks are not automatically generated for saving run time; if you want to add BAM track(s), run:
/home/kang1234/software/miniconda3/bin/python3 /home/kang1234/software/MakeHub -l hub_Lab -e jlkang@hku.hk -A  -B /home/kang1234/genome/Gene_annotation/RNA-seq/RNA-align/LD10FB.sorted.bam /home/kang1234/genome/Gene_annotation/RNA-seq/RNA-align/LD10HB.sorted.bam -c 20
