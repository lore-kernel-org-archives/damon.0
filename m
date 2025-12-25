Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D19D515
	for <damon@lists.linux.dev>; Thu, 25 Dec 2025 00:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766622731; cv=none; b=SnZP7dyYW9b2oS35PysIaAMcSbyOo1U/m+g0lEpcoMMiLgoNPZTba4wz4qTcnpdJD9MVmiKc/llyr6GD0qlEBdRbVLTRdtqJg+13oMgvNl3Qe3i3j67BO4a6PZg+3wfra+MDIyrvgp4M49o2J4iSD8ikledqQQtsCkYpBoqKSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766622731; c=relaxed/simple;
	bh=DMNb9i/SFEwVpqNQgZUPgGw3Co+PDnxW1tSpBKvAxVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqRSECYTFQRtBP+lwFUNM5Jri4l3qkpLVaos5TM4uMnCZxxj2bMUx2hdgxpVlJD7KVYzqcQh2bevYqFs1MWxmMkHnnwDSKR4MR5kvT4cdRaYSCgfkn6z66Dswzz1z7vwB8vnRAl+SqvibRLt7QutogwpykrQ+MOtOHgOivp9nAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTqV4BMT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTqV4BMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C7FC4CEF7;
	Thu, 25 Dec 2025 00:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766622728;
	bh=DMNb9i/SFEwVpqNQgZUPgGw3Co+PDnxW1tSpBKvAxVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTqV4BMT01S/DYK+zeEapEb9gaRIR94SZfxKYI7ZrjWnf+IJWS1z/gJVy4atUkm3E
	 8jZejl6IjdA7Kz/JAiY3+ZBocgQMwGS95L4yKdcftKz226koQIDikRFLylYPuQjboW
	 Ngw7C7V5UR9k5/1deF5UOnX3Ap7KR03AMKbJFLyIsO2qV/1wOlN5eaVVphYqhQb1gC
	 zTaL6WCp9rBsoNBVS3uhv1TZ/owf8Nzxw7BpFtZv2nW2QI7naHG1lWDbHEGnnEYt9W
	 EBptmq+szFRYZOga39JOgc/EUOmBmagEHrEbVpDC3+3A+1tO/UBVZha9CJZ5WeIs5u
	 KJfbAlaQ1CCrg==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/sysfs: preventing duplicated list_add_tail() at the damon_call()
Date: Wed, 24 Dec 2025 16:32:04 -0800
Message-ID: <20251225003205.14522-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224094401.20384-1-rgbi3307@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello JaeJoon,

On Wed, 24 Dec 2025 18:43:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

>  cd /sys/kernel/mm/damon/admin
>  echo "off" > kdamonds/0/state
> 
>  echo "commit" > kdamonds/0/state
>  echo "commit" > kdamonds/0/state
> 
> If you repeat "commit" twice with the kdamonds/0/state set to "off"
> with the above command, list_add corruption error occurs as follows:
> 
> 4-page vmalloc region starting at 0xffffffc600a38000 allocated at
> kernel_clone+0x44/0x41e
> ------------[ cut here ]------------
> list_add corruption. prev->next should be next (ffffffd6c7c5a6a8),
>          but was ffffffc600a3bcc8. (prev=ffffffc600a3bcc8).
> WARNING: lib/list_debug.c:32 at __list_add_valid_or_report+
> 0xd8/0xe2, CPU#0: bash/466
> Modules linked in: dwmac_starfive stmmac_platform stmmac pcs_xpcs phylink
> CPU: 0 UID: 0 PID: 466 Comm: bash Tainted: G W 6.19.0-rc2+ #1 PREEMPTLAZY
> Tainted: [W]=WARN
> Hardware name: StarFive VisionFive 2 v1.3B (DT)
>  epc : __list_add_valid_or_report+0xd8/0xe2
>  ra : __list_add_valid_or_report+0xd8/0xe2
>  epc : ffffffff80540bce ra : ffffffff80540bce sp : ffffffc600a3bc00
>  gp : ffffffff81caec40 tp : ffffffd6c036f080 t0 : 0000000000000000
>  t1 : 0000000000006000 t2 : 0000000000000002 s0 : ffffffc600a3bc30
>  s1 : ffffffc600a3bcc8 a0 : ffffffd6fbf49a40 a1 : ffffffd6c036f080
>  a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
>  a5 : 0000000000000000 a6 : 0000000020000000 a7 : 0000000000000001
>  s2 : ffffffd6c7c5a6a8 s3 : ffffffc600a3bcc8 s4 : ffffffc600a3bcc8
>  s5 : ffffffd6c7c5a6b8 s6 : ffffffd6c7c5a6a8 s7 : 0000003ff3f32794
>  s8 : 0000002ab38c9118 s9 : 0000000000000065 s10: 0000003f823a5cb8
>  s11: 0000003f823264e8 t3 : 0000000000000001 t4 : 0000000000000000
>  t5 : 00000000fa83b2da t6 : 000000000051df90
> status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> [<ffffffff80540bce>] __list_add_valid_or_report+0xd8/0xe2
> [<ffffffff80255c86>] damon_call+0x52/0xe8
> [<ffffffff8025c9a8>] damon_sysfs_damon_call+0x60/0x8a
> [<ffffffff8025daf4>] state_store+0xfc/0x294
> [<ffffffff80dbf1fa>] kobj_attr_store+0xe/0x1a
> [<ffffffff802f070c>] sysfs_kf_write+0x42/0x56
> [<ffffffff802eef4e>] kernfs_fop_write_iter+0xf4/0x178
> [<ffffffff8026545c>] vfs_write+0x1b6/0x3b2
> [<ffffffff80265782>] ksys_write+0x52/0xbc
> [<ffffffff80265800>] __riscv_sys_write+0x14/0x1c
> [<ffffffff80ddf124>] do_trap_ecall_u+0x19c/0x26e
> [<ffffffff80deaa38>] handle_exception+0x150/0x15c
> ---[ end trace 0000000000000000 ]---
> -bash: echo: write error: Invalid argument

Thank you for finding issue!

Also appreciate for sharing your detailed reproducer.  Nevertheless, I think
the reproducer can be more detailed.  E.g., you could explicitly explain the
fact that the reproduction step should be executed only after starting DAMON
with the kdamond, and the kernel should run with CONFIG_lIST_HARDENED to get
the output from the kernel log.

> 
> The cause of the above error is that list_add_tail() is executed
> repeatedly while executing damon_call(ctx, control)
> in damon_sysfs_damon_call().  The execution flow is summarized below:
> 
> damon_sysfs_damon_call()
>         --> damon_call(ctx, control)
>                 list_add_tail(control, ctx->call_contols);
>                         --> /* list_add corruption error */
>                 if (!damon_is_running)
>                         return -EINVAL;
> 
> If you execute damon_call() when damon_sysfs_kdamond_running() is true,
> you can prevent the error of duplicate execution of list_add_tail().

The kdamond might be terminated between the damon_call() call and the
damon_is_running() check inside the damon_call() execution.  In the case, the
problem may still happen.

The problem happens because damon_call() is not removing the damon_call_control
object before returning the error, right?  What about removing the object
before returning the error?

> 
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>

Could you please also add Fixes: and Cc: stable@ ?


Thanks,
SJ

[...]
