Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462429DB6E;
	Wed, 24 Dec 2025 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766554721; cv=none; b=sVLbzSwAB52sZaZuhPtQo2efyB4r93KqL56sFt8SLeALyCVKN/6+q1mPRQRZvMzq/7tTaUt3ZA0b33ltT+1PvEO5ui2PLmMNxm31n+EdsDtO5YxsgQqjfTSoXR60R428eQiNTiAtOJmtxq7sdirsu1+ULaV9NEFH1hyJPaK6zCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766554721; c=relaxed/simple;
	bh=p/zI3MMRNaUVcNPNRBOBmlYid0Ap95K6FX4Ax2CKavE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDM+umBuSnNwu2YV7WOLZ13YYLQRHji0Ap0OwpOrOcknsCrp0BxgLfDeVMuhCPPUDteLJ3mvNrUOm2HYc0UuzcyNdiR1etWa6HFNgx13bq1Y/0CbSRCYkzPP0GoaStsglms2aoAtfGkxgBDOmyj09b2vZOgLItyGdMHogPJOV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOP6F9fP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOP6F9fP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF29C4CEFB;
	Wed, 24 Dec 2025 05:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766554720;
	bh=p/zI3MMRNaUVcNPNRBOBmlYid0Ap95K6FX4Ax2CKavE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOP6F9fPT62XTPWlqvxxYwPnRkNcbC9f3l1J8sFT4R/M0O1Aj8HcOWNezsGaMziFo
	 lESJ9Ytu6qkVVVUY32u3hXnXY8b5HeF8aPmJvg7MJgvLL/QaP2BvuFmwx9BuKCVFbv
	 TixzBgf1OOjP4fl1/5XPaD/tuWap3aFEm8SDXOZwVIVUfWsQHq0JmgBZ9kgKqXEwiJ
	 6RyFPPdXOUsrEtcyfzJ0x+Anso6/IUgkS08O+mgigLRAps8t36Z9eCXpD73Fvh/iwh
	 RGBxek0X564tpsC1hAkBc2J4pQVGLsuf2muhKo/tUbkBZsiWHDH6tNJuOJFYOxHK2h
	 pEFVNUUgcqNJw==
From: SeongJae Park <sj@kernel.org>
To: Shu Anzai <shu17az@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm/damon/tests/core-kunit: extend existing test scenarios
Date: Tue, 23 Dec 2025 21:38:37 -0800
Message-ID: <20251224053838.82114-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224042200.2061847-1-shu17az@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Dec 2025 04:21:55 +0000 Shu Anzai <shu17az@gmail.com> wrote:

> Improve the KUnit test coverage for DAMON. 
> 
> The five patches in this series respectively extend damon_test_split_at(), 
> damon_test_merge_two(), damon_test_merge_regions_of(), 
> damon_test_split_regions_of(), and damos_test_commit_quota_goal().
> 
> Changes from v1:
> - Split the original patch into five smaller patches.
> - Remove a newly added region from damon_test_merge_regions_of() 
>   to avoid an obvious test case.
> - Restore the test case in damon_test_split_regions_of() 
>   that was previously removed.

Thank you for revisioning, Shu!

> 
> Shu Anzai (5):
>   mm/damon/tests/core-kunit: verify the 'age' field in
>     damon_test_split_at()
>   mm/damon/tests/core-kunit: verify the 'age' and 'nr_accesses_bp'
>     fields in damon_test_merge_two()
>   mm/damon/tests/core-kunit: add a test case for region merge size limit
>     in damon_test_merge_regions_of()
>   mm/damon/tests/core-kunit: add test cases for multiple regions in
>     damon_test_split_regions_of()

I left a trivial comment on this fourth patch for unnecessary braces enclosing
a single statement.  Other than that, all look good to me.

>   mm/damon/tests/core-kunit: remove a redundant test case and add a new
>     test case in damos_test_commit_quota_goal()
> 
>  mm/damon/tests/core-kunit.h | 50 +++++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 11 deletions(-)
> 
> -- 
> 2.43.0


Thanks,
SJ

[...]
