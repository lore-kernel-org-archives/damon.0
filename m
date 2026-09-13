Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195936C588
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320127; cv=none; b=Qbg1ZUSjM/z9XWKD8eJnQp4UlKQk4wXCOpGdWtxb9TozvP/N2Y2VbY0L/h3ryXjPY1tVeinCfmHxwCCZWW5aa/xvuc27xvtq9eoJzQJuquTlihHOGQHq9VwMnEiHjSt+qzXmClmg4SOCNyrCJdw1z0aMRBsii28eJguayf23xs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320127; c=relaxed/simple;
	bh=u5k8+Fiii5vt9eJc4kUIbNGzQo9MmwfvkEfHaXyi6Eo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jOiIBbEpd1nvfpYgX4fWiGlK75ccrFKcxDhTpjheLdE55gvsX3s4YfZaLtt0CTnpLl7oH34rpVWzBt30wxhSr01J4z+eoLSMW8QGQCgDHhnU50ZRpAAK/0lyHzRNTHvnvv9xwVnw7kOzgSNh5ISNhGEnjArsH6ZLAKuydMYqgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYi27bR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYi27bR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CF51F000FF;
	Sun, 13 Sep 2026 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320125;
	bh=6FRsDNSkJJCCj7+iQtiHfqFwvwOiOSQjmTDWKQvUjSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MYi27bR6DE37O6VpmrLekYD0i1Mwqmrh3ZAvPrzOmbYYUC5iKRSEUc3o52lok+HHi
	 DIGUk0fVt0Uh8Ezs/63/0w0hhUnnoXHC6GzUHxLKuVZBFjK886MEhIqyirl38iywV2
	 08A11TZivOQkP8XGKZA+FM3BuvhEkDPWtygYP3cJorY3B5+lmgFwJv0nQayGAxu2B5
	 4GBGadbtltyp8baYmrlGSHftq+H52z49WLMK8S05uNiYf7soVyUwO8DgiX5a7SR6ui
	 62YtpgHkl9lpg63fsWaJXbK5qx7a0y4vWWwnCoFGjaxkVIT1TGec5QXydhAIbfBcW4
	 BNF0eO7dGRenw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/8] mm/damon/api: introduce
 DAMON_FILTER_TYPE_HUGEPAGE_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171133.102366-2-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
 <20260913171133.102366-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:22:04 +0000
Message-Id: <20260913172204.E5CF51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized memory usage for new `DAMON_FILTER_TYPE_HUGEPAGE_SIZ=
E` filters.
--

commit 1e4870705ac75e710966e11c09d2b8438d7b1bb1
Author: SJ Park <sj@kernel.org>

mm/damon/api: introduce DAMON_FILTER_TYPE_HUGEPAGE_SIZE

Introduce a new data attribute probe filter type, hugepage_size. It will
work for memory that is backed by a hugepage of a given size range. Add a
new damon_filter_type enum DAMON_FILTER_TYPE_HUGEPAGE_SIZE to identify the
type.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 4be7d1df8e71f..bbb190b474015 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h

[ ... ]

> @@ -798,6 +800,8 @@ enum damon_filter_type {
>   * @matching:	Whether this filter is for the type-matching ones.
>   * @allow:	Whether the @type-@matching ones should pass this filter.
>   * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
> + * @range_min:	Minimum value of range arguments.
> + * @range_max:	Maximum value of range arguments.
>   */
>  struct damon_filter {
>  	enum damon_filter_type type;
> @@ -805,6 +809,10 @@ struct damon_filter {
>  	bool allow;
>  	union {
>  		u64 memcg_id;
> +		struct {
> +			unsigned long range_min;
> +			unsigned long range_max;
> +		};

[Severity: High]
Will the range_min and range_max fields remain uninitialized when a filter
of type DAMON_FILTER_TYPE_HUGEPAGE_SIZE is committed?

Looking at damon_commit_filters() in mm/damon/core.c, new filters are alloc=
ated
but the switch statement doesn't have a case to copy the new size fields:

mm/damon/core.c:damon_commit_filters() {
	...
	new_filter =3D damon_new_filter(src_filter->type,
			src_filter->matching, src_filter->allow);
	if (!new_filter)
		return -ENOMEM;
	switch (src_filter->type) {
	case DAMON_FILTER_TYPE_MEMCG:
		new_filter->memcg_id =3D src_filter->memcg_id;
		break;
	default:
		break;
	}
	...
}

Since the switch falls through to default, range_min and range_max are not
copied from the source filter, leaving them as random heap garbage. Later,
when damon_ops_filter_match() evaluates the filter, it checks the page size
against these uninitialized bounds.

Also, the unit test for committing filters seems to omit checking this new
type as well, which is why it didn't catch the missing copy:

mm/damon/tests/core-kunit.h:damon_test_commit_filter_for() {
	...
	switch (src->type) {
	case DAMON_FILTER_TYPE_MEMCG:
		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
		break;
	default:
		break;
	}
	...
}

Should these switch statements be updated to explicitly handle
DAMON_FILTER_TYPE_HUGEPAGE_SIZE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171133.1023=
66-1-sj@kernel.org?part=3D1
