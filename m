Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556D55C1D7;
	Tue,  8 Sep 2026 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874633; cv=none; b=fV1qWGrEv6g6By3lS6MSubQqBlyZ6fC68mpyfYTNjqMQoDUtsW0vH9ggtyXfPhObXTQDEQ3t//a/0EHVfzUKdYViyT0ex7T8JbfacNvLlBlBr+GotHOvB4Urmun8yACkP8F8gCeffND1h4JWqWjmunJZxBhC4p4VvdkLG/EwmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874633; c=relaxed/simple;
	bh=DHdmYXq/qocA92uRv8JdvD7KClxlL26v2+4xcGHXHZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETpZGbIhGtmmUTp6Vzm7b16v3m2CCuX0pkNuKonpZiVANoxp0i8SjatRA+3JBX25iDrHg9I5ZMRUtLfs+EzemqsOYKuQGhHC9O1RvbUv1ga0cczo3KjlfsNjS+hHcWIxvcngJ9if4EzhKfscLZjbCR9kHjM6PWOqNX1KiVp1E50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoiCR7zd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoiCR7zd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051011F00A3E;
	Tue,  8 Sep 2026 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788874620;
	bh=VWuxOAzpawUbawzTS2dIYwJZv+ozSpJF3kgvkYsVzKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VoiCR7zdGqLzzWJEnkFL9mN3l2+qnyZNvOFfxM+dy7uWyBiUrGmDv8tOF9cza0Hz8
	 ghueWDZvT9ePkaFqelpaZOUJYG4pGbb0fkNEhyIpEqAyO+ee3hZ2EMCcnz9ylaYKwT
	 JS30KXaN4pO1DmgLst2SEJgbKHrWQ2PpeuQOjZF6/AN20Ge2gWFxqDJEpDwuENhw/d
	 Sv0MtMbEXPJxHqMtvUMwv+Y3XW92chtVWwrRabeN3uOxb01077FfNOReGyKsg0gdF0
	 rxts7SsF9PPUR3EQV9qVEVWdWRZBDQEgbtspIzXuLg+fUuBT3TP280+FlfApwMlOXv
	 MvgWDyceoL6mg==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	lianux.mm@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: improve nr_samples_per_aggr test isolation
Date: Tue,  8 Sep 2026 06:36:50 -0700
Message-ID: <20260908133651.96278-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908063635.2208922-1-kunwu.chan@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kunwu,

On Tue,  8 Sep 2026 14:36:35 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> The damon_nr_samples_per_aggr() test sets both intervals to zero,
> which exercises two different fallback paths at once.
> 
> Use separate compound initializers for each case so that each case
> tests one fallback path independently. Also make the overflow case
> use an explicit non-zero sample interval so that it does not depend
> on the zero sample interval fallback.

Thank you for sharing this patch!

> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  mm/damon/tests/core-kunit.h | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index c01e6a75cad..ff23208c181 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -627,12 +627,20 @@ static void damon_test_set_regions(struct kunit *test)
>  
>  static void damon_test_nr_samples_per_aggr(struct kunit *test)
>  {
> -	struct damon_attrs attrs = {
> +	struct damon_attrs attrs;
> +
> +	/* Zero sample interval is treated as one. */
> +	attrs = (struct damon_attrs){
>  		.sample_interval = 0,
> -		.aggr_interval = 0,
> +		.aggr_interval = 5000,
>  	};
> +	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 5000);

Thank you for adding this test case.

>  
> -	/* Zero aggregation interval doesn't cause division by zero */
> +	/* Zero samples per aggregation is treated as one. */
> +	attrs = (struct damon_attrs){
> +		.sample_interval = 5000,
> +		.aggr_interval = 0,
> +	};
>  	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 1);

But damon_set_attrs() disallows sample intervals that are larger than the
aggregation intervals.  Hence this setup is somewhat unrealistic.  Should we
set sample_interval zero?

>  
>  	/*
> @@ -640,7 +648,10 @@ static void damon_test_nr_samples_per_aggr(struct kunit *test)
>  	 * overflow
>  	 */
>  	if (ULONG_MAX > UINT_MAX) {
> -		attrs.aggr_interval = (unsigned long)UINT_MAX + 1;
> +		attrs = (struct damon_attrs){
> +			.sample_interval = 1,
> +			.aggr_interval = (unsigned long)UINT_MAX + 1,
> +		};
>  		KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs),
>  				UINT_MAX);
>  	}
> 
> base-commit: d118502628f8b673be9023db8bdf878f64a7ed45
> -- 
> 2.43.0


Thanks,
SJ
