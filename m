Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67133B27F3;
	Mon, 23 Mar 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274594; cv=none; b=j2RW7LqmcNIaQXMMSL/bc6NI4Cw9i+Gs0JMuIT2NYwSWRmllppBhyUm2VEZqRyrx5OrVBsoWd/21yLM+95SRixzcgiPpZyCidoFC8BWjy8sWcvpG4MXxVBrPfOlgVveAmQtd2z4c2U89IOPs1K6yWDyzxVgw9SofZiyWYNGOgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274594; c=relaxed/simple;
	bh=VicXl/5ReiXQvUG1Yw25HF2u6ax5qMc6rQTZEFWevww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSVJTxAVZ3fNrupAmpknVzQZYYsOqIZdXazZ42xkhwodrh2syF1KEIRz6E0fD1HCYTeViCexmdMbcp3Z2yMtbioNzPAF9ioenbOZiME9CpLIskKUup7IJCiVZ0NBPwsxgy6eY8/5/Qp0MqPzlFoF330bxcWl8V7Yp8/lh2INB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta6xGW8e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta6xGW8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635E7C2BCB1;
	Mon, 23 Mar 2026 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274593;
	bh=VicXl/5ReiXQvUG1Yw25HF2u6ax5qMc6rQTZEFWevww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ta6xGW8ei6a8ZWcXE1QDlA7tnZ+WR4SyBBXbJwCt1nlOr0T7AZ630GzhgfEKKuVyH
	 r5Akukrlq6qXekEeFkiNEFb/iV03ukK/PH78T9jFpBswnnEyTMhHONtimKTmNpBU2S
	 Iacii8WxXRbVmPPyyEPuRRH6uB7kZqhAgQ5w/fRH4l8iPtPXmUlNh3mUUZObWg1fRG
	 0v2KpyIOwTdOzYpm5RYDEV5NP3OEteiToOXff+S+nmhZP9x6VZlV/iFX1kjSRohlBU
	 qN09KysnsWfIZrx8UJnQEClSVwPO5ZOTWDtREAXR8Yy9TUSAt/9xfJ2ugDvoV1NhjI
	 YNaNIJkIGoyXg==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/damon/core: Performance optimizations for the kdamond hot path
Date: Mon, 23 Mar 2026 07:03:05 -0700
Message-ID: <20260323140306.79853-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322213631.259212-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I show you already posted v3 [1] of this series.  So I'm skipping this version.

[1] https://lore.kernel.org/20260322214325.260007-1-objecting@objecting.org


Thanks,
SJ

On Sun, 22 Mar 2026 21:36:29 +0000 Josh Law <objecting@objecting.org> wrote:

> Hello,
> 
> This patch series provides two performance optimizations for the DAMON
> core, specifically targeting the hot paths in kdamond.
> 
> The first patch optimizes kdamond_apply_schemes() by inverting the loop
> order. By iterating over schemes first and regions second, we can
> evaluate scheme-level invariants (like activation status and quotas)
> once per scheme rather than for every single region. This significantly
> reduces CPU overhead when multiple schemes are present or when quotas
> are reached.
> 
> The second patch eliminates a hardware integer division in
> damon_max_nr_accesses() by using the pre-cached aggr_samples value.
> Since this function is called once per region per sampling interval,
> removing the division provides a measurable reduction in CPU cycles
> spent in the access rate update path.
> 
> Changes from v1:
> - Use min_t(unsigned long, ...) in damon_max_nr_accesses() to satisfy
>   checkpatch warnings and improve readability.
> 
> Josh Law (2):
>   mm/damon/core: optimize kdamond_apply_schemes() by inverting scheme
>     and region loops
>   mm/damon/core: eliminate hot-path integer division in
>     damon_max_nr_accesses()
> 
>  include/linux/damon.h |  3 +-
>  mm/damon/core.c       | 68 ++++++++++++++++++-------------------------
>  2 files changed, 29 insertions(+), 42 deletions(-)
> 
> -- 
> 2.43.0

Sent using hkml (https://github.com/sjp38/hackermail)
