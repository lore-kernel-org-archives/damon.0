Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C68390613;
	Mon, 12 Oct 2026 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833326; cv=none; b=eUwtPnwlxN297zq03z9eCIUHb/oZ4f4xhCrp+bnA0qcb9OIf2wXirThJQVuisG/sjX9AVdlHHTf+wrrc0rDUTJMpoaCBznDop+DZnKFWqnGSd9YmhGk4maSTLmFEJZr/9niYCP/1YjokF6o6hRSK0+MKh8dPZsf4212w2vxkMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833326; c=relaxed/simple;
	bh=1h0MFXMc5IrAdWeA/c7uvVwih3wHpQdFkU7+el8D/aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGTKnkI+g8PqHNhrtpSIUMdaUKEspJjrBvl0MISDu5HL2YJHZs3Mfrg23Ca8XVlhXn7BE8HVPw34TJ7T0aBFGPLljiGDPAKQ8o5my+I+Z04YDrA/orTolDJqvQFk3EIKb0C4KMfkoSKKMcGRHF1+OpSs8rP09PX2iy+Cdg5JX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+npfRnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+npfRnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C001F0089B;
	Mon, 12 Oct 2026 19:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791833325;
	bh=F6YTrWlSG0KaQsqoHz1caRKOr6WL1WTGFAkjWA6v6qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A+npfRnELjBsUDLIhxTkqxZ8gm/uEOEFphgjCwggWLJnw0L5Y1qRAlSznGTo9iG60
	 GunbIzKq6zeGkcUlIwHYCthRy8FuUCeKZFfDet2V0OesAeFRlkm+QBKrHBExI9a9ZY
	 Nz2WKfZv4LQh+AZ49NtbO13DlNba2fTxZ/fqtff6rhB4JsImOpmJFwlR0y1ES4eoxl
	 OQzHz6riQtQDVXrp2lXh0yX07wcQ7Xs9t/WpM02B08yH9LyB51/EID7TBvyII4q39c
	 7aut7npgKDhOaBK/XGHf9KDYfVq+UkSkRbeW5i9ZnsWSXKylYb2hh4rBLreyiA9e6g
	 aAld2D14AufvA==
From: SJ Park <sj@kernel.org>
To: Suhaas Joshi <suhaas@s-joshi.in>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/damon/core: Use only installed probe in damon_merge_two_regions()
Date: Mon, 12 Oct 2026 12:28:37 -0700
Message-ID: <20261012192838.372841-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012150045.169377-1-suhaas@s-joshi.in>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 Oct 2026 20:30:39 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:

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
[...]
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
[...]
> @@ -206,7 +208,21 @@ static void damon_test_merge_two(struct kunit *test)
>  	r2->age = 21;
>  	damon_add_region(r2, t);
>  
> -	damon_merge_two_regions(t, r, r2);
> +	p = damon_new_probe();
> +	if (!p) {
> +		kunit_skip(test, "probe alloc fail");
> +		damon_free_target(t);
> +	}

As Sashiko also asked [1], shouldn't kunit_skip() be called after
damon_free_target()?

[1] https://lore.kernel.org/sashiko-outbox-168320@kernel.org


Thanks,
SJ

[...]
