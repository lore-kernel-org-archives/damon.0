Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6622BCFF
	for <damon@lists.linux.dev>; Wed,  4 Sep 2024 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725416691; cv=none; b=lC7oh5PjEbUZYaNB+ATgWKjSVqNdW+QQwtkUqOV/Y14WgDVUli+gxuKIDyxOAc3i4/LhC49zS/t73BNc0ZyuoMrfwzNx8t+FIU3Z918vdsaiGepni5t5x7zeFgswjrP4ByoZafu64j7AaVRKSn6tNSU3dv81p42OPy2aSzGgY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725416691; c=relaxed/simple;
	bh=1WO6xpQRTMRDfRfZ27ig2zvb0fVzb/Kcmi3H7qlgV2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nff7XOp9qqb0bBK+LDBc1MECm9csy2/GH7Z5otORSWS421oe5ZcSkNU5qhqqlGgfJ4ZEokl+D6sCaZTfclYt+I2dEgOuOEKPpzQIXxmQ8MUeB+DsNrWqUS1bDsnElNU2t4fSNR9lDVt0gIQ7YgO5QbOK6futANFKNYk10VeBmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWqyqMVz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWqyqMVz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-715c160e231so5088372b3a.0
        for <damon@lists.linux.dev>; Tue, 03 Sep 2024 19:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725416689; x=1726021489; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zwCNomj6XOWC97TOQh2GqhX4gwi1jh+SxGTUmB6w3+I=;
        b=CWqyqMVzpEq6FkJ0JQyc5EM+/zHk9pwnaUn/z/TSJB/2oKbrIPlugq9SXc/TEbKEqp
         /WL3TDt7vsVc1LyT2rulUmlq0ON5mn8QQi2RQ34JOs0byAOBTYIfntNXhUEaBTWQpjXb
         fXi+HD89dn9Ob24cvhTUiFpbvn3hY+irmDfpJdp0oXSt80LUkMrVyv/pSLn5XbeGLhL8
         52Rs4+vkOpsiys7055YZQq0qwz5FYIH6euaayHpLfSi4eKDQDTNLvVSKF0ZSnPBrNVkH
         d7M1ZvEUsCt9zlbaAzV5ptTh10vPnuqfp+kPzDbPh88CElZEKnQJtWR863eFobLSXG99
         QZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725416689; x=1726021489;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwCNomj6XOWC97TOQh2GqhX4gwi1jh+SxGTUmB6w3+I=;
        b=c48yNMbqDbzO92P7IAnlZt8/XTW3iopun9TPLBAATRnDQHvMWgS0a2HSJsGjQvqHAH
         9TWEwrqafpw7XhQ+4xnHelrOb0rZ7TxNZQxtmDc7vxU9wn2rhRwBy94jY95Nya2pPHZu
         zgP6PsCV/mTWLUs/jcrsgttmpgL4OuHSYUejWojfnFNJarjJkMqIjPtLztl+V+tbjZJs
         g9mN/DD/rqXcjH5Y/SurJU0waSnlmIhIJ+cBRLpk54CHzsWTpeBDXdM+8esAl7ru4QN0
         abktY8dqhEDiszh4YX6FfXfl98b9bJSOrh03MNMtq3tIfvh+/Bo0Xz5LNhlaGnScioGD
         hnfQ==
X-Gm-Message-State: AOJu0Ywzu4bBrDD4CFO4uTXdsg3ORJVdbJRtqMe+wHDBDW2oSGAMmRfc
	999ZCtWqYNLl1WJPeyh1FbZS3wXdfO6z64pCuu3dArt3OEvm93HlJSNkqg==
X-Google-Smtp-Source: AGHT+IFMXbIr7kvK/2OAjEqldnIEZjtUThNW4uyPyJvlcY9eBdKWEL/0pCuul4ZNGPp/Yg8+1hnpAQ==
X-Received: by 2002:a05:6a21:9206:b0:1ce:da1f:5065 with SMTP id adf61e73a8af0-1ceda1f535amr13739803637.23.1725416688570;
        Tue, 03 Sep 2024 19:24:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785210a4sm543753b3a.29.2024.09.03.19.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 19:24:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c771b962-a58f-435b-89e4-1211a9323181@roeck-us.net>
