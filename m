Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203A27456
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241358; cv=none; b=M1Lw0oH2AjOYayActKbY1rm4ZUXGgdjGE2RVK8/S0dmZW/7yu2XEPwcTsuJ2S6m4ypGRQaDqXhP+tDZj5SsAbuvt4ABJw7jN5xNa8SOnU7+oAvAZSjX59CnI4zTE5nBYjAfER8AzpfpYs5KCLLFzZN85LHKIH7rDUrw0McvEyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241358; c=relaxed/simple;
	bh=zyWJpHKrEnh4v3KynyYUDuaRs6bV9gaT3HYjcDArOGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YEi5ng59mUuu+FF94eKzusTifqBofuwzp2QUkqK8/hVzfL/nEBz7BwB15sxMsYjFjj4qhmeTOyNfkK0c9cVrLHhSgq7RvlQ5NoPcFjU+UAy4T6BRLvbbe9Q3cVws2YZxZr/1kqgue4RlKit9hjcJRbgbvbC/FdfefIs7D8+MilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffsAspm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffsAspm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BE81F000FF;
	Sat, 12 Sep 2026 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789241357;
	bh=RAUS6+pVO81JJgDyuh28Lly9ifh48M+Vl8dGrYLSAp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ffsAspm4iQxqotrTgak4UzFP85h+Y0qQbnTF+m43wKEpnIFw6N+ZOMFVJYlNSvV2L
	 K+NgtrMJTeOuWVoZaMN/y/dUJ70uhjXTnA2DUfZKOWNYQRGQVeHXTR0IJCi46P9Fdu
	 cdYejkBusvKCnN9X2uSPlz0+qgwJezLI1rE4cRoYONOIxGWfdPGj3xt4TVzHiLMcLU
	 kW/VxJJENXZsNcBL2NhlP7zy/iCEavbUWP0CGBkZyS/TJUEexFN+Vj5mzNr10vHvKd
	 leEFmOvAC/nkDjsI/DXGiGAez4JwzYUXRYMzvMdea1oq33esSqA7niZv7sikKok+mB
	 1UmcI6OWft2JQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/8] mm/damon/core: return an error from
 damos_commit_filter_arg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912191807.138502-4-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
 <20260912191807.138502-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 19:29:16 +0000
Message-Id: <20260912192916.F2BE81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unhandled error returns in DAMOS filter commit functions lead to u=
ninitialized memory use and type confusion.
--

commit f2946ab5f9d35b397a925510dc71e57f307f11d2
Author: SJ Park <sj@kernel.org>

mm/damon/core: return an error from damos_commit_filter_arg()

damos_commit_filter_arg() is supposed to always succeed.  It may not in
future, for example, if the given filter is invalid.  Prepare the case
by modifying its signature to return an error when it failed.  Also pipe
the return value to its callers and let them handle the error.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0c98f7e267d07..3ad1fb2f21f3f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> -static void damos_commit_filter(
> +static int damos_commit_filter(
>  		struct damos_filter *dst, struct damos_filter *src)
>  {
>  	dst->type =3D src->type;
>  	dst->matching =3D src->matching;
>  	dst->allow =3D src->allow;
> -	damos_commit_filter_arg(dst, src);
> +	return damos_commit_filter_arg(dst, src);
>  }

[Severity: High]
Does this code leave the target filter in a type-confused state if
damos_commit_filter_arg() fails?

Since dst->type is modified before the arguments are committed, if an error
is returned and subsequently ignored by the caller, the filter could have a
new type but mismatched union arguments from the old type.

>  static int damos_commit_core_filters(struct damos *dst, struct damos *sr=
c)
>  {
>  	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
> -	int i =3D 0, j =3D 0;
> +	int i =3D 0, j =3D 0, err;
> =20
>  	damos_for_each_core_filter_safe(dst_filter, next, dst) {
>  		src_filter =3D damos_nth_core_filter(i++, src);
> -		if (src_filter)
> -			damos_commit_filter(dst_filter, src_filter);
> -		else
> +		if (src_filter) {
> +			err =3D damos_commit_filter(dst_filter, src_filter);
> +			if (err)
> +				return err;
> +		} else {
>  			damos_destroy_filter(dst_filter);
> +		}
>  	}
> =20
>  	damos_for_each_core_filter_safe(src_filter, next, src) {

[Severity: High]
Does this code ignore the return value of damos_commit_filter_arg() when
creating new core filters?

Further down in this loop:

mm/damon/core.c:damos_commit_core_filters() {
	...
	new_filter =3D damos_new_filter(
			src_filter->type, src_filter->matching,
			src_filter->allow);
	if (!new_filter)
		return -ENOMEM;
	damos_commit_filter_arg(new_filter, src_filter);
	damos_add_filter(dst, new_filter);
	...
}

If damos_commit_filter_arg() fails, does this silently add an uninitialized
filter with garbage union arguments to the destination scheme?

[Severity: High]
Are there also missing error checks in damos_commit_ops_filters()?

It appears damos_commit_ops_filters() wasn't updated in this patch to
check the new integer return values from damos_commit_filter() or
damos_commit_filter_arg():

mm/damon/core.c:damos_commit_ops_filters() {
	...
	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
		src_filter =3D damos_nth_ops_filter(i++, src);
		if (src_filter)
			damos_commit_filter(dst_filter, src_filter);
	...
	damos_for_each_ops_filter_safe(src_filter, next, src) {
		...
		damos_commit_filter_arg(new_filter, src_filter);
		damos_add_filter(dst, new_filter);
	...
}

Can ignoring these errors leave the ops filter in a type-confused state or
silently add uninitialized filters to the destination scheme?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912191807.1385=
02-1-sj@kernel.org?part=3D3
