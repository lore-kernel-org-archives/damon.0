Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D34437A
	for <damon@lists.linux.dev>; Thu,  4 Sep 2025 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949577; cv=none; b=NmcAgbyEvg5IAXyheAk1EVAhg6vHLOWrspybylGiiRPrNxYaWITLWFMUHjXF51PNIc/jokpzEboOfPCykyWvQvjk2HmBr/ycctfDK6m2HRbYG3FNdtguUDBM4zsYGj32vP16BIb16Hbj5ydm2WC7YKhGstIxCImCNGsAIjCP5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949577; c=relaxed/simple;
	bh=GyluuepoW0OnXMsaxsycCr9NT2x7qY2jrV7nov8VYaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDPcLBoZjDnABSVZXx4hAYLO+LDTDUilxJH9HPpXgj4pNk6mSQBiVlyPjCh9dwpGT/rv6eDqBo+WSceNFEhcsVwTEKc6Q3L1tC7ANq0d1/wNaAPy3yrUZb2KVTHJj0qng0HeZ5xCZbXGx+59u1B8nMNFnYlgXoU5txdMzu3I9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-39-68b8e8b456f0
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com
Subject: [BUG] 'damo stop' causes kernel crash in v6.17-rc3
Date: Thu,  4 Sep 2025 10:17:38 +0900
Message-ID: <20250904011738.930-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LhesuzUHfrix0ZBm8WSFo8+f+b1eLw1zdM
	Dkwem1Z1snm82DyTMYApissmJTUnsyy1SN8ugSuj/fcSxoLlehWrb91mbWB8o9TFyMkhIWAi
	sbR1MiOMfbznBDuIzSagIXHw0ElmEFtEQFLiz51WsDizgJPE8e3zwOqFBawldv4+zdrFyMHB
	IqAqsfQUC0iYV8BMYtfk+8wQIzUlGi7dY4KIC0qcnPmEBWKMvETz1tlANVxANRdZJXY8PMcG
	0SApcXDFDZYJjLyzkPTMQtKzgJFpFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZguCyr/RO9g/HT
	heBDjAIcjEo8vCdMdmQIsSaWFVfmHmKU4GBWEuF9zrc9Q4g3JbGyKrUoP76oNCe1+BCjNAeL
	kjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOjyTb+I+zCs0J/6sW42rZoZspo6Odsv38qLTvI
	d+cvziTfhsOzzQtEdR72uyj7/b60TfNy9enHfblTC1QPuCu+NPr1UV4mLcc8tkUs0b5pQ4am
	XkqGoXyt7O8P+kUuC9lyl5jufvl225SpKgKyVl0fZk+x1EisPvnufm7GLKfNt0+3BCup2Sqx
	FGckGmoxFxUnAgDb+cltEwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsXCNUNWR3fLix0ZBms2Glo8+f+b1eLzs9fM
	FofnnmS1OPz1DZMDi8emVZ1sHi82z2T0+Hbbw2Pxiw9MASxRXDYpqTmZZalF+nYJXBntv5cw
	FizXq1h96zZrA+MbpS5GTg4JAROJ4z0n2EFsNgENiYOHTjKD2CICkhJ/7rSCxZkFnCSOb5/H
	CGILC1hL7Px9mrWLkYODRUBVYukpFpAwr4CZxK7J95khRmpKNFy6xwQRF5Q4OfMJC8QYeYnm
	rbOZJzByzUKSmoUktYCRaRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZgOCyr/TNxB+OXy+6H
	GAU4GJV4eE+Y7MgQYk0sK67MPcQowcGsJML7nG97hhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
	r/DUBCGB9MSS1OzU1ILUIpgsEwenVAPjsiXPZsS3lUydMyU5QKbihrbP6mLv2+pSq6Z8yqlh
	y3lSb8m0TlFl6bGdfeXzt3Bs5Fp3Z/mmeTy3D6Y1fGDcEh4zT4G1vFh1u7poiKT+zA7rKO1N
	IaXNyz8yv7oqVFU6rW+2qUa/sEJa0RzF861e/Km5HivnzVowd3KgAC+7Zaesf2UMq58SS3FG
	oqEWc1FxIgA9i+0oAwIAAA==
X-CFilter-Loop: Reflected

Hi!

I encountered a kernel crash when running 'damo stop' in kernel v6.17-rc3, 
I tested and confirmed that this issue also occurs in v6.17-rc1.

'damo' version that I tested is v2.9.3 and v2.4.7.

The crash happens when DAMON is configured to used both 'migrate_hot' 
and migrate_cold' actions. I tested that if DAMON is started with only 
one of the two actions, it works fine. Below is the command I used:

```shell
$ ./damo start \
 --ops paddr --numa_node 0 --monitoring_intervals 100ms 2s 20s --damos_action migrate_cold 1 \
 --ops paddr --numa_node 1 --monitoring_intervals 100ms 2s 20s --damos_action migrate_hot 0 \
 --nr_targets 1 1 --nr_schemes 1 1 --nr_ctxs 1 1

$ ps aux | grep kdamond
root      1193 98.2  0.0      0     0 ?        R    07:58   0:18 [kdamond.0]
root      1194 11.2  0.0      0     0 ?        R    07:58   0:02 [kdamond.1]

# Error occurs
$ ./damo stop 
```

This issue also occurs when starting DAMON using yaml configuration file 
that includes both the 'migrate_hot' and 'migrate_cold' actions.
Below is the dmesg log at the time of the issue:

