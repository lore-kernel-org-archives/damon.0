Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF84BFE90
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050256; cv=none; b=VPOkVxQXyO85QSMcJ+xnKVktR7hCSxXu+q48enfujk+qafc6Xgi+a/tJbMVm0r/pSsP5FSpq1gZBvIJr+KqGHpQ1tKc02YI8pohv1kcRFSwJG2KeoTaFAhIHO/VfwHdAl4Mu1uW9IcAy7RXa/OsfKzvC8idFHZWGjfj/oYRn3/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050256; c=relaxed/simple;
	bh=YM37jsRLJ0dpuenH2sXGFfZZyLMo6VVVQ/9Iq4wIXs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nIdQSphKokfYGpjWstFfr/KJATd5a5yODr1TBzq/oa+ZaNABIKPPwxuOAKzKp6tUb1lZxIqm49nmrmcjhXlyK/+F0N4Us/tpYAQaAWlMEThaTxYWL6JmZo5zEykUAik3VeZDX9/GMfsT9gXUydffqovEn28SeEWGYFTVoBU60Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8oeDRg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8oeDRg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F10E1F000FF;
	Thu, 10 Sep 2026 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050255;
	bh=zHot1FzcDjGctANTf5Szb5d0fROA9ZcuIf1xnsrL/Rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X8oeDRg5XnR71uS0hlKs1xZfuj/HeIl5rlvqdPDWI8wvEpL2Y90NO/8DC5U/a3jWE
	 2wZp23kzIHThyzJEr7Gos9/DKasrE8yfG+z//t20mYBZsRp0Umle2TeEWNrjheh8u9
	 R1MCJJ2tPWPeyckf48y5h3z1SQy4QAs5Z3ZGB4OoBW7bSLe3fxBADEVvuuEdjDhZE2
	 ZYK961a5FbAEO3DXHjzUTxH1VZlczAHr/YZ56hOAs6e8n9CCYs7kcBN5Ly2u1AhzY7
	 SNacyilEN//ucN3RJ8tkG1EAeqCeCpDjgwD8VQ/f/YkQQorsBV0W1iarxk3efvG+64
	 kECUaT+uDvs3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] mm/damon/core: extend probe_hits_wsum() for moving
 sum based calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910141849.170896-3-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
 <20260910141849.170896-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:24:14 +0000
Message-Id: <20260910142415.1F10E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_probe_hits_wsum() is being called only in aggregation time.  In
> future, it could also be used by DAMOS.  In this case, since DAMOS uses
> its own apply_interval, it could be called in sampling time.  Then using
> the not yet fully aggregated probe_hits could result in suboptimum
> outcomes.  Extend damon_probe_hits_wsum() to get the weighted sum based
> on moving sum to prepare the DAMOS usage.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910141849.1708=
96-1-sj@kernel.org?part=3D2