Date: Tue, 3 Sep 2024 19:24:46 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems running DAMON kunit tests with spinlock debugging
 enabled
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
References: <20240904010016.1451-1-sj@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240904010016.1451-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 18:00, SeongJae Park wrote:
> Hi Guenter,
> 
> On Tue, 3 Sep 2024 12:23:50 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Hi,
>>
>> when trying to run DAMON kunit tests with spinlock debugging enabled,
>> I get the following error messages.
>>
>>      BUG: spinlock bad magic on CPU#0, kunit_try_catch/209
>>       lock: mm.13+0x40/0x840, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
>>      CPU: 0 UID: 0 PID: 209 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00148-g178297ec52d6 #1
>>      Tainted: [N]=TEST
>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>      Call Trace:
>>       <TASK>
>>       dump_stack_lvl+0x9e/0xe0
>>       do_raw_spin_lock+0x63/0xb0
>>       damon_test_three_regions_in_vmas+0x121/0x450S
>>       ...
>>
>> This happens because damon_test_three_regions_in_vmas() calls
>> mt_init_flags() with MM_MT_FLAGS, which sets MT_FLAGS_LOCK_EXTERN.
>> Because of this, the spinlock is not initialized, which then results
>> in the error message when mas_lock() is called during the test.
>>
>> Unfortunately, replacing MM_MT_FLAGS with MT_FLAGS_ALLOC_RANGE |
>> MT_FLAGS_USE_RCU or just with MT_FLAGS_ALLOC_RANGE doesn't help;
>> it results in various "suspicious RCU usage" messages.
> 
> Thank you very much for this report with the grateful detailed investigation!
> I was able to make and send a fix[1], thanks to the investigation.  Seems it
> may need some more revisions[2], though.  I'll continue discussion on the
> thread.
> 
> [1] https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org
> [2] https://lore.kernel.org/jy6263g6em4jsdhp6tknmh2cljpuvq652kvcet4ko3z2xt7pym@ltc5h5twsszu/
> 
> 

Some more problems. I tried your patch on various architectures.
Unfortunately, that didn't turn out well. See below for some of the failures.

[ I am not sure I understand the code in damon_test_nr_accesses_to_accesses_bp(),
   especially
	.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
   What happens if sizeof(int) == sizeof(long) ?
   Unless I am really missing something, .aggr_interval will be
   0 in that case.
]

Thanks,
Guenter

---
arm:

