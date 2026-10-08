Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947744E8E10
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473605; cv=none; b=Jom2w2cuzCteEJLKWKizycki4mPCYyYMzx6VDrkbLaMoN5E9fNigJHaVGwiQlPgDHEl9QTHHLYRKXohcG0h0E5yiubDPcZpAio6SmHMEA2Lu1VzYjA8Q1D6+n6BIO1NHgWzhaMME43l9mfd5zOppwteaRAqfNKrjR4TKZ3ZTa/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473605; c=relaxed/simple;
	bh=UjPgRL3Fd2Socfm3L5xxbwUMFjJgS8BJIj3Jl05RJLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnRuQrTr6wYGoPPA3tC0t+/0wHi6jz2Za77vXojAz+ivyGFQEciy+PQtJqWcTK7fpGFwhY7NzyPTeTY8kChMEiWhkNuauV0uRa7Ja2mlQqZ7g08YoDOZBRcDgzw+o0YY082LFL/NyzKGl1HPLNrmJG7F55tFVWCM2ntvlVHDmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=qB8DAcRj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aEAqGyJC; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="qB8DAcRj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aEAqGyJC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id B3DFE13804B9
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 11:33:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 08 Oct 2026 11:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791473601; x=1791477201; bh=1ohOW3dUtW
	KA0V20F1FOvupEiT2pfjdjzin2U2mXqdI=; b=qB8DAcRj++uCxWnV1o2Rst0iXw
	3mgG4IAbl2NE/sYdvTHp/JjhkV8tCmn8F62Q7Zc2XsHkfx8YTsOeZfly6r70Fs6r
	SStZVjfFN1XW/C3j6qnE54ErA1QpFaO2xO0Jm/EQeuS5FNGZvjwwqek8ZH5V9f7U
	Aly572f7Qh4OnR6dM0QQrqVu1dYl1iXBYulgiZqzFB0+eQ6faXSPbNwMTd1ghNk9
	FZDzcOp/eGVcMhOOqHKnsoAdUVDNy5nrxD1BzBGicT/BbeGA2eF0g8dQ/UUYz059
	bX6uZDorzpzgUE0iyyC7PgEENau77OGbHlwNZI9b1M5llT1Gt6VXDOYBst1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791473601; x=1791477201; bh=1ohOW3dUtWKA0V20F1FOvupEiT2pfjdjzin
	2U2mXqdI=; b=aEAqGyJCJ6mZt8z3uy1mmaJS5ee/5OSVhpllZoqhsOasC/ujRGi
	Fnm7hfgSRoVv7ddCqzWPSTE3XgSgRped6e+36SjnKviyI4XpplSsWbSfgs6+N4pT
	KEuYZLb0mrOiFBLNiwAVF/0CbZc4VM6LDdGn95EWhJ2k0NtNdl5XdHkTQUyfh+Tu
	cUo5f34uPmYnh4RwsqMSyCpNcapgms8w+TqBp6MbM5oHZNV08jZhWMWuvuUH1nsw
	aG5xQjqqXPDia3E0GLtf5b6ZUpAvPNsMWt2U6QSiptWHMtxOnyHoNN+H1EpOdoWC
	5vgNnDuFROymGWla0sRNFByjSZtgQm+pxiQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791473601; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:AAgqaGPBW8nDAcvzV4m2MvuR2zTIj2xrpqnSDrhZJv4+IZ2
	DkwzXSwr/Mf3BBTuKbbkyoWQfVcHhGXnIcALzmOszkrXM5AmsL2HCAeJC3bf65Nw
	3mdbY2r2HOLV/61RsVKUxk23B1rmWYuhTl7w2JEbkeEjVTaclJ4iQUioiQPJIj0c
	F2KR1Mz+SIXGhDNdk/sOWtx6dNTrM/AfToS3RVjo8WUyGg6EiUiSbiVUiAANm0OX
	iU2tJUD7L20iz2RA8u9V5LaHtPuYfFeTqFdO/IiL34Y56JhkREvQ7lyQqnXkFM3+
	6br39ZrUsD+vXEgQMM8VCI4OYN2eNtjUFzUm2CA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cgYM+3LSnLJPIZaVue4P327QhJxDaWe60CpL8Bi30ac=:UjPgRL3Fd2Socfm3L5xxbwUMFjJgS8BJIj3Jl05RJLw=;
