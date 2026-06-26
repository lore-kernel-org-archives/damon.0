Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A53F9F37;
	Fri, 26 Jun 2026 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485178; cv=none; b=W9mlelLRRBLiW4wx6+52uNaIJb4gXWv6CW81LGuRL+x1s//QW4CYdODg9ZfdwJh3YMNw427FxmjfxT/K/uOxu+QCC2uAJq94jDMEcEz3eEOVaBngBGXMyKCzolvIdDSJ2Y2DDe1O8/UsM+jcNXF06waE5+uLH9rfhuOr50eMx2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485178; c=relaxed/simple;
	bh=sgolCgakhtFnhVhJBxm3SoBW+dCzYFi1FQeMmIA+uaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/wky5DILtk05cZB6yN9rEtac084FmW1Zily3wrgPDcv43aCe/P74ZAh/ZVD4q1SkOE06PrbFKxunRbvFyV7qaic94SjLVylunwjeNK89uynua8KyJQrBEViJJQoix4Eme8af1JW0+ZBbSWvNy+UyxcqgblMEG1nrIlEZWEFZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2MSO6vQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2MSO6vQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843771F00A3E;
	Fri, 26 Jun 2026 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485176;
	bh=7fZdQLtSd1MgDJ2accO5uxk2HAc7yukzOgkqYkqEi5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S2MSO6vQYMhCKGFwJNZwz24C4Wg+wu13oRJhd3WdYlk9FRawmhpmfDxxCdcixJ+Do
	 9AKfui952AR3leG7SuLiFOa+P3S6LNR9E034nwW1K4ulED9TQ40fcN/mL6P8X6L78a
	 3BK4soroM8Pjnl69VBogFVHWJqvSIVQR2v4tLqIoVZu0GMEJAFeLfZ3dCJlkVP+kYp
	 Vz+Sbe2jc2rZevEz6jSuGrzMTJKdTZmZjjQE9eZsjn/ERL4bjIzgpa+gmgkm8Y1010
	 RIlrJ9B8aCe5zX4G5oRNZ+sTRd4pZ/J/cSXKHV59Q6/KtHXtg3Ygt6L7BpV3PBqE1M
	 6loYGlvRd2oWw==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	jiayuan.chen@shopee.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: split a fraction of regions when nr_regions exceeds max/2
Date: Fri, 26 Jun 2026 07:46:02 -0700
Message-ID: <20260626144603.86521-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626085851.70754-2-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 16:58:37 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> kdamond_split_regions() returns early when nr_regions is above
> max_nr_regions / 2, leaving internal access variation inside a large
> region undetected.
> 
> Such a layout is common with damon-paddr on hugepage workloads or
> damon-vaddr on processes with a large anonymous mmap.
> 
> For example, with max_nr_regions == 1500, a target may end up with
> 799 small alternating-temperature regions plus one large region that
> absorbed a uniformly-accessed range during an earlier merge:
> 
> H:hot
> C:cold
> 
>       r1     r2     r3                 r800
>     HHHHHH|CCCCCC|HHHHHH|...|HHHHHH..........................|
> 
>     nr_regions = 800  >  max_nr_regions / 2 = 750
> 
> If a cold subarea later emerges inside r800:
> 
>       r1     r2     r3                 r800
>     HHHHHH|CCCCCC|HHHHHH|...|HHHHHH........CCCCCC.............|
> 
> The small regions cannot merge with each other (different access
> counts), so the budget stays full.  r800 cannot be split because
> nr_regions > max_nr_regions / 2 causes an early return.  The cold
> subarea is never discovered.
> 
> When nr_regions is above max_nr_regions / 2 but still under the
> maximum, split only a fraction of the regions instead of returning.
> One region in every 'max_nr_regions / budget' regions is split, where
> budget is the remaining room (max_nr_regions - nr_regions), starting
> from a rotating offset so different regions get picked over time.  The
> fraction shrinks as the budget shrinks, so the region count keeps
> refining while approaching max_nr_regions smoothly rather than
> overshooting it.  An unnecessary split is reverted by the next
> kdamond_merge_regions().

Looks good!

Thinking loud.  After this change, some users might surprise because the number
of regions became higher than before.  But it is still under the contracted
maximum number, and they will show better accuracy.  So I believe this is a
reasonable improvement rather than a breaking change.

Thank you for this patch, Jiayuan.

> 
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