[    6.065379]     ok 9 damon_test_set_regions
[    6.067694] Internal error: Oops - undefined instruction: 0 [#1] ARM
[    6.068458] CPU: 0 UID: 0 PID: 86 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00157-gfd747295fe53 #1
[    6.068794] Tainted: [N]=TEST
[    6.068890] Hardware name: Generic DT based system
[    6.069068] PC is at damon_test_nr_accesses_to_accesses_bp+0x8/0xc
[    6.069718] LR is at kunit_try_run_case+0x8c/0x1f0
[    6.069847] pc : [<80323990>]    lr : [<8074da70>]    psr: 60000113
[    6.069976] sp : 88bedf18  ip : 00000000  fp : 00000000
[    6.070096] r10: 00000000  r9 : 88015c0c  r8 : 88015d18
[    6.070218] r7 : 8075035c  r6 : 838b94fc  r5 : 88015d0c  r4 : 88015d18
[    6.070365] r3 : 80323988  r2 : 028c45c5  r1 : 00000000  r0 : 88015d0c
[    6.070560] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    6.070747] Control: 00093177  Table: 40004000  DAC: 00000053
[    6.070911] Register r0 information: 2-page vmalloc region starting at 0x88014000 allocated at kernel_clone+0xb0/0x394
[    6.071384] Register r1 information: NULL pointer
[    6.071552] Register r2 information: non-paged memory
[    6.071695] Register r3 information: non-slab/vmalloc memory
[    6.071904] Register r4 information: 2-page vmalloc region starting at 0x88014000 allocated at kernel_clone+0xb0/0x394
[    6.072139] Register r5 information: 2-page vmalloc region starting at 0x88014000 allocated at kernel_clone+0xb0/0x394
[    6.072387] Register r6 information: slab kmalloc-512 start 838b9200 data offset 512 pointer offset 252 size 512 allocated at kunit_filter_attr_tests+0x84/0x238
[    6.073263]     __kmalloc_noprof+0x320/0x350
[    6.073383]     kunit_filter_attr_tests+0x84/0x238
[    6.073499]     kunit_filter_suites+0x42c/0x5f4
[    6.073613]     kunit_run_all_tests+0x84/0x2cc
[    6.073723]     kernel_init_freeable+0x1cc/0x238
[    6.073840]     kernel_init+0x18/0x138
[    6.073942]     ret_from_fork+0x14/0x38
[    6.074055]  Free path:
[    6.074172]     alg_test_comp+0x22c/0x940
[    6.074294]     alg_test+0x138/0x5f4
[    6.074390]     cryptomgr_test+0x20/0x3c
[    6.074549]     kthread+0xf0/0x114
[    6.074665]     ret_from_fork+0x14/0x38
[    6.074796] Register r7 information: non-slab/vmalloc memory
[    6.074960] Register r8 information: 2-page vmalloc region starting at 0x88014000 allocated at kernel_clone+0xb0/0x394
[    6.075226] Register r9 information: 2-page vmalloc region starting at 0x88014000 allocated at kernel_clone+0xb0/0x394
[    6.075491] Register r10 information: NULL pointer
[    6.075631] Register r11 information: NULL pointer
[    6.075769] Register r12 information: NULL pointer
[    6.075927] Process kunit_try_catch (pid: 86, stack limit = 0x88bec000)
[    6.076152] Stack: (0x88bedf18 to 0x88bee000)
[    6.076379] df00:                                                       83899404 8013c844
[    6.076613] df20: 83899488 00000001 00000006 00000000 028c45c5 00000000 00000000 00000000
[    6.076828] df40: 00000000 00000000 40000113 80d7da88 8135e824 801f72d4 40000113 838993f4
[    6.077036] df60: 83d8b800 80d7da88 83898e60 566860c4 88015d18 83898e60 83d8b800 8075035c
[    6.077248] df80: 88015d18 80750380 83d7a620 8013e5f8 83d7a620 8013e508 00000000 00000000
[    6.077458] dfa0: 00000000 00000000 00000000 801000fc 00000000 00000000 00000000 00000000
[    6.077669] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    6.077875] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    6.078136] Call trace:
[    6.078238]  damon_test_nr_accesses_to_accesses_bp from kunit_try_run_case+0x8c/0x1f0
[    6.078613]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x24/0x3c
[    6.078835]  kunit_generic_run_threadfn_adapter from kthread+0xf0/0x114
[    6.079022]  kthread from ret_from_fork+0x14/0x38
[    6.079194] Exception stack(0x88bedfb0 to 0x88bedff8)
[    6.079333] dfa0:                                     00000000 00000000 00000000 00000000
[    6.079537] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    6.079736] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    6.080043] Code: 8074ff5c 80e1542c e52de004 e28dd004 (e7f000f0)
[    6.080577] ---[ end trace 0000000000000000 ]---
[    6.080902] Kernel panic - not syncing: Fatal exception


m68k:

     ok 9 damon_test_set_regions
*** TRAP #7 ***   FORMAT=0
Current process id is 86
BAD KERNEL TRAP: 00000000
Modules linked in:
PC: [<000eaf02>] damos_commit_filter_arg+0x0/0x3c
SR: 2000  SP: 01573f08  a2: 01578660
d0: 00000000    d1: 05bc73b4    d2: 00000000    d3: 01573f7c
d4: 014695a0    d5: 0002cd6c    a0: 000eaf00    a1: 05bc73b4
Process kunit_try_catch (pid: 86, task=01578660)
Frame format=0
Stack from 01573f3c:
         0025b072 00c63df0 01573f70 00c63dfc 00c63c74 014695a0 0002cd6c 00000000
         014695a0 00c63dfc 014bd860 0002cafa 0025c77c 00000000 00000004 05bc73b4
         00000000 00000000 00000000 01578a22 00c63dfc 00c63c74 0025c792 00c63cf4
         014695a0 0002ce26 00c63dfc 014bd860 00000000 00c515ae 0002cd96 00000000
         00000000 00000000 0000252c 014695a0 00000000 00000000 00000000 00000000
         00000000 00000000 00000000 00000000 00000000 00000000 00000000 20000000