X-ME-Sender: <xms:wbfHahT5Jb8-IEtYk9tibIYNChDP1P_n6lP7Nd49UEuZwOz7B7zXMA>
    <xme:wbfHakF1UFs7btro_IBNQOWmxJDXGuJf0mHeQLcQhpcYSBQIG6yw-bvqde2t91cRL
    kJ2LV3cd99L1kT2lUo0VRtadwReolgqiZ1_aYshRnOoI_t6HZaKYmF0>
X-ME-Received: <xmr:wbfHauEh_AZcEpzCqeCEqvNiZD8EuVsK8LKJ2SyIkZ0rjxGUqV_ex6AUpw>
X-ME-Proxy-Cause: dmFkZTEgCOCP5+1yTBY1l1+wTffbkdPBs6DGGTByjN7Z9bSLHTe0KIhzDBvnYnqWoiABJD
    Ql7IwVYOuJseuEhxLBjoCPtCHVi9JyGOC7UWVrKMg95d7mHnqc/J2FBVwUOZ4yuTAovKlG
    Mdm+qp9WSubKDcJmKN1KMstqKMUMfO1yhczYvc5bnZCviSeiZQWoI/X8LaGwZt2svBr8dN
    f61H4HTv73Xn7NyO1kR2Iq2OaVP5ROW5VEXrlYmIv6dARoGmg30C42EFonW0levRx+83/J
    ytxinHZTOgi7KEAFxbu2sbtBrjJRxAW6GZWz3KdIlpUmpW1SNRqt5lJLSDNXzywmG5uJRU
    kBYBbDhPjrhoJGGTNzJEQZuD5UAM/7jhoeivPRb+MNFFbw1t8lUwAIZvsi5bP/arJCwiMh
    NrDQiq/wpk3EyOww4PHYe72lJ652NfEDARq1NUNxIl1w1rYBYH5A1WUFu3JcNljyB9Cu3K
    ocD9XEQy6FLyrQKiHkRhiw7z+C81/7Fo5W5MdnT4M2kM7mZ6/JVUf7N/re7GiIWsZ3+3LQ
    wQBze0CxfOkoCZm9lUVkKIMTmFzE4d9I3AYTp8iIw29HGFkeg2zFReq75vCcB6iNVfEcXm
    YpDYs21A99UP0JXTWpvzdpBxONDTPyI2V4r6xphsDxMB70K/CUc2MRngEnxg
X-ME-Proxy: <xmx:wbfHaqSxZmh4iT2Gl9nN6gI7MyJmxu4TmpqbJQDNFHGvjw6RpH8wiQ>
    <xmx:wbfHanJxi8DBNP-u8591huoXIo_FvOCtlD5nQqSBT6jrrcPMbZL1TA>
    <xmx:wbfHata9MbMh9rIuljvwl93yiqKSjeQOZKcIKCt3hv8-4rF3Oqj3yQ>
    <xmx:wbfHah_0R33pa9xOVHVXGuluZteJX3PFqO_Du7aq0hyt9zNPB4wUXQ>
    <xmx:wbfHakbUv6a3aTmW3by3DT1c84pulLOBrFtwFUmFEyut6gWMHpmVtcNb>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 11:33:20 -0400 (EDT)
Date: Thu, 8 Oct 2026 21:03:15 +0530
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org, akpm@linux-foundation.org, aethernet65535@gmail.com
Cc: damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: Use only installed probe in
 damon_merge_two_regions()
Message-ID: <ase2u791QTcV1LZt@fedora>
References: <20261008151944.113714-1-suhaas@s-joshi.in>
 <20261008151944.113714-2-suhaas@s-joshi.in>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008151944.113714-2-suhaas@s-joshi.in>

For some inexplicable reason, the cover-letter hasn't been sent again.

I am just adding the changelog here, in case the cover letter never arrives.

Changelog v1->v2:

