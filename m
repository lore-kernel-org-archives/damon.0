Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05F2C027C;
	Sat, 19 Sep 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789834055; cv=none; b=m4SqB0s9sIYcuY6g2WKhH+997KBT2MW5x1Xi4HNi9r0mYCG3kR9rs7FqrlD72kQn16GGYRj0Rvgn48ldwOGn037+gp+qxr9pEB9NyqBxpSaf8dLW71qZ5qvPxnrGoKgw9IqKDi9ULXvPxSwoeaslv2aU2ys4RpP3vI0ZgPjygsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789834055; c=relaxed/simple;
	bh=/VlrtPDUpDev4RfHTVdEtHu1XRRION5bX++6Q3PjPYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sktS3H0jCzEjQgDO9ePsFx3zW9eFuJma1k05lbGbW1rZb28HofRrHAf+NTHWexmcpoJFkg3hOXsjL/RCzOcUoGjTvUVTXi9Sa9sO0owJaQpEQSxcv6RpejMFK+3JdXrx4M6d39JNo8i2YvDjJEOYrFgpMJy+xhIu3TFqEMFo7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcnzfZV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcnzfZV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2641F000FF;
	Sat, 19 Sep 2026 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789834053;
	bh=wQHa39SbYUNszRpbhZJPTtwB+DOrWIjoWgUc5UFfUZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcnzfZV0jfozeaH0PTAEYh1w4FxYSswdPyKtVUe7I5onhLQzYRsjcBsnJ6PfYwrUI
	 /SQ7eb0aaKAOjJIFvmYp2mXykwN+0PIPFCZG81ZoL8i+ucysh3PFFL4CiaJkOLylcq
	 5A82Dfm4UtMfPFB4PHb5ucPYcMLmCd4Wb2dUIaeBii9chXlLnWoNyjyL4pKY1GPL9b
	 UL8HpDBz4Dfa+0IDb2ZYKzw8TLZOz7pOzQDUoYzhhwsnE4cftsgRhvUPXk3n2MC9Fi
	 lGqb7jVuOrqzH+0AYzeCZF9hfyftMY9YG2a2bgTJQcgGOgGgxbhxga40lLoj4gILKe
	 ToZak5MabqyRg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Sat, 19 Sep 2026 09:07:25 -0700
Message-ID: <20260919160725.86256-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919080453.628679-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 16:01:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Commit 50585192bc2e ("mm/damon/schemes: skip already charged targets and
> regions") introduced a minor issue that causes the last region to be
> skipped before it is processed.
> 
> Example:
> 
>     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
>     2. Quota is configured to process only 100 bytes per window.
>     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
>        addr}_from is saved at (Target, 100).
>     4. Window 2: The loop reaches R2.  Because R2 is
>        damon_last_region(t), the old code unconditionally returns true,
>        skipping R2 entirely and resetting the charge_{target,addr}_from.
> 
>     Result: R2 is permanently skipped even though it has never been
>     processed.
> 
> Add a test to prevent this regression in the future.
> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Other than a trivial style that I commented below,

Reviewed-by: SJ Park <sj@kernel.org>

[...]
> +static void damon_test_last_region_quota_reset(struct kunit *test)
> +{
[...]
> +	t = damon_new_target();
> +	if (!t) {
> +		kunit_skip(test, "target alloc fail");
> +	}

Let's drop braces for single line, as suggested [1] in coding-style.

[1] https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces


Thanks,
SJ
