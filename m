Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32713C2E0
	for <damon@lists.linux.dev>; Sun, 22 Jun 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750609778; cv=none; b=khGzZQ8eTBcNQb9kfiC76ZKLXAAbpMLME6K9M9mfjpmwzWK8aPtVBent1LsSNjs+a8zNMjwa8IILB0DyEapuvi46WFInwlVlZMFy78UIpORz9hvRfLhQpZ6+mKRxr3i4b0vvmKw6dKb4W1nWyPRwZlBJMAeV+foAFF5ubP+cIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750609778; c=relaxed/simple;
	bh=40EOyVGkVtpE0s+4GSuMyDUQSQjt0fLGLNr1OX6s4V8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isQqKCN2FMdb/PmoHxKv/QOiE6DtTpQMpTI/4Tv1ba29mLXWmXKrQiRxkscIEoasCbMiV05XVfqf28t63qi+oKYx5au++PVo8Rs3BU6wnwffE6gzQfhQiHDwbe7Ydmi/3Y7wxZYawRbaL1OSNVLYKHqKujzd3kGAb4WZWIQ9gso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLaCjEvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLaCjEvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D93BC4CEE3;
	Sun, 22 Jun 2025 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750609777;
	bh=40EOyVGkVtpE0s+4GSuMyDUQSQjt0fLGLNr1OX6s4V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLaCjEvt5ZyJf84FPApT4NAEmP69CWXxZjd02KCiEdwMQC/5/EUsteK/MI9J5fDev
	 4nW/gMv6hSVhhPYjSJu2oP1aGdWj3CWYq5p1Qdy0rjudzVXYHrR0PgHZHB83uxEwXm
	 aUhZ1k1D651Nhs6pS0/FJB/zqYNlSdOlGKXZSrIlD+srEGZwLir/7dq3JeFolZP6HH
	 gywQ44GPtK2DrhaDQsQkfTcJph6VktRSww7TL219w2QE70obnPUc7DbVlreBk+UWj8
	 M6JTA4+/FpjWcMft1NftkH2QVWoR7HPQN8zT6BAEh9hpFrc1IKlwQDMRGjU1WFbVLK
	 TizqNTJNLrEYw==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH 3/3] samples/damon: fix bugs for damon sample for start failures
Date: Sun, 22 Jun 2025 09:29:34 -0700
Message-Id: <20250622162935.51108-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622120926.1712-4-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu,

On Sun, 22 Jun 2025 21:09:25 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> The damon_sample_{wsse,prcl,mtier}_start() can fail so we must reset the
> "enabled" parameter to "false" again for proper rollback.
> 
> In such cases, setting Y to "enabled" then N triggers the following
> crash because damon sample start failed but the "enabled" stays as Y.
> 
>   [ 2441.419649] damon_sample_prcl: start
>   [ 2454.146817] damon_sample_prcl: stop
>   [ 2454.146862] ------------[ cut here ]------------
>   [ 2454.146865] kernel BUG at mm/slub.c:546!
>   [ 2454.148183] Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   	...
>   [ 2454.167555] Call Trace:
>   [ 2454.167822]  <TASK>
>   [ 2454.168061]  damon_destroy_ctx+0x78/0x140
>   [ 2454.168454]  damon_sample_prcl_enable_store+0x8d/0xd0
>   [ 2454.168932]  param_attr_store+0xa1/0x120
>   [ 2454.169315]  module_attr_store+0x20/0x50
>   [ 2454.169695]  sysfs_kf_write+0x72/0x90
>   [ 2454.170065]  kernfs_fop_write_iter+0x150/0x1e0
>   [ 2454.170491]  vfs_write+0x315/0x440
>   [ 2454.170833]  ksys_write+0x69/0xf0
>   [ 2454.171162]  __x64_sys_write+0x19/0x30
>   [ 2454.171525]  x64_sys_call+0x18b2/0x2700
>   [ 2454.171900]  do_syscall_64+0x7f/0x680
>   [ 2454.172258]  ? exit_to_user_mode_loop+0xf6/0x180
>   [ 2454.172694]  ? clear_bhb_loop+0x30/0x80
>   [ 2454.173067]  ? clear_bhb_loop+0x30/0x80
>   [ 2454.173439]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Thank you for finding and fixing this!

> 
> Since it's just a sample module, no need to add it to stable tree.

I agree this is not a real bug.  But, even a bug in DAMON unit test was
deserved to get a CVE id.  Hence I'd suggest adding at least Fixes: tag here,
and let stable kernels maintainers to decide whether to pick this up to stable
kernels or not.  I can help backporting if needed.

If you agree, I think we could add

Fixes: b757c6cfc696d ("samples/damon/wsse: start and stop DAMON as the user requests")

If we want to make stable kernel maintainers' life easier, we would better to
split this into three patches, for each module, and add appropriate Fixes, as
below.

For wsse,
Fixes: b757c6cfc696d ("samples/damon/wsse: start and stop DAMON as the user requests")

For prcl,

Fixes: 2aca254620a8 ("samples/damon: introduce a skeleton of a smaple DAMON module for proactive reclamation")

For mtier,

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")

Could you please do so?

> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Cc: Yunjeong Mun <yunjeong.mun@sk.com>

Regardless of your agreement on adding Fixes:

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
