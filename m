Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8F4B7A4B
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004735; cv=none; b=HdLTJxuHueS/IoewhDAdoUraxjIe7GoQbXZBSSWidbAFtomOgDtjLeLoyZst7Dlk9ZcGxyQ/0ix6SqgKpOCUDcWtrcbQcH4dW7IqfcdktJ2P86TZYzcmVVAz/BEYKuISCzacJxn6ryoKAUN95p/HzZRpWDHHrdWQLV24kxNg1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004735; c=relaxed/simple;
	bh=iQ4mBY7ezjNbpPY5jNor2Oh6r6/VYS1pS9QN2LC0SlY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TuA+hJpxKeQxQKDjld2Qw5+toO3snz8DH+XB3iymn0+OGoHlAAv7kfQekqnWldlPnd9I7d+6E0lKfQGnjiVrmnNaO6rdRV16Z6J/+qnR0EPaPiTO9vM0gVJSGwixj+yLVs0zZUFjF6FSfoSxe6bFBhrM09uhg1qml+oAV0mLS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIS6BVci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIS6BVci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081C81F000FF;
	Mon, 21 Sep 2026 15:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004734;
	bh=S8rrM9XIvQpv1U9A9FT2rDEp9AHpYANqoQeBAfGh7UI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bIS6BVcir6UMCF7/aB/1ezFNBw6Fes5W74NNVd+vRDYwUwMi3/iGv3pKyEpXatreH
	 0rrQvl+TmuyEOddZuiE9oeksOHhxveU0ecyt461F1h8KDebS55dljX1BeAdSt8GIj6
	 UFuQXQcRBD+zPWVdakNffcwt1UtkJ2i71EM10GrH84gjxqJTCtG+Qf568JFbwoyGd1
	 L/zam4Wnfw7qLuJDYSh5I2yzyqf4LI/XwPqZJfYTS9gqv6ZeBpNJfNC8eEHFrVzX0O
	 NboLd5z8NmGhSuC32PecEKSo6/35azIg9E84jNDmAKr3XPyqAVJGYonLVd2gCKCxFO
	 p6rg7nk2FndFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: charge only the part of a region
 the filter left
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260921152443.80132-2-sj@kernel.org>
References: <20260921152443.80132-1-sj@kernel.org>
 <20260921152443.80132-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:32:13 +0000
Message-Id: <20260921153214.081C81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
>=20
> An address range DAMOS filter that partially overlaps a monitoring
> region splits the region at the filter boundary, so the scheme action is
> applied to only one side of it.  damos_apply_scheme() reads the region
> size once on entry, before damos_core_filter_out() performs that split.
>=20
> The quota charge and the statistics update therefore account for the
> region as it was before the trim.  schemes/<S>/stats/sz_tried counts
> memory the filter excluded, which Documentation/mm/damon/design.rst says
> is not counted as tried, and with quotas/bytes set the excluded part is
> charged against the budget, throttling the scheme to a fraction of what
> was configured.
>=20
> User impact is that DAMOS could unexpectedly slowly run, due to
> over-charged quota.  DAMOS stat could also be confusing.  No critical
> events such as crashes or leask happen.
>=20
> Re-read the region size after the core filters have run.
>=20
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos f=
ilter")
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Reviewee-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921152443.8013=
2-1-sj@kernel.org?part=3D1

