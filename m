Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621841;
	b=DiupXrQqfwC4rHCmDgQcVIOUQYCAj1/4dqNRbMhw8gnom4AvCE6AkntL/RR/2U+vkhyk
	 BJ4hoeLlmbQfSJYswco1pZs4D0zC5H/qU8g7YVVyg/rqyoVZ9mhze46kScxhxyBDP+dvh
	 HOafPj5R4orJt5kcyoBeCR/na+jRVWPznT2kMItq3NbxPeT5hhI/sbMza4F8vRWZYp5z/
	 QAVq8v2Q2adUgNbPnN0UZ5dLEgQVRq9/0gL+6uTG6mxinVDzaJLu67iT71qao0Avo4Rwc
	 v/bkZTfbeHXv/qJXMbaoZl9m6bHTzHJ7kkpTzIVUNvDwnt43cq0zeY+F5fJcWCySp9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cWS29mplmy+xwtYuaSXuypfaXRQfuscnjAulbCt2rLM=;
	b=D+460nz2+6aHUrjWDzhZGlN+vzy4Ct+WTrOqO41krE7Y4PAm/10apq0Ysrml4QBGZp+l
	 tFGRgWVaxy4krZjrrZn1X6kXqo5hF8XfeHH4262Dn0Kf2pm0JxRpRhaJa0I2tvX3QZFXm
	 I+q9FWn1TZRJSge6o8LeV32aamcbyTHBcTgYapAvg0gkw9IXYMRnoCItLZZzS0O4W16fB
	 c9ILGLHeoVp+TOnm+8FjvLMToE/1CiDRJAHlaevdnPiSbgdwYSXQjPfVcWJdJ3Kz7/oJS
	 bcT+TcRxzHE/BOLd5xfDTzjBEywlmZJTeb5YYhHY5PM+5FqobC45p3JyL9lhZRVYapQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAfxhEwd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF2606A330;
	Sat, 14 Nov 2026 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAfxhEwd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05011F000C4;
	Sat, 14 Nov 2026 02:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794621841;
	bh=cWS29mplmy+xwtYuaSXuypfaXRQfuscnjAulbCt2rLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cAfxhEwdXacgTI0o8IQnQE73sfLxkoYOEBJpp4AzoB43TXmvnCjGAi1ycPpFuShlP
	 /AbicOWZqM1VCvQW4VBo9M2rOrJJKspMS1JMwkc6Ooas8FR6gQqbNrVvZoaZjxO+ub
	 a1+z5dk5EXUzONn2RlMcv1wjuhUdEmn7qNYcCSl/bIcLWrO0AJB8liyAuWQ9nvxFND
	 1fj5pLzjZmj4MWDpuN1/E7ppcKX8YV/eY+pNn8zFtIWQRBCPtE0iroDLdBKRxrfXp2
	 /Ul3cOBul46Kk6vdK1I5SB0zfiv4SUiV93NggF9cohPIw/8R32hzfEuYUqj7vK68vX
	 NBJ9PV72yWchQ==
From: SJ Park <sj@kernel.org>
To: Jason Angelov <jasonangelov@ucla.edu>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in damos_filter_for_ops()
Date: Fri, 13 Nov 2026 18:03:52 -0800
Message-ID: <20261114020353.109736-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113-test-age-ms-filter-v1-2-b99eab2f71bb@ucla.edu>
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

On Fri, 13 Nov 2026 07:58:56 -0800 Jason Angelov <jasonangelov@ucla.edu> wrote:

> DAMOS_FILTER_TYPE_AGE_MS is core filter, not ops filter.
> add kunit test covering this rejection.

s/add/Add/ ?

> 
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
> ---
>  mm/damon/tests/core-kunit.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 0eb5dcdba0ae..fb84d30a712d 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1832,6 +1832,11 @@ static void damon_test_valid_probe_params(struct kunit *test)
>  	damon_destroy_ctx(ctx);
>  }
>  
> +static void damos_test_age_ms_filter_is_core(struct kunit *test)
> +{
> +	KUNIT_EXPECT_FALSE(test, damos_filter_for_ops(DAMOS_FILTER_TYPE_AGE_MS));

Let's wrap the line for the 80 columns per line rule.

Other than above two trivial things,

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