```
[157729.130361] Call Trace:                                                                                                                                                                                                                                                                                                                                                       [19/1810]
[157729.130540]  <TASK>
[157729.130718]  kthread_stop+0x158/0x190
[157729.130904]  kthread_stop_put+0x18/0x80
[157729.131084]  damon_stop+0x4c/0xd0
[157729.131264]  state_store+0x190/0x380
[157729.131445]  ? __x64_sys_ioctl+0x7e/0xf0
[157729.131625]  kobj_attr_store+0x13/0x30
[157729.131805]  sysfs_kf_write+0x73/0x90
[157729.131986]  kernfs_fop_write_iter+0x13a/0x1c0
[157729.132167]  vfs_write+0x304/0x420
[157729.132349]  ksys_write+0x6d/0xe0
[157729.132525]  __x64_sys_write+0x1d/0x30
[157729.132696]  x64_sys_call+0x16ec/0x2180
[157729.132865]  do_syscall_64+0x74/0x1d0
[157729.133030]  ? __x64_sys_ioctl+0x7e/0xf0
[157729.133195]  ? x64_sys_call+0x1268/0x2180
[157729.133364]  ? do_syscall_64+0xa3/0x1d0
[157729.133534]  ? do_syscall_64+0xa3/0x1d0
[157729.133698]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[157729.133861] RIP: 0033:0x7fafb5d14887
[157729.134023] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[157729.134363] RSP: 002b:00007ffe44347cc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[157729.134535] RAX: ffffffffffffffda RBX: 00005612b1e91b20 RCX: 00007fafb5d14887
[157729.134705] RDX: 0000000000000003 RSI: 00005612b9a3ae70 RDI: 0000000000000003
[157729.134870] RBP: 00005612b98998e0 R08: 0000000000000000 R09: 0000000000000000
[157729.135031] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
[157729.135189] R13: 00007fafb5f9bf80 R14: 0000000000000003 R15: 00005612b9a3ae70
[157729.135344]  </TASK>
[157729.135491] ---[ end trace 0000000000000000 ]---
[157729.135639] BUG: kernel NULL pointer dereference, address: 0000000000000000
[157729.135783] #PF: supervisor write access in kernel mode
[157729.135923] #PF: error_code(0x0002) - not-present page
[157729.136059] PGD 0 P4D 0
[157729.136192] Oops: Oops: 0002 [#32] SMP NOPTI
[157729.136323] CPU: 65 UID: 0 PID: 655661 Comm: python3 Tainted: G S    D W           6.17.0-rc3 #23 PREEMPT(voluntary)
[157729.136457] Tainted: [S]=CPU_OUT_OF_SPEC, [D]=DIE, [W]=WARN                                                                                                                                                                                                                                                                                                                            
[157729.136587] Hardware name: Supermicro SSG-222B-NE3X24R/X14DBHM, BIOS 1.0a 12/15/2024
[157729.136718] RIP: 0010:kthread_stop+0x4c/0x190
[157729.136849] Code: 00 f0 0f c1 43 28 85 c0 0f 84 4b 01 00 00 8d 50 01 09 c2 0f 88 10 01 00 00 f6 43 2e 20 0f 84 1d 01 00 00 4c 8b a3 a8 0a 00 00 <f0> 41 80 0c 24 02 48 89 df e8 16 f4 ff ff f0 80 4b 02 02 48 89 df
[157729.137125] RSP: 0018:ffffbd40c65dfc08 EFLAGS: 00010202
[157729.137265] RAX: 0000000000000000 RBX: ffff963a641699c0 RCX: 0000000000000027
[157729.137404] RDX: ffff96b4bdc5cec8 RSI: 0000000000000001 RDI: ffff96b4bdc5cec0
[157729.137543] RBP: ffffbd40c65dfc20 R08: 0000000000000003 R09: 0000000000000000
[157729.137682] R10: 0000000000000002 R11: 0000000000000003 R12: 0000000000000000
[157729.137818] R13: ffff963a641699e8 R14: ffff9637a42574d0 R15: ffff963a7f8910f8
[157729.137956] FS:  00007fafb5f9c000(0000) GS:ffff96b5018fd000(0000) knlGS:0000000000000000
[157729.138098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[157729.138240] CR2: 0000000000000000 CR3: 00000003a550c004 CR4: 0000000000f72ef0
[157729.138387] PKRU: 55555554
[157729.138531] Call Trace:
[157729.138675]  <TASK>
[157729.138818]  kthread_stop_put+0x18/0x80
[157729.138964]  damon_stop+0x4c/0xd0
[157729.139109]  state_store+0x190/0x380
[157729.139254]  ? __x64_sys_ioctl+0x7e/0xf0
[157729.139398]  kobj_attr_store+0x13/0x30
[157729.139543]  sysfs_kf_write+0x73/0x90
[157729.139688]  kernfs_fop_write_iter+0x13a/0x1c0
[157729.139833]  vfs_write+0x304/0x420
[157729.139980]  ksys_write+0x6d/0xe0
[157729.140125]  __x64_sys_write+0x1d/0x30
[157729.140271]  x64_sys_call+0x16ec/0x2180
[157729.140416]  do_syscall_64+0x74/0x1d0
[157729.140562]  ? __x64_sys_ioctl+0x7e/0xf0
[157729.140707]  ? x64_sys_call+0x1268/0x2180
[157729.140853]  ? do_syscall_64+0xa3/0x1d0
[157729.140993]  ? do_syscall_64+0xa3/0x1d0
[157729.141128]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[157729.141262] RIP: 0033:0x7fafb5d14887
```
