Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE9E2DE6E3
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139333; cv=none; b=Fq+u/gtAYkhLHaYhbSiV0nalQtsNP4mQwb8Att5fkHxYN2OX8OTmaI95sCd5jfT7U3WUZc910w2nhoeFVcTIdMsRuJdWsJyOyJu1L+0QVyxCmMKsQr+12VODcM4o4rr/zSRqUYJ3f3akZekKnLkDlvt1rSRGUXF4E3WMwZw1xT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139333; c=relaxed/simple;
	bh=72IcTyGu8T3HsTfeMeysCGQkugvB+R6zY7bAqgae19E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KxImA3z90qUw+ffSS7caZS5F5t4/KwjKyt1S4P68nBjEe3HlNRliaE58zKhd8cymuSnXocXjD6NAYNsSuyS5QmdrdrVmlC7ISDqPd9pCJGCiH87hFIcbrc1GPPOJmu7gq+ZPs7rTG4yHFryhpnnT5MsDvs74dCK3k9ZlL/p7Jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5U5i9P4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5U5i9P4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE27A1F000E9;
	Mon, 22 Jun 2026 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782139331;
	bh=qwPbFWngrp0uIMeVZNO8JKdsUiJcyXChfHO3XJwidCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5U5i9P4igsf06CDWj4cQL2uD6uE+ifM6Pfjug2eoVRpuY6GjGOjp6hc7XRt404l4
	 HZotT/TMHmBvKuEFqPvkAjTgpMs5TNtGXc6gGaZEKIcTXo2Pcv1CdLCVrpv/5Y2VC6
	 CKTXyQgz4yb3Zgd6QSRQ0Nwl/sJ0DDNWMGg1m0yAKrO0SL4bGLnaABqf9P9hILW9XG
	 bR1IbZgn0BePz+YxBis9ifOe61GEzEHAfiOieZDJUFzbvwR/aX+Oi0CuyBnWH9M1Ka
	 tew8MIiENCTy3ocEqWShcyLQoy1c3rQPdAkueM77bl9nPKg/3aw1aGmq7LR1hi2vLo
	 FYJ4UGTYGGKTg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 04/18] mm/damon/core: handle unreset
 nr_accesses in damon_nr_accesses_mvsum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260622142139.30269-5-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
 <20260622142139.30269-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 14:42:11 +0000
Message-Id: <20260622144211.CE27A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] damon_nr_accesses_mvsum() incorrectly returns stale access data =
from two aggregation intervals ago during the aggregation reset gap.
--

commit 079525184ff6b3e5e3e7c3387647af444428cb84
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: handle unreset nr_accesses in damon_nr_accesses_mvsum()

This commit addresses an issue in damon_nr_accesses_mvsum() where unreset
nr_accesses can unnecessarily inflate the pseudo moving sum. It adds a check
to return last_nr_accesses directly if the remaining window is full.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index bc40a6d10f277..8a7351b4a27c2 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -268,6 +268,9 @@ unsigned int damon_nr_accesses_mvsum(struct damon_reg=
ion *r,
>  			ctx->passed_sample_intervals;
>  	left_window_bp =3D mult_frac(left_window, 10000, window_len);
> =20
> +	if (left_window_bp =3D=3D 10000)
> +		return r->last_nr_accesses;
> +

[Severity: Medium]
Will this regression return stale access data from two aggregation intervals
ago?

If damon_set_attrs() is executed at the end of an aggregation window, it
advances ctx->next_aggregation_sis but intentionally does not reset
r->nr_accesses.

During this unreset gap, r->nr_accesses correctly retains the fully-aggrega=
ted
data of the just-finished window, while r->last_nr_accesses holds the value
from two windows ago.

Because next_aggregation_sis was advanced, left_window_bp evaluates to 10000
in damon_nr_accesses_mvsum(). Does the new check fall back to the
stale last_nr_accesses, skipping the most recent interval's data?

>  	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
>  			left_window_bp);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622142139.3026=
9-1-sj@kernel.org?part=3D4
