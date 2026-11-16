Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842930;
	b=iRT1mnvB+pHzMcKFsCSy2ip2h4t4KRYFv6T03ehyOtWSlFRRsdBB2JtndVVPr+2JiIYw
	 xjKXUXdYM7nY2Cv+o8tz7JqAt3yyjtMXfdRIDlkLTRSu7Ibsm2Dc3qmCkt1QZdolYSle5
	 XMEaUo5lDJfEdHH680bI0j7n2mw2Wg6P/qtYiQIKrQelhEVNxj+S1cfyDeFcLO9Nd9mUQ
	 YatCaIf20OBFTW9eYdybi7u1hKPMjqUgbL8lZUQvngj8MiLvrnq3A+sGzZiljXH/E4bvS
	 sLYGc8HY9WgY5C75EVnHxxr+uAmX/HdSYBGgqaT21HWjzkO/wgbmtGI33Uxjxrr0Y8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842930;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4xAnuCAiuWX4/keedDsQNjuLhi8WyX14EAVs42DysHA=;
	b=1n1yA6IDxd918C+Lggjku01/JtmNShp/Xn14rV4yjDymFVnK9mSiGXRXShQLmihPJYV9
	 qmenllJiw+UGDiAu5n6R28jZId11BVbNrO/LorLcTXv+1Bx4ntVdipALaPjoxmu7OIFd5
	 fzbUaFedqSyG8BF77vUhXTyjRWI9/xhR5ys4dg1iRWMU2iRLS6AyyKwDIV3IPAwrsfk9M
	 WUAF77Xk5tfr965BFJ4aij/DzgEqrqY3shSR4kaM4VzNsww2RVIr5kJ1YiCdfQC2FC4iS
	 Cl6bxnBLrqp6kYw8V39P9D3Gmnm4kOjFzjN++U1skCFoT7thNcDPS0N7gXDOPGLNVyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeu8DGrK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9E606A322;
	Mon, 16 Nov 2026 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeu8DGrK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A7D1F000C6;
	Mon, 16 Nov 2026 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842929;
	bh=4xAnuCAiuWX4/keedDsQNjuLhi8WyX14EAVs42DysHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aeu8DGrK7dOcH+25xyUfDQcUxpXG3VsMt7G/OtfmB+zqydYBhQRnyIUQZe9NDc8WI
	 0/noo+Rhb1OqjXKQ/ye7foi+ZqBLS5PecEbjpgYoIx9wR3fgWGPgLrnJ72QhYx6CQ6
	 p1h6NzlPYGEn7zp2M7o4imdmj7bdzv7+/jvTU74pcez4yQrUvdSpn8mMGx3Cv4QtLr
	 xJYGDUmGbcrrVy0X3yQMVdvAgzx7hQTsoYvNpVk2+iMg7nnCgClNpwMnUPFlFdBLPc
	 Y7J5GVmgiOJCdAfX7HVypUgxOTdjB5aZ6RArEcdLBM0LC0re1XbCwg9nJjBgcR0W9M
	 PtEOMv1LfrcrQ==
From: SJ Park <sj@kernel.org>
To: Jason Angelov <jasonangelov@ucla.edu>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mm/damon/tests: add KUnit coverage for age_ms filters
Date: Mon, 16 Nov 2026 07:28:42 -0800
Message-ID: <20261116152842.97789-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Jason,

On Mon, 16 Nov 2026 03:06:20 -0800 Jason Angelov <jasonangelov@ucla.edu> wrote:

> The DAMON core tests do not cover DAMOS_FILTER_TYPE_AGE_MS. Add tests for
> committing valid and invalid age ranges, identifying the filter as
> core-handled, and matching ages at and outside the range boundaries.
> 
> Region age is counted in aggregation intervals, but age_ms filter bounds
> are in milliseconds. The interval-change test checks filter matching
> after both increasing and decreasing the aggregation interval.
> 
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
> ---
> Changes in v2:
> - Fix commit-message formatting, line wrapping, and comments.
> - Set age and interval inputs directly in patch 3.
> - Add SJ's Reviewed-by tags to patches 1 and 2.
> - Link to v1: https://lore.kernel.org/r/20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu

From next time, please reply to comments on previous version and share plan to
the post next revision, before posting the next revision.

> 
> ---
> Jason Angelov (3):
>       mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in damos_test_commit_filter()
>       mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in damos_filter_for_ops()
>       mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS interval changes

All patches look good to me, thank you for this patch series, Jason.

This series is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
