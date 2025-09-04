Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA413DBA0
	for <damon@lists.linux.dev>; Thu,  4 Sep 2025 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958526; cv=none; b=jmfcQ+vT2D62A3Nba0BL+vng6ji7TBIGGwDf4a2Qc5sc6l7eEhfM6IXFvhjAiYJAR91hBzaDHP2zIYhke1IZTLIaN11o13cAm/gBe0bbeA4Tbhv84oEpXdN9WuBWeL3+vB51rxP/InOw0rgPatYzuLqkYjvzHsIOyfyCIJRQyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958526; c=relaxed/simple;
	bh=5aXjHAaQoevDIwInsUJ9v6vsTQiihVH5FidKyJi1aU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHz6lLD4IGh8qWGuyiwUskoeyaCzwx1Pdn1t109+zTxRYyN5U9T/kN5YrUqSmijopADQqlddlvEuPNAav9m8j93VbEcaBZjNAOF/Z51C65zcSOtHPLJ07Dv6bYkURlfdIy6AONtrVhxdSAX48zTtlRjMWuaOC1Hc3ldD7Kh6VCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blI8XvLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blI8XvLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA66C4CEF0;
	Thu,  4 Sep 2025 04:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756958526;
	bh=5aXjHAaQoevDIwInsUJ9v6vsTQiihVH5FidKyJi1aU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blI8XvLl/TT7+aMDMNcVFHdto6G+7+rLFkoz6SZg/PTkL1wj8tRFqsji+J4/7xqnf
	 k+TwKSmBqDvbJeEVdBvzgopKPV703rLkwn6ToBbFb99VDK/+Lc3DRP8rKQ8MWXaJjr
	 clqq/Q2dUE0GpxdF9d+tcF5LIQz6hiXiTzyoJngVe6fu5wLqnegkIXYpl/aPAMI4Tn
	 AKHWUQGy/qJ7X52LhnZSgrKPWlaJkFX2hTBGa82RbkfwyVFs+gaItGvuoRy5Bi5Pjj
	 0o48cN6l+E9+0DIvLNqRZMqvrM4Sxzy3e5GoZ/KDLR9pGPHZeMS+IFnpXKNDz6+8si
	 WTQeTQlQ+JzOg==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com
Subject: Re: [BUG] 'damo stop' causes kernel crash in v6.17-rc3
Date: Wed,  3 Sep 2025 21:02:03 -0700
Message-Id: <20250904040203.1306-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904011738.930-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yunjeong,

On Thu,  4 Sep 2025 10:17:38 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> Hi!
> 
> I encountered a kernel crash when running 'damo stop' in kernel v6.17-rc3, 
> I tested and confirmed that this issue also occurs in v6.17-rc1.

Thank you for finding and sharing this issue!

> 
> 'damo' version that I tested is v2.9.3 and v2.4.7.
> 
> The crash happens when DAMON is configured to used both 'migrate_hot' 
> and migrate_cold' actions. I tested that if DAMON is started with only 
> one of the two actions, it works fine.

I understand you mean the problem is reproducible when you use two kdamond
threads, and you confirmed it doesn't happen when you use single kdamond
thread.  Please let me know if I'm misunderstanding.

> Below is the command I used:
> 
> ```shell
> $ ./damo start \
>  --ops paddr --numa_node 0 --monitoring_intervals 100ms 2s 20s --damos_action migrate_cold 1 \
>  --ops paddr --numa_node 1 --monitoring_intervals 100ms 2s 20s --damos_action migrate_hot 0 \
>  --nr_targets 1 1 --nr_schemes 1 1 --nr_ctxs 1 1
> 
> $ ps aux | grep kdamond
> root      1193 98.2  0.0      0     0 ?        R    07:58   0:18 [kdamond.0]
> root      1194 11.2  0.0      0     0 ?        R    07:58   0:02 [kdamond.1]
> 
> # Error occurs
> $ ./damo stop 
> ```

Thank you for sharingthis detailed steps.  On my setup, this doesn't cause
crash but make 'damo' hang.

I found commit d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file
internal work") is the first bad commit, according to 'git bisect'.  And
actually the code is broken for multiple kdamonds case, since it is sharing one
damon_call_control object for multiple kdamonds while overwriting the data
field to later-called one.

I haven't yet deep dive into by what code path the issue happens, but sharing
this first, since I have to go out soon.  I'll further take a look later.
Meanwhile, could you please also confirm if it is the first bad commit for your
issue, too?

> 
> This issue also occurs when starting DAMON using yaml configuration file 
> that includes both the 'migrate_hot' and 'migrate_cold' actions.
> Below is the dmesg log at the time of the issue:
> 
> ```
> [157729.130361] Call Trace:                                                                                                                                                                                                                                                                                                                                                       [19/1810]
> [157729.130540]  <TASK>
> [157729.130718]  kthread_stop+0x158/0x190
> [157729.130904]  kthread_stop_put+0x18/0x80
> [157729.131084]  damon_stop+0x4c/0xd0
> [157729.131264]  state_store+0x190/0x380
> [157729.131445]  ? __x64_sys_ioctl+0x7e/0xf0
> [157729.131625]  kobj_attr_store+0x13/0x30
> [157729.131805]  sysfs_kf_write+0x73/0x90
> [157729.131986]  kernfs_fop_write_iter+0x13a/0x1c0
> [157729.132167]  vfs_write+0x304/0x420
> [157729.132349]  ksys_write+0x6d/0xe0
> [157729.132525]  __x64_sys_write+0x1d/0x30
> [157729.132696]  x64_sys_call+0x16ec/0x2180
> [157729.132865]  do_syscall_64+0x74/0x1d0
> [157729.133030]  ? __x64_sys_ioctl+0x7e/0xf0
> [157729.133195]  ? x64_sys_call+0x1268/0x2180
> [157729.133364]  ? do_syscall_64+0xa3/0x1d0
> [157729.133534]  ? do_syscall_64+0xa3/0x1d0
> [157729.133698]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

'scripts/decode_stacktrace.sh' can show which line of what source file each of
the above line points.  So if you could share the output of the script from
your next bug reports, it would be pretty helpful.

So, I'll take further look, but please let me know if the first broken commit I
found is also the first broken commit for your issue.


Thanks,
SJ

[...]