1. Simplified patch 1's commit message to make it clearer 
   (Liew's suggestion)
2. Added comment docs for extra arguments I am adding to functions
   (SJ's suggestion)
3. Destroyed the context in case r2 allocation fails in damon_test_merge_two()
   (Sashiko/Liew/SJ suggestion)
4. Wrapped lines at 80 characters 
   (SJ's suggestion)

As for why the cover-letter isn't being sent, I have no idea. Everything seems
fine during `git send-email --dry-run`. Also seemed fine when I sent the series
to myself as a test.
Apologies for the inconvenience. I will make sure I fix this issue before sending
v3 or any more series in the future.

Thanks
Suhaas

On Thu, Oct 08, 2026 at 08:49:25PM +0530, Suhaas Joshi wrote:
> While merging 2 regions, we iterate over the entire probe_hits[] array,
> whose size is determined by the DAMON_MAX_PROBES macro. However, it is
> possible that we have fewer probes installed than DAMON_MAX_PROBES. In such
> cases, we end up making redundant iterations. Therefore, to remedy this,
> iterate over the list of installed probes instead of iterating over the
> entire array. For doing this, start accepting a struct damon_ctx in
> damon_merge_two_regions(), and update calling functions to pass this
> argument.
> 
> Update the damon_test_merge_two() test to use this new signature for
> damon_merge_two_regions() as well.
> 
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
> ---
>  mm/damon/core.c             | 16 +++++++++++-----
>  mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++--
>  2 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b63e60ef8990..fc202f90991b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3524,20 +3524,26 @@ static void damon_verify_merge_two_regions(
>  /*
>   * Merge two adjacent regions into one region
>   */
> -static void damon_merge_two_regions(struct damon_target *t,
> -		struct damon_region *l, struct damon_region *r)
> +static void damon_merge_two_regions(struct damon_ctx *ctx,
> +				    struct damon_target *t,
> +				    struct damon_region *l,
> +				    struct damon_region *r)
>  {
>  	unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
>  	int i;
> +	struct damon_probe *p;
>  
>  	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
>  			(sz_l + sz_r);
>  	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
>  	l->ar.end = r->ar.end;
> -	/* todo: do this for only installed probes */
> -	for (i = 0; i < DAMON_MAX_PROBES; i++)
> +
> +	i = 0;
> +	damon_for_each_probe(p, ctx) {
>  		l->probe_hits[i] = (l->probe_hits[i] * sz_l + r->probe_hits[i]
>  				* sz_r) / (sz_l + sz_r);
> +		++i;
> +	}
>  	damon_verify_merge_two_regions(l, r);
>  	damon_destroy_region(r, t);
>  }
> @@ -3590,7 +3596,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
>  			goto set_prev_continue;
>  		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
>  			goto set_prev_continue;
> -		damon_merge_two_regions(t, prev, r);
> +		damon_merge_two_regions(ctx, t, prev, r);
>  		continue;
>  set_prev_continue:
>  		prev = r;
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index ef146ca2ae8a..4e380c6c5eb2 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -182,13 +182,27 @@ static void damon_test_merge_two(struct kunit *test)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r, *r2, *r3;
> +	struct damon_probe *p;
> +	struct damon_ctx *ctx;
>  	int i;
>  
> +	p = damon_new_probe();
> +	if (!p)
> +		kunit_skip(test, "probe alloc fail");
> +	ctx = damon_new_ctx();
> +	if (!ctx) {
> +		damon_destroy_probe(p);
> +		kunit_skip(test, "context alloc fail");
> +	}
> +	damon_add_probe(ctx, p);
>  	t = damon_new_target();
> -	if (!t)
> +	if (!t) {
> +		damon_destroy_ctx(ctx);
>  		kunit_skip(test, "target alloc fail");
> +	}
>  	r = damon_new_region(0, 100);
>  	if (!r) {
> +		damon_destroy_ctx(ctx);
>  		damon_free_target(t);
>  		kunit_skip(test, "region alloc fail");
>  	}
> @@ -198,6 +212,7 @@ static void damon_test_merge_two(struct kunit *test)
>  	damon_add_region(r, t);
>  	r2 = damon_new_region(100, 300);
>  	if (!r2) {
> +		damon_destroy_ctx(ctx);
>  		damon_free_target(t);
>  		kunit_skip(test, "second region alloc fail");
>  	}
> @@ -206,7 +221,7 @@ static void damon_test_merge_two(struct kunit *test)
>  	r2->age = 21;
>  	damon_add_region(r2, t);
>  
> -	damon_merge_two_regions(t, r, r2);
> +	damon_merge_two_regions(ctx, t, r, r2);
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
> @@ -220,6 +235,7 @@ static void damon_test_merge_two(struct kunit *test)
>  	}
>  	KUNIT_EXPECT_EQ(test, i, 1);
>  
> +	damon_destroy_ctx(ctx);
>  	damon_free_target(t);
>  }
>  
> -- 
> 2.55.0
> 
