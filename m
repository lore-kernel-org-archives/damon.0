Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A89DB665;
	Sun, 22 Feb 2026 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771780655; cv=none; b=dUbyTEMzHD5QGfM9EHS12wOAgPUX7d+NAiw9YZ1r9j2l1U98hXTO6EjEyL7SNCH5bV2L+G1AOuQH62zKNll47C9SUEWWZtXdN+wudzBmikh769GJfBFbYAg62RbUtlloZ8/zcmajU9Up6nDvspfWONev/In/4mAOqNlO3xR5auc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771780655; c=relaxed/simple;
	bh=V5bRob9/WFKeD7nCmjCkNdekw7Nf2CKVtztVEOWUWyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYAqThCj5LWfje7UkZHBGN0zEP6KWld7OqQXC4hS52NL+/ytB1ktW1+YOBU983cwysrM+Xm0dKUxKAiV9EGa5FEPxxl7NBjFifQAbnIEz8nJ1mX1lAdotkQPFGBVEzdy7pHSGVJkDpUXy4VMqSCpn5EkAWRsdPN4ooKZxtp+lMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trX7jf1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trX7jf1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B7AC116D0;
	Sun, 22 Feb 2026 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771780654;
	bh=V5bRob9/WFKeD7nCmjCkNdekw7Nf2CKVtztVEOWUWyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trX7jf1oD1hXloPLUzVJd6RxxPWMZtlIjU6Dp+X4L+dklnbzuzWSm2NCaclH4ebAd
	 U4jcDd510hbSLjpLLG8AqK+kk9oEwlBV6a5NGDnmWw+pZPZV8lbyPOOkc+tG/EdBG4
	 yr79rOzU7MPG+q2DGn8ScE9eJKMjBm3rAL11zmxs5+CXft1GZ3ADM/+EwZdmFiX1vc
	 rpckYbylYWTtTJEwvxsckkufKmH6ykfsDFiymuJt8dGMxgCdkls963lhCxsI9UzFGw
	 tqwV8NsiI3NXHGwLhCbMuB/jfeknuNh8ZIaxYeJvQ0gDVi1ZwIQVbZDjLlBeAbn7Vs
	 2/b191wnxwF0g==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 30/144] mm/damon/core.c:1693:25: warning: zero-length gnu_printf format string
Date: Sun, 22 Feb 2026 09:17:26 -0800
Message-ID: <20260222171727.133222-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202602221352.odZW8x1R-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Feb 2026 13:48:19 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   4ac50a8b182685ab2e9f2ff9411ce5c0ef3af0ac
> commit: ebbed03fc342824e63925232c8dc4ea55e54e2a3 [30/144] mm/damon/core: add damon_reset_aggregated() debug_sanity check
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260222/202602221352.odZW8x1R-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260222/202602221352.odZW8x1R-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602221352.odZW8x1R-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/m68k/include/asm/bug.h:32,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:13,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/m68k/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:79,
>                     from arch/m68k/include/asm/processor.h:11,
>                     from include/linux/sched.h:13,
>                     from include/linux/cgroup.h:12,
>                     from include/linux/memcontrol.h:13,
>                     from include/linux/damon.h:11,
>                     from mm/damon/core.c:10:
>    mm/damon/core.c: In function 'damon_verify_reset_aggregated':
> >> mm/damon/core.c:1693:25: warning: zero-length gnu_printf format string [-Wformat-zero-length]
>     1693 |         WARN_ONCE(true, "");
>          |                         ^~
>    include/asm-generic/bug.h:142:62: note: in definition of macro '__WARN_printf'
>      142 |                 warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);      \
>          |                                                              ^~~
>    include/linux/once_lite.h:31:25: note: in expansion of macro 'WARN'
>       31 |                         func(__VA_ARGS__);                              \
>          |                         ^~~~
>    include/asm-generic/bug.h:185:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
>      185 |         DO_ONCE_LITE_IF(condition, WARN, 1, format)
>          |         ^~~~~~~~~~~~~~~
>    mm/damon/core.c:1693:9: note: in expansion of macro 'WARN_ONCE'
>     1693 |         WARN_ONCE(true, "");
>          |         ^~~~~~~~~

Thank you for this report!  I just pushed a fix to damon/next.


Thanks,
SJ

[...]