Call Trace: [<0025b072>] kunit_try_run_case+0xa0/0x176
  [<0002cd6c>] list_del_init+0x0/0x2a
  [<0002cafa>] kthread_exit+0x0/0x14
  [<0025c77c>] kunit_generic_run_threadfn_adapter+0x0/0x2a
  [<0025c792>] kunit_generic_run_threadfn_adapter+0x16/0x2a
  [<0002ce26>] kthread+0x90/0x9a
  [<0002cd96>] kthread+0x0/0x9a
  [<0000252c>] ret_from_kernel_thread+0xc/0x14
Code: b082 66aa 4cdf 78fc 4fef 0064 4e75 4e47 <206f> 0004 226f 0008 2010 7203 b280 6712 7204 b280 671e 5380 6606 3169 0006 0006
Disabling lock debugging due to kernel taint
     # damon_test_nr_accesses_to_accesses_bp: try faulted
     # damon_test_nr_accesses_to_accesses_bp: internal error occurred preventing test case from running: -4
     # damon_test_nr_accesses_to_accesses_bp: pass:0 fail:1 skip:0 total:1
     not ok 10 damon_test_nr_accesses_to_accesses_bp


riscv32:

[    4.398451]     ok 9 damon_test_set_regions
[    4.400790] Kernel BUG [#1]
[    4.400952] Modules linked in:
[    4.401208] CPU: 0 UID: 0 PID: 70 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00157-gfd747295fe53 #1
[    4.401305] Tainted: [N]=TEST
[    4.401318] Hardware name: riscv-virtio,qemu (DT)
[    4.401389] epc : damon_test_nr_accesses_to_accesses_bp+0x6/0x8
[    4.401740]  ra : kunit_try_run_case+0xb4/0x1b4
[    4.401764] epc : c01ceaaa ra : c0395000 sp : c3ae1eb0
[    4.401779]  gp : c2157848 tp : c4a78040 t0 : c2d8baec
[    4.401793]  t1 : 00000001 t2 : 00006e3d s0 : c3ae1ec0
[    4.401805]  s1 : c2d8bc7c a0 : c2d8bc7c a1 : 3b9ac9ff
[    4.401819]  a2 : 00000000 a3 : 00000003 a4 : 00000001
[    4.401831]  a5 : c01ceaa4 a6 : 16b9ab70 a7 : ffffffff
[    4.401845]  s2 : fffffffc s3 : c2d8bb4c s4 : c4ab38fc
[    4.401858]  s5 : c2d8bc88 s6 : c4a78040 s7 : 00000000
[    4.401871]  s8 : 00000000 s9 : 00000000 s10: 00000000
[    4.401886]  s11: 00000000 t3 : 16b9ab70 t4 : 00000000
[    4.401898]  t5 : 4e6a1710 t6 : c20e3300
[    4.401910] status: 00000120 badaddr: 00000000 cause: 00000003
[    4.401948] [<c01ceaaa>] damon_test_nr_accesses_to_accesses_bp+0x6/0x8
[    4.402017] [<c0395000>] kunit_try_run_case+0xb4/0x1b4
[    4.402031] [<c039686a>] kunit_generic_run_threadfn_adapter+0x1a/0x32
[    4.402048] [<c002fc9c>] kthread+0xd2/0xd4
[    4.402062] [<c08b795a>] ret_from_fork+0xe/0x1c
[    4.402164] Code: 4b0a 5bf6 5c66 5cd6 5d46 610d 8082 1141 c622 0800 (9002) 1141
[    4.402354] ---[ end trace 0000000000000000 ]---
[    4.402493] Kernel panic - not syncing: Fatal exception in interrupt

sheb:

     ok 9 damon_test_set_regions
------------[ cut here ]------------
kernel BUG at kernel/exit.c:1912!
Kernel BUG: 003e [#1]
Modules linked in:
CPU: 0 UID: 0 PID: 97 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00157-gfd747295fe53 #1
Tainted: [N]=TEST
PC is at abort+0x0/0x4
PR is at damon_test_nr_accesses_to_accesses_bp+0x8/0xc
PC  : 8c021338 SP  : 8cb41f20 SR  : 40008000 TEA : 295f8f58
R0  : 00000000 R1  : 8c021338 R2  : 00000000 R3  : 00000001
R4  : 8c827d28 R5  : 00000000 R6  : 02fc63da R7  : 00000000
R8  : 8c827d28 R9  : 8c71112c R10 : 8caff4fc R11 : 8c064104
R12 : 8c827c2c R13 : 8c1ec660 R14 : 8c827d34
MACH: 0000ba01 MACL: b554de4a GBR : 00000000 PR  : 8c0e9424
Call trace:
  [<8c1eab14>] kunit_try_run_case+0x58/0x174
  [<8c011704>] arch_local_irq_restore+0x0/0x24
  [<8c5609ba>] schedule+0x1a/0xf0
  [<8c1ec660>] kunit_generic_run_threadfn_adapter+0x0/0x24
  [<8c1ec670>] kunit_generic_run_threadfn_adapter+0x10/0x24
  [<8c1ec660>] kunit_generic_run_threadfn_adapter+0x0/0x24
  [<8c011704>] arch_local_irq_restore+0x0/0x24
  [<8c03a69e>] kthread+0x96/0xc4
  [<8c0151c4>] ret_from_kernel_thread+0xc/0x14
  [<8c011704>] arch_local_irq_restore+0x0/0x24
  [<8c041960>] schedule_tail+0x0/0x58
  [<8c03a608>] kthread+0x0/0xc4
Process: kunit_try_catch (pid: 97, stack limit = (ptrval))
Stack: (0x8cb41f20 to 0x8cb42000)
1f20: 8c1eab14 8c011704 8c71b51c 00000000 00000001 02fc63da 00000000 00000000
1f40: 00000000 00000000 bec1813c 8c5609ba 8cb41f6c 8c1ec660 8c827c2c bec1813c
1f60: 8c1ec670 8c1ec660 8c827c2c 8c011704 00000000 8cafccc0 8c827d34 8c03a69e
1f80: 8cb3aa80 8c0151c4 8c833f30 8c8285fc 00000000 8c8901e0 8c011704 8c71b51c
1fa0: 8c041960 00000000 00000000 00000000 00000000 8cb3aa80 8c03a608 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 40008000 00000000 00000000 00000000 00000000
---[ end trace 0000000000000000 ]---
     # damon_test_nr_accesses_to_accesses_bp: try faulted
     # damon_test_nr_accesses_to_accesses_bp: internal error occurred preventing test case from running: -4
     # damon_test_nr_accesses_to_accesses_bp: pass:0 fail:1 skip:0 total:1
     not ok 10 damon_test_nr_accesses_to_accesses_bp
     # damon_test_update_monitoring_result: pass:1 fail:0 skip:0 total:1
     ok 11 damon_test_update_monitoring_result
     # damon_test_set_attrs: pass:1 fail:0 skip:0 total:1
     ok 12 damon_test_set_attrs
     # damon_test_moving_sum: pass:1 fail:0 skip:0 total:1
     ok 13 damon_test_moving_sum
     # damos_test_new_filter: pass:1 fail:0 skip:0 total:1
     ok 14 damos_test_new_filter
     # damos_test_filter_out: pass:1 fail:0 skip:0 total:1
     ok 15 damos_test_filter_out
     # damon_test_feed_loop_next_input: EXPECTATION FAILED at mm/damon/core-test.h:485
     Expected damon_feed_loop_next_input(last_input, 200) > damon_feed_loop_next_input(last_input, 2000), but
         damon_feed_loop_next_input(last_input, 200) == 923006 (0xe157e)
         damon_feed_loop_next_input(last_input, 2000) == 1190503 (0x122a67)
     # damon_test_feed_loop_next_input: pass:0 fail:1 skip:0 total:1
     not ok 16 damon_test_feed_loop_next_input
# damon: pass:14 fail:2 skip:0 total:16
# Totals: pass:14 fail:2 skip:0 total:16
not ok 4 damon

xtensa:

[    7.469744]     ok 9 damon_test_set_regions
[    7.471548] Unhandled division by 0 in kernel: sig: 9 [#1] PREEMPT
[    7.472769] CPU: 0 UID: 0 PID: 119 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00157-gfd747295fe53 #1
[    7.473399] Tainted: [N]=TEST
[    7.473681] a00: 903d2bfd d2503e50 d1081c10 00000000 1a1fcdc0 00000000 00000007 00000007
[    7.474153] a08: 0012c4b0 00000000 00000138 00000000 00000000 000005d0 00000000 d1ef6060
[    7.475251] pc: d0102555, ps: 00060710, depc: 00000006, excvaddr: c0ac652c
[    7.475578] lbeg: d06b3664, lend: d06b366f lcount: ffffffff, sar: 00000019
[    7.475941] Stack:
[    7.476404] > 903d4352 d2503e90 d117b8fc d1081c10
[    7.476750]   d03d2bf6 00000000 00000000 00000000
[    7.477068]   00000000 00000001 ffffffff 00060300
[    7.477336]   90024f32 d2503ef0 d1081c1c fffffffc
[    7.477603]   00000000 00000001 d1ef65a4 00060300
[    7.477864]   00000000 d1ef6560 00000001 00000000
[    7.478126]   90024f2d d2503ef0 d1edb380 d2502000
[    7.478386]   00000007 00000000 1a1fcdc0 d2502000
[    7.478647]   d0102544 d1ef6060 00000001 d2503ec0
[    7.478907]   500054c8 d2503f10 d1ef6360 00000000
[    7.479166]   d0024b34 d0024ae6 00000040 d2503ef0
[    7.479426]   00000000 d2503f30 d0024e64 d2508e20
[    7.479686]   ffffffdf d03d4344 d1081c1c d1081af0
[    7.479945]   00000000 d2503f30 d0024e64 d2508e20
[    7.480204]   00000000 00000000 00000000 00000000
[    7.480462]   00000000 00000000 00000000 00000000
[    7.480737] Call Trace:
[    7.480967] Disabling lock debugging due to kernel taint
[    7.483121]     # damon_test_nr_accesses_to_accesses_bp: try faulted: last line seen /opt/buildbot/slave/qemu-xtensa/build/mm/damon/core-test.h:0
[    7.484664]     # damon_test_nr_accesses_to_accesses_bp: internal error occurred preventing test case from running: -4
[    7.486237]     # damon_test_nr_accesses_to_accesses_bp: pass:0 fail:1 skip:0 total:1
[    7.486385]     not ok 10 damon_test_nr_accesses_to_accesses_bp
[    7.488894]     # damon_test_update_monitoring_result: pass:1 fail:0 skip:0 total:1
[    7.489238]     ok 11 damon_test_update_monitoring_result
[    7.491703]     # damon_test_set_attrs: pass:1 fail:0 skip:0 total:1
[    7.492033]     ok 12 damon_test_set_attrs
[    7.495038]     # damon_test_moving_sum: pass:1 fail:0 skip:0 total:1
[    7.495468]     ok 13 damon_test_moving_sum
[    7.499501]     # damos_test_new_filter: pass:1 fail:0 skip:0 total:1
[    7.499970]     ok 14 damos_test_new_filter
[    7.504989]     # damos_test_filter_out: pass:1 fail:0 skip:0 total:1
[    7.505292]     ok 15 damos_test_filter_out
[    7.507201]     # damon_test_feed_loop_next_input: EXPECTATION FAILED at /opt/buildbot/slave/qemu-xtensa/build/mm/damon/core-test.h:487
[    7.507201]     Expected damon_feed_loop_next_input(last_input, 200) > damon_feed_loop_next_input(last_input, 2000), but
[    7.507201]         damon_feed_loop_next_input(last_input, 200) == 923006 (0xe157e)
[    7.507201]         damon_feed_loop_next_input(last_input, 2000) == 1190503 (0x122a67)
[    7.509319]     # damon_test_feed_loop_next_input: pass:0 fail:1 skip:0 total:1
[    7.510666]     not ok 16 damon_test_feed_loop_next_input
[    7.511060] # damon: pass:14 fail:2 skip:0 total:16
[    7.511378] # Totals: pass:14 fail:2 skip:0 total:16
[    7.511694] not ok 4 damon

