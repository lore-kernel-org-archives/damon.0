Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBF1C862C
	for <damon@lists.linux.dev>; Sat, 16 Aug 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755361567; cv=none; b=mWyO/AsiUpt5Z1XchmDyU/LPgAVRAlzQSmqJYKV5JgAZico/zt6onwu1eiSzwneJq9nf5INzYABOZ3I3Vh1wEST52YgNEligp3jAp9wHkLhuxqx402De4ZZeJekNNjGWDOrXcGDiLJRP+BHn6vQCsSqd1vxTTXMTvWhmADKS7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755361567; c=relaxed/simple;
	bh=BLdXxJFpAon0vxEmJ9BpfdPmQhMgTpYWSTzjLcdQfZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgtxWZHZNxFyTD+8/WcSwSITwWgZ/HsG9ayCjowJCVeWQKluQiE1Sc4ZnwDFFumBXTWTQfuMen35XExco++nn6+5joLcH1dunvUrIbNfp+cSSgnbitu9IicVn8Ab3H5b2TiQk/7SO1VyVIEM/C7e3yqWhpWsSpQON2pA5CTufCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7of/byQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7of/byQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B525C4CEEF;
	Sat, 16 Aug 2025 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755361567;
	bh=BLdXxJFpAon0vxEmJ9BpfdPmQhMgTpYWSTzjLcdQfZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7of/byQ2qEF9XEsewl15DZcQpUBH13ZNyWlFi7LtyeEeJP+Viy4usQNmFOosPT6/
	 QqxnGSFCztkEO37HjUBThDP8aeS9AzLcmfN3UkK1WisS5gzTJzJc+Ra/Ei7QvQsprc
	 robSx2UhdOWIhPvHo/brkK2rCRwKKYTDyU/0F4MZsYhcragSv610hVFbZZZzbCbLmf
	 Wqa0iqur53T+/dxnVCtdNYR9P8BDVR5kgG/QOowKpLw5epNfvXp6xPI6udxWzt7aXV
	 O3yMSaMAt6vN1tUXwqe7ubva9jE9R2Ie3QlP0uTGlLQA+Fy4J+jp2WESVHNAk/KjPk
	 WnjK2gMZwLOkQ==
From: SeongJae Park <sj@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Bijan Tabatabai <bijan311@gmail.com>
Subject: Re: BUG while running damon kselftest on 6.17-rc1
Date: Sat, 16 Aug 2025 09:26:04 -0700
Message-Id: <20250816162604.66093-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2d39a734-320d-4341-8f8a-4019eec2dbf2@ghiti.fr>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexandre,

On Sat, 16 Aug 2025 17:12:34 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:

> Hi,
> 
> I'm encountering the following BUG while running the kselftest damon:
> 
> $ ./run_kselftest.sh -c damon
> [   42.617206] kselftest: Running tests in damon
> TAP version 13
> 1..13
> # timeout set to 45
> # selftests: damon: sysfs.sh
> [   50.237792] Unable to handle kernel paging request at virtual address 
> 6b6b6b6b6b6b6b6b
> [   50.240089] Current sysfs.sh pgtable: 4K pagesize, 57-bit VAs, 
> pgdp=0x000000010b969000
> [   50.241239] [6b6b6b6b6b6b6b6b] pgd=0000000040017401, p4d=0000000000000000
> [   50.243717] Oops [#1]
> [   50.244406] Modules linked in:
> [   50.245357] CPU: 1 UID: 0 PID: 432 Comm: sysfs.sh Not tainted 
> 6.16.0-rc5-00257-g9106d467533d #71 NONE
> [   50.246559] Hardware name: riscv-virtio,qemu (DT)
> [   50.247425] epc : damon_sysfs_schemes_rm_dirs+0x7e/0x272
> [   50.248675]  ra : damon_sysfs_schemes_rm_dirs+0x6c/0x272
> [   50.249629] epc : ffffffff8037bdac ra : ffffffff8037bd9a sp : 
> ff2000000115bb10
> [   50.250604]  gp : ffffffff829dd2d0 tp : ff60000084475740 t0 : 
> ff60000088245d68
> [   50.251507]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : 
> ff2000000115bb70
> [   50.252325]  s1 : 6b6b6b6b6b6b6b6b a0 : ff600000845a87f8 a1 : 
> ffffffff80308530
> [   50.253213]  a2 : ffffffff80014af8 a3 : ff2000000115b7f8 a4 : 
> 0000000000000001
> [   50.254314]  a5 : 000000006b6b6b6b a6 : 0000000000000000 a7 : 
> 0000000000000000
> [   50.255206]  s2 : ff600000845a87c0 s3 : 0000000000000000 s4 : 
> ff60000086dbfb68
> [   50.256152]  s5 : 0000000000000000 s6 : ff60000086e70e20 s7 : 
> ff60000086dbfb68
> [   50.257249]  s8 : ff60000088245d00 s9 : 6b6b6b6b6b6b6b6b s10: 
> 00007fffdffb6644
> [   50.258371]  s11: 000055558b2871b0 t3 : 0000000000000001 t4 : 
> ffffffffffffffff
> [   50.259580]  t5 : ff60000101b4b077 t6 : ff60000089ef7dd0
> [   50.260224] status: 0000000200000120 badaddr: 6b6b6b6b6b6b6b6b cause: 
> 000000000000000d
> [   50.261481] [<ffffffff8037bdac>] damon_sysfs_schemes_rm_dirs+0x7e/0x272
> [   50.262407] [<ffffffff8037c002>] nr_schemes_store+0x62/0x728
> [   50.263119] [<ffffffff81060768>] kobj_attr_store+0xe/0x1a
> [   50.263979] [<ffffffff8043e67e>] sysfs_kf_write+0x5e/0x68
> [   50.264725] [<ffffffff8043d1ca>] kernfs_fop_write_iter+0x100/0x16c
> [   50.265483] [<ffffffff80388390>] vfs_write+0x1e2/0x464
> [   50.266105] [<ffffffff80388890>] ksys_write+0x56/0xc0
> [   50.266880] [<ffffffff8038890e>] __riscv_sys_write+0x14/0x1c
> [   50.267624] [<ffffffff81083d86>] do_trap_ecall_u+0x1d4/0x3f4
> [   50.268303] [<ffffffff8109344a>] handle_exception+0x146/0x152
> [   50.269316] Code: 1560 3c03 0989 3c83 040c 2783 048c 84e6 5d63 00f0 
> (6088) 2985
> [   50.272581] ---[ end trace 0000000000000000 ]---
> [   50.274221] Kernel panic - not syncing: Fatal exception
> [   50.275564] SMP: stopping secondary CPUs
> [   50.277140] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> I bisected to commit 2cd0bf85a203 ("mm/damon/sysfs-schemes: implement 
> DAMOS action destinations directory") but obviously that won't help :) 
> 0x6b6b6b6b6b6b6b6b pattern points to a user-after-free error that I 
> haven't been able to identify at first sight.

Thank you so much for reporting this!

> 
> I'm attaching my riscv config, hopefully that will help.

As you mentioned, seems there is an obvious use-after-free bug.  Could you
please try below fix and let me know if it makes the problem disappear?

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 19ec063aef77..138372201981 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2218,8 +2218,8 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 {
        damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
        kobject_put(&scheme->access_pattern->kobj);
-       kobject_put(&scheme->dests->kobj);
        damos_sysfs_dests_rm_dirs(scheme->dests);
+       kobject_put(&scheme->dests->kobj);
        damon_sysfs_quotas_rm_dirs(scheme->quotas);
        kobject_put(&scheme->quotas->kobj);
        kobject_put(&scheme->watermarks->kobj);


Thanks,
SJ

[...]
