Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02973D5236;
	Tue, 24 Mar 2026 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336758; cv=none; b=tm+6NrPBfHyAvhF79mirIsn8/l9LKnR4rYNCR3aySvsU/lXbURwLbMTcFFpGrgDsiwxn7wXZLteQmcirKgqoPg6Tpg8lzR1/OZg2WlSXoAIxQL5tL8RYd5lmpAn/cuAjAKAii151zpnAUWqXNMEhzbGdfH1/ENokxwwY8+TT4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336758; c=relaxed/simple;
	bh=DkCzNKQCelwTBczdFWSBcOgnEgwkZZ3BqRcIv1TMB48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQSl+H/4vfLCTouaRkj+545Z7yp03hGiGcWnOOyvf60FayB4AFtS3RyrL8pNsRJhnUrKRLNZ2gkI1m5UXuDftS10+z9vroeaManZyQhAntBGSaXYQwxIB/pjANSGo/QdEhfM/MTMzRxkf3VbFk3/QZXVUA6pAQ6oVbRr1FwAdIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTK8LDAi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTK8LDAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13E6C19424;
	Tue, 24 Mar 2026 07:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774336757;
	bh=DkCzNKQCelwTBczdFWSBcOgnEgwkZZ3BqRcIv1TMB48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTK8LDAisQc6b2kaQRuW7qQllVEV0oEJ3ikNRwv4Wh9kji2YHUP4Gk9A3UjcoJvtx
	 DVAQIsGY3zJ0m1ZkjqgBzYZatG6vM+M+MTqf2/8LTxoBOddeKJXDPyr/krbiNhaZIK
	 HJLnmhWGba34WAYoDK8PGqhE8lp+yaCm4AcP9CPhDhEJWbPf7opggJZ6QCVSv3/DdK
	 6EN8Nu+dzi9dvXOtaJ8PLn+Tm2iPs3Mf75j12RxQGdmIOFLM5iRDaMxgCqeQyHUd93
	 ZPetrAQisfpUcHb1CkDGvgyqh2RRgA9Vq1d9kSxVjrLUfrudb7d6ku8GvCj33lNbbL
	 s+ZTuDsA+cWHA==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Tue, 24 Mar 2026 00:19:08 -0700
Message-ID: <20260324071908.89152-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322214325.260007-3-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 21:43:25 +0000 Josh Law <objecting@objecting.org> wrote:

> Hardware integer division is slow. The function damon_max_nr_accesses(),
> which is called very frequently (e.g., once per region per sample
> interval inside damon_update_region_access_rate), performs an integer
> division: attrs->aggr_interval / attrs->sample_interval.
> 
> However, the struct damon_attrs already caches this exact ratio in the
> internal field aggr_samples (since earlier commits). We can eliminate
> the hardware division in the hot path by simply returning aggr_samples.
> 
> This significantly reduces the CPU cycle overhead of updating the access
> rates for thousands of regions.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  include/linux/damon.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6bd71546f7b2..438fe6f3eab4 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -960,8 +960,7 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
>  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
>  {
>  	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> -	return min(attrs->aggr_interval / attrs->sample_interval,
> -			(unsigned long)UINT_MAX);
> +	return min_t(unsigned long, attrs->aggr_samples, UINT_MAX);
>  }

I just found this patch causes below divide-by-zero when
tools/testing/selftets/damon/sysfs.py is executed.

