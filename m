Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CDE37F8BA;
	Sat, 19 Sep 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789833446; cv=none; b=hY4gsNLT+FQiBXknrA6BCAShct/zN0nKYdlnH+t2ikz9126PY5mvwxtJ6ekQsb92oFdyL75xWDTAVJqIGrsGkTjdfCbNEDOW9PH9m8onl5gWtDlFVPg8ZcVtCxSLUrtpiv72HjsSaLps8bWKrzIL7UHTrM8eVU0v40Dyv2KQ0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789833446; c=relaxed/simple;
	bh=k5SS+UicrfICTSVa63Rs03ykt3ipnWo/mQoMRp3+wmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMr8+tGjMpi5lg2jOKTmUXZ7NCHMds+jlYdDPIkeueqX2O+t8UfpAmc42704gh3fmBN7oxv9VACffOEVjVmyMZwxmTRzqFlunOajoFPcRrdn3LsQBiPdXHFNBUKQ5PlpsH0hJQfpngDJRSmFxfRl3DmQsf0l9/MISRTgCBuCE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1CP6FuF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1CP6FuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513441F000FF;
	Sat, 19 Sep 2026 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789833443;
	bh=2vMQb7udZL3y0xIqeUPoqQ6nfJil4eFetW2PhuHVfyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n1CP6FuF2cU0FlyUyib3oHPT683ZPiPqR9rhrCDfPrg8Deubd+G/PT/8nTq3Lfayv
	 7kcbNB1Zu8NbnX2vLjqQKzU3FbOo6dfTrClsssGwSNRtSkkK0GlnY80TPzSjjkMrFa
	 W1TA1ppchwCwcI8Wa52Qd873vEd6nf7rcrIHavL6IACVUZ8qJBDs7BcjbspI7LaL3W
	 82CWe561q16aaLbPgwpYy83sbtVaN5DFD4NxIPUnU98WUaBwC67mj/FGRHinqV/UF5
	 TkQijl3pGqjEj1hD296ajuoHzlLh0AAeYRV3NXTAOrY5yiUiIQQV4KP++ILXesX06X
	 aJI6y97UVboYA==
From: SJ Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 01/10] mm/damon/api: remove NR_DAMOS_FILTER_TYPES
Date: Sat, 19 Sep 2026 08:57:15 -0700
Message-ID: <20260919155716.86019-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ae900f5b-7f00-4c48-8097-f2f836c09f60@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 21:02:30 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> On 9/17/26 10:21 PM, SJ Park wrote:
> > Nobody uses NR_DAMOS_FILTER_TYPES.  Remove it.
[...]
> Similarly we have more definitions of NR_foo in damon.h:
> 
>  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
>  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
>  * @NR_DAMOS_WMARK_METRICS:	Total number of DAMOS watermark metrics
>  * @NR_DAMON_OPS:	Number of monitoring operations implementations
> 
> and only NR_DAMON_OPS is actually used (I checked mm-new).  If the
> preference is removing all unused macros, we should probably clean them up
> as well.

Nice findings!  Please feel free to post a patch for cleaning those up if you
don't mind!


Thanks,
SJ

[...]
