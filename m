Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2718C02E
	for <damon@lists.linux.dev>; Sat, 21 Mar 2026 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774052593; cv=none; b=NgAVy7BFDbD6hnQ+AfNKw2ezi1aHJQkc5uv+fqAjtdkcf5em7S0tiftyD6+HPE4F1RVDi1pYk7/q10uEkhsmvoO0KnkAHrgQU9jyw52CvoxsswQ8FrXsZ16cqkAQrJvAxU3NeU7F1nYkmk+aMEFvV0cWxr2mWcd4x2HbpuhH2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774052593; c=relaxed/simple;
	bh=GOJeUyjjWVogE75PISrYKLd8uFw9FCzsAE2nXsMF4/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzf1c5H8P2VSXtXKlnmb36q3wCn/HoQ/TzLOTGs3Ym3TUOR0K0C7gJ8M3wRntSxgQrs2fAIUlRNjz7ecGtu0TmVQCml1v+m29K6hMl59EszKmd18DtJVZwuDc0JnffzFfttxjCzsXZ8wmPJW1TQ8uqhNdkPijC70qS4BmJP3arg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8YKLdyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8YKLdyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB21C4CEF7;
	Sat, 21 Mar 2026 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774052593;
	bh=GOJeUyjjWVogE75PISrYKLd8uFw9FCzsAE2nXsMF4/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8YKLdyYGvJQV4eZNVaBQEK1dDC9jER7ugOH8Bh121qdvztgW1GYCjPUp6nYn/l+J
	 TsGH5gHnvqJ8+8BsLKPZ1Y4hKQtYexECZth4XtS9F5c2UfpZq1tYpVrUUfEAcaphQU
	 Q9oEBdj2aP3X1NV0ceoSqAjfxmYc/zwhQ5ioNcKPTXOYxXKAb3+WMm00P1Oh7QaOyY
	 sd62j/JdsEnhmYP7yv+Tc0Qqnzt+Mm6nwCiK+mVLRQRcxZ3U7P92umQO4xEp+WbVu8
	 EpcO7mBB3pPQwSAaVVmahkF46nW7uZnSx2v27DS6q1JLqv7mTI0jaBwHLxy0t0VZUz
	 JCiIR02Cia6fw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/damon/ops-common: optimize damon_hot_score() using ilog2()
Date: Fri, 20 Mar 2026 17:23:10 -0700
Message-ID: <20260321002311.69009-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320192020.33004-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,


When you send a new version of patches, please send those as new thread, rather
than as a reply to the previous version.

On Sat, 21 Mar 2026 03:20:20 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> The current implementation of damon_hot_score() uses a manual for-loop
> to calculate the value of 'age_in_log'. This can be efficiently replaced
> by ilog2(), which is semantically more appropriate for calculating the
> logarithmic value of age.
> 
> In a simulated-kernel-module performance test with 10,000,000 iterations,
> this optimization showed a significant reduction in latency (average
> latency reduced from ~12ns to ~1ns).
> 
> Test results from the simulated-kernel-module:
> - ilog2:
>     DAMON Perf Test: Starting 10000000 iterations
>     =============================================
>      Total Iterations : 10000000
>      Average Latency  : 1 ns
>      P95 Latency      : 41 ns
>      P99 Latency      : 41 ns
>     ---------------------------------------------
>      Range (ns)      | Count        | Percent
>     ---------------------------------------------
>      0-19            | 0            |      0%
>      20-39           | 2625000      |     26%
>      40-59           | 7374000      |     73%
>      60-79           | 0            |      0%
>      80-99           | 0            |      0%
>      100+            | 1000         |      0%
>     =============================================
> 
> - for-loop:
>     DAMON Perf Test: Starting 10000000 iterations
>     =============================================
>      Total Iterations : 10000000
>      Average Latency  : 12 ns
>      P95 Latency      : 51 ns
>      P99 Latency      : 60 ns
>     ---------------------------------------------
>      Range (ns)      | Count        | Percent
>     ---------------------------------------------
>      0-19            | 0            |      0%
>      20-39           | 0            |      0%
>      40-59           | 9862000      |     98%
>      60-79           | 135000       |      1%
>      80-99           | 1000         |      0%
>      100+            | 2000         |      0%
>     =============================================

Nice!

> 
> Full raw benchmark results can be found at [1].
> 
> [1] https://github.com/aethernet65535/damon-hot-score-fls-optimize/tree/master/result-raw
> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> Changes from v1:
> - Replace fls() with ilog2() per SeongJae Park's suggestion for better
>   semantic clarity.
> - Move performance benchmark results into the commit message and add 
>   comparison between for-loop and ilog2.

As I mentioned at the beginning, please send new versions as new thread from
the next time.  And, in the case, consider adding a link to the previous
versions.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ

[...]