'''
[   42.462039] Oops: divide error: 0000 [#1] SMP NOPTI
[   42.463673] CPU: 4 UID: 0 PID: 2044 Comm: kdamond.0 Not tainted 7.0.0-rc4-mm-new-damon+ #354 PREEMPT(full)
[   42.465193] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   42.466590] RIP: 0010:damon_set_attrs (mm/damon/core.c:769 (discriminator 1) mm/damon/core.c:775 (discriminator 1) mm/damon/core.c:786 (discriminator 1) mm/damon/core.c:827 (discriminator 1) mm/damon/core.c:897 (discriminator 1))
[   42.467287] Code: 48 39 c5 0f 84 dd 00 00 00 41 bb 59 17 b7 d1 48 8b 43 10 4c 8d 43 10 48 8d 48 e0 49 39 c0 75 5b e9 b0 00 00 00 8b 41 18 31 d2 <41> f7 f6 41 89 c5 69 c2 10 27 00 00 31 d2 45 69 ed 10 27 00 00 41
All code
========
   0:   48 39 c5                cmp    %rax,%rbp
   3:   0f 84 dd 00 00 00       je     0xe6
   9:   41 bb 59 17 b7 d1       mov    $0xd1b71759,%r11d
   f:   48 8b 43 10             mov    0x10(%rbx),%rax
  13:   4c 8d 43 10             lea    0x10(%rbx),%r8
  17:   48 8d 48 e0             lea    -0x20(%rax),%rcx
  1b:   49 39 c0                cmp    %rax,%r8
  1e:   75 5b                   jne    0x7b
  20:   e9 b0 00 00 00          jmp    0xd5
  25:   8b 41 18                mov    0x18(%rcx),%eax
  28:   31 d2                   xor    %edx,%edx
  2a:*  41 f7 f6                div    %r14d            <-- trapping instruction
  2d:   41 89 c5                mov    %eax,%r13d
  30:   69 c2 10 27 00 00       imul   $0x2710,%edx,%eax
  36:   31 d2                   xor    %edx,%edx
  38:   45 69 ed 10 27 00 00    imul   $0x2710,%r13d,%r13d
  3f:   41                      rex.B

Code starting with the faulting instruction
===========================================
   0:   41 f7 f6                div    %r14d
   3:   41 89 c5                mov    %eax,%r13d
   6:   69 c2 10 27 00 00       imul   $0x2710,%edx,%eax
   c:   31 d2                   xor    %edx,%edx
   e:   45 69 ed 10 27 00 00    imul   $0x2710,%r13d,%r13d
  15:   41                      rex.B
[   42.470046] RSP: 0018:ffffd25c4586bcb0 EFLAGS: 00010246
[   42.470818] RAX: 0000000000000000 RBX: ffff891346919400 RCX: ffff8913502dd040
[   42.471923] RDX: 0000000000000000 RSI: ffff891348527600 RDI: ffff891344d94400
[   42.472972] RBP: ffff891344d94598 R08: ffff891346919410 R09: 0000000000000000
[   42.474028] R10: 0000000000000000 R11: 00000000d1b71759 R12: 0000000000000014
[   42.475104] R13: ffff891348527778 R14: 0000000000000000 R15: ffff891348527798
[   42.476191] FS:  0000000000000000(0000) GS:ffff89149efd8000(0000) knlGS:0000000000000000
[   42.477375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.478235] CR2: 000000003a84f080 CR3: 000000004a824000 CR4: 00000000000006f0
[   42.479291] Call Trace:
[   42.479670]  <TASK>
[   42.480044]  damon_commit_ctx (mm/damon/core.c:1538)
[   42.480660]  damon_sysfs_commit_input (mm/damon/sysfs.c:2153 mm/damon/sysfs.c:2181)
[   42.481389]  kdamond_call (mm/damon/core.c:3186)
[   42.482492]  kdamond_fn (mm/damon/core.c:3428)
[   42.483041]  ? kthread_affine_node (kernel/kthread.c:377)
[   42.483766]  ? kfree (include/linux/kmemleak.h:50 mm/slub.c:2610 mm/slub.c:6165 mm/slub.c:6483)
[   42.484257]  ? __pfx_kdamond_fn (mm/damon/core.c:3368)
[   42.484855]  ? __pfx_kdamond_fn (mm/damon/core.c:3368)
[   42.485459]  kthread (kernel/kthread.c:436)
[   42.485959]  ? __pfx_kthread (kernel/kthread.c:381)
[   42.486524]  ret_from_fork (arch/x86/kernel/process.c:164)
[   42.487105]  ? __pfx_kthread (kernel/kthread.c:381)
[   42.487668]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
[   42.488304]  </TASK>
'''

