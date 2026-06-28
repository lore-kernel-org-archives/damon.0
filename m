Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730999463;
	Sun, 28 Jun 2026 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782624847; cv=none; b=Tl/Iu64wBHS5d5auBdTWjczi/SM1HXWG5jqvV8/xITzwLIOYNXz9pUkjtd3fNVEYsrIKHtyV5XLU2J+vdxUi/HwpGszdwYHsIK6f3ygZGOHqmqRNkJFQVSqtBiLZ1co8JTtQPxBp3Xa53KueFSk+xh5SIhyMnS7pQca3Tn17zfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782624847; c=relaxed/simple;
	bh=Ao9Tu3/w5W4HlnzmpNv3pp6KQz2fwDe9hv1NjIhJ+0o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lt47j+hFwdNUCqMhoaB8Yhh3XXwu44vzS/eTwhu4ikuhIfmEZgxbElQ+LfoXa3o+LpclcPsIqOL/XR4sV6vqorB1DidsLhwQvjCqheit54lQXL35UV9RHKll/IUomiZ8fmEA0b/ABOF+cgxUEVPGEw9rZDxIsBpcnvJSCcl2uwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=q9AWHfkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="q9AWHfkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C321F000E9;
	Sun, 28 Jun 2026 05:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782624845;
	bh=U8GvqtPsONGiqrdSgng3Dl86u7BfkOlwSjotfA+CRVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=q9AWHfkWK3xyQiwev8Qy9xYMgHiUtblF/aXyVNjeozZq3oC7HZUZV0RXG5dmrZSfU
	 Q2A7Wwign3MChDNVu4cyloKW6zTvUeoymXR646u2TO6eIQZ3iKz5jbT1ltsUah/zj3
	 0qRwmI1KpMm1lr3DOLWSOhIGECDop207dPOPrjpM=
Date: Sat, 27 Jun 2026 22:34:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Ravi Jonnalagadda
 <ravis.opensrc@gmail.com>, Quanmin Yan <yanquanmin1@huawei.com>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: reduce kernel stack usage
Message-Id: <20260627223405.3533412b4010b6ce658da01f@linux-foundation.org>
In-Reply-To: <20260611135608.66888-1-sj@kernel.org>
References: <20260611125704.3386176-1-arnd@kernel.org>
	<20260611135608.66888-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 06:56:07 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 11 Jun 2026 14:56:57 +0200 Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The main thread function has recently grown to the point of
> > exceeding stack frame size warning limits in some configurations.
> > This is what I hit on s390 with clang and CONFIG_KASAN:
> > 
> > mm/damon/core.c:3440:31: error: stack frame size (1352) exceeds limit (1280) in 'kdamond_fn' [-Werror,-Wframe-larger-than]
> >  3440 | static int kdamond_fn(struct damon_ctx *ctx)

Well cheers to s390 for using a nice tight stack limit.

> > The largest stack usage here is inside of the kdamond_tune_intervals(),
> > so by marking that one as noinline_for_stack, the functions individually
> > stay below the warning limit, though kdamond_fn() itself still uses
> > hundreds of kilobytes for some reason.

Wait what wut.  This cannot mean that kdamond_fn() uses x00,000 bytes of
stack, so what does it mean?

> Thank you for this fix, Arnd!  I will also take a look in kdamond_fn() to see
> if there are more things to reduce.
> 
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> Should we add Fixes: and Cc: stable@ too?  This function was introduced by
> commit f04b0fedbe71 ("mm/damon/core: implement intervals auto-tuning") which
> was merged into 6.15.

I don't think so - kernel is full of these offenders and it will be a
long and painstaking process to weed them out.
