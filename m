Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEFB372EC0
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013920; cv=none; b=b786crku9rmLrjmLwYOvw7sFkBpDVGNpOcJJxl2edLqAjRZT3g/hautpORyjjJZgnYE8q3pKNcBeMUGk2/+xEBazsvJ5JF4vpFRqXXHHt5/cvmJTNRmVU+on42BC1lWkalg4RrCZgOKCoAQua5jGENHHVkTFw4p+7nykr4XacaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013920; c=relaxed/simple;
	bh=PDsZCJkqYHvJuT23ocA9DR/8qgIHC6bJc4KnYn7Y4Fw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ECpvslqrpPOqbiQJ4CGaQJok021IoNJMTpoOY4R/8xHFC0RNbKxgh0Ok2tj1sS2x2EJPBQ2g3TvK0bK8ilAbQVfNuZVc2v9GC7eMSz5hYVzcv3GjP9pWZ0sXJ6UtGk9Ehb7SHhEng+LhT3Vhipr8cy2k4XefwuwPjkcmKTW5eOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSrHTWRj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSrHTWRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B22D1F000E9;
	Sat, 25 Jul 2026 21:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013917;
	bh=6GndKgEORh0plfZAIUAxJmu7j0Q6eHWuPtMvWgwtoPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QSrHTWRjmx9UORGnM+76qzUcpCqHu/jMv8ROSjzTh9VCFAziTShVhFyGHevIGJc1i
	 kycTeT+zpNlCvS74Qlbvht0gCZ7eMZvH26F2wXPOPgasKKI07xj7taK7Xos1I3EGVn
	 Y52UyhhEwF+/E3eUVmMLuOIVxqY+Dy7a+R2XHwZYzUmvQGv73q5/9WEzGxSIYealdc
	 0JJKYOl3kioXe62zdA+gXBRa/4k2Hhzzy9J43GwP/CfwIo/NWAR/NSIPmz1AsJE4cg
	 Ud24dxK2FtnKeePowaSasMXbU83G+JMiK5AzGnL9LgIbCZfKv/I0/TBWZf49uR1Lro
	 LFZQ+Na3LaAxw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/17] mm/damon/core: introduce
 DAMON_FILTER_TYPE_PGIDLE_UNSET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260725210225.129944-2-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
 <20260725210225.129944-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:11:56 +0000
Message-Id: <20260725211157.0B22D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit introduces `DAMON_FILTER_TYPE_PGIDLE_UNSET` but entir=
ely omits its implementation in both the filter evaluation logic and the sy=
sfs interface.
--

--- Patch [1]: [RFC PATCH 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE=
_PGIDLE_UNSET ---
commit 227024f25ad71dec25a7b05a4270affaab5be023
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
   =20
Introduce a new DAMON filter type, pgidle_unset.  It will match pages
that have their PG_Idle flag unset, or the page table accessed bit set.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 0c8b7ddef9abb..a8bb9ee6979e3 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -742,12 +742,14 @@ struct damon_intervals_goal {
>  /**
>   * enum damon_filter_type - Type of &struct damon_filter
>   *
> - * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
> - * @DAMON_FILTER_TYPE_MEMCG:	Specific memcg's pages.
> + * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
> + * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
> + * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
>   */
>  enum damon_filter_type {
>  	DAMON_FILTER_TYPE_ANON,
>  	DAMON_FILTER_TYPE_MEMCG,
> +	DAMON_FILTER_TYPE_PGIDLE_UNSET,

[Severity: Medium]
Is the implementation for this new filter type missing from the filter
evaluation logic?

Looking at damon_pa_filter_match() in mm/damon/paddr.c, the switch
statement evaluates filters but lacks a case to process the newly
introduced type:

mm/damon/paddr.c:damon_pa_filter_match() {
        ...
        switch (filter->type) {
        case DAMON_FILTER_TYPE_ANON:
        ...
}

Will this cause the evaluation to fall through to a default case and behave
incorrectly rather than matching the PG_Idle or accessed bit as intended?

Also, does this new type need to be mapped in the sysfs interface so usersp=
ace
can configure it? The damon_sysfs_filter_type_names array in mm/damon/sysfs=
.c
doesn't seem to include the new mapping:

mm/damon/sysfs.c: {
        ...
        static const struct damon_sysfs_filter_type_name
        damon_sysfs_filter_type_names[] =3D {
        ...
}

>  };
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210225.1299=
44-1-sj@kernel.org?part=3D1