That's because damon_commit_ctx() is called to a context that just generated
using damon_new_ctx(), which doesn't set the aggr_samples.  After applying
below change, the divide-by-zero is gone.

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -676,6 +676,7 @@ struct damon_ctx *damon_new_ctx(void)
        ctx->attrs.sample_interval = 5 * 1000;
        ctx->attrs.aggr_interval = 100 * 1000;
        ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
+       ctx->attrs.aggr_samples = 20;

        ctx->passed_sample_intervals = 0;
        /* These will be set from kdamond_init_ctx() */
'''

Also, kunit crashes like below.

'''
$ ./tools/testing/kunit/kunit.py run --kunitconfig mm/damon/tests/
[00:07:19] Configuring KUnit Kernel ...
[00:07:19] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=8
[00:08:11] Starting KUnit Kernel (1/1)...
[00:08:11] ============================================================
Running tests with:
$ .kunit/linux kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
[00:08:11] =================== damon (28 subtests) ====================
[00:08:11] [PASSED] damon_test_target
[00:08:11] [PASSED] damon_test_regions
[00:08:11] [PASSED] damon_test_aggregate
[00:08:11] [PASSED] damon_test_split_at
[00:08:11] [PASSED] damon_test_merge_two
[00:08:11] [PASSED] damon_test_merge_regions_of
[00:08:11] [PASSED] damon_test_split_regions_of
[00:08:11] [PASSED] damon_test_ops_registration
[00:08:11] [PASSED] damon_test_set_regions
[00:08:11] [ERROR] Test: damon: missing expected subtest!
[00:08:11] Kernel panic - not syncing: Kernel mode signal 4
'''

It can run without the error after below changes are applied:

'''
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -514,6 +514,8 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
                .aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
        };

+       attrs.aggr_samples = attrs.aggr_interval / attrs.sample_interval;
+
        /*
         * In some cases such as 32bit architectures where UINT_MAX is
         * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
@@ -532,7 +534,8 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
 static void damon_test_update_monitoring_result(struct kunit *test)
 {
        struct damon_attrs old_attrs = {
-               .sample_interval = 10, .aggr_interval = 1000,};
+               .sample_interval = 10, .aggr_interval = 1000,
+               .aggr_samples = 100,};
        struct damon_attrs new_attrs;
        struct damon_region *r = damon_new_region(3, 7);

@@ -544,19 +547,24 @@ static void damon_test_update_monitoring_result(struct kunit *test)
        r->age = 20;

        new_attrs = (struct damon_attrs){
-               .sample_interval = 100, .aggr_interval = 10000,};
+               .sample_interval = 100, .aggr_interval = 10000,
+               .aggr_samples = 100,};
        damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
        KUNIT_EXPECT_EQ(test, r->nr_accesses, 15);
        KUNIT_EXPECT_EQ(test, r->age, 2);

        new_attrs = (struct damon_attrs){
-               .sample_interval = 1, .aggr_interval = 1000};
+               .sample_interval = 1, .aggr_interval = 1000,
+               .aggr_samples = 1000,
+       };
        damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
        KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
        KUNIT_EXPECT_EQ(test, r->age, 2);

        new_attrs = (struct damon_attrs){
-               .sample_interval = 1, .aggr_interval = 100};
+               .sample_interval = 1, .aggr_interval = 100,
+               .aggr_samples = 100,
+       };
        damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
        KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
        KUNIT_EXPECT_EQ(test, r->age, 20);
'''

Josh, could you please also take a look if these fixups are sufficient?  And
once the sufficient fixes are found from your side, could you please post a new
version of this patch after applying the fixees?  Also, please drop my
Reviewed-by: from the new version.  I will review it again.


Thanks,
SJ

[...]
