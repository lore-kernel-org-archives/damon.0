Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856795;
	b=3nRY4xBniTBTlSDoelUvDYeOPpAd1BrOexJEYVpkbzxNEuMFJ8KHB4oENBAkZ05rb0ou
	 JlVBAelbagcjB2yCQCOztygJXtlBq5dAmcZxADC5SrF/xjnN3UQn1a/tA4GaUdSYLn98q
	 TRWm41FGmAeyab+SVLsFCQ/VQhEcunTzByczS/fKckWj2/IsNN1CHsU2j98G9ZHQqLyqa
	 itvYF1tcWGUq1zdD/94YU5KgMKIgcJxH+cPJrujWBN5T3IQ6ndJlRrv81k4WqeUGX2dId
	 hvkkRzosN/GmbwWNehso+rc2H35+l18qfwP+I1DAPXSwiqwEmEla3J8XCp9kCh5erCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856795;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8fK3Q9n1y+rBvCK4KLOO222W62rV6c+2637N/sS4Gsk=;
	b=4dPLaV+9gAtKAsoqvEfe3tOW/WKFxt++FGm5f72wWnLXaucANokIHPJkOwOOehOXjRb0
	 FvVODMDjx0qTliLuRiRFPgOpVKEkUJGlqdR8G7wj/RFaVUXEVICdw5jzB6vUQqWntOOsr
	 HUKT4u2MGljmcRol8q07jGWBPOiAqiBjPDBBU0Q4uURyOiaqTbWcbxnlfLRiPI2RD0L70
	 uiQOrUlK/4egUKykLg4z0PUlMhomQsxBpifuhjVYEDnr4/EKq82LdW1QrKzNzxpjar8px
	 LNMmma7H7zWKrY9zaz3u87FyPoKq60lj0SJX+VnK5ksmUDsLveOpXtO8wbL1wVQ1hGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8JnHnPq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EDC606A322
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8JnHnPq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B051F000C4;
	Mon, 16 Nov 2026 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856795;
	bh=8fK3Q9n1y+rBvCK4KLOO222W62rV6c+2637N/sS4Gsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F8JnHnPq371xHjhFaLcHVULIASjyTuQPD10gDf3FDRip4kx7aTgNzuU6r4pWGMo32
	 7pFN+se2i5IltWpuZrbP7DigzufEAPqJKEFWSnXhmzGiNhtglmIClyKeVJFVye7wXx
	 0ovHYOdxtOEh05v/trKWzhnI1PUrpVPKA0YGnJfcalljE8RtrZGgtFc4wk6e7OqF/A
	 BRYcgQEHsJ+V50Mt5JBIU7DIYDD6Mo5/woAA98JMsOrTKy9AhWmv+63txLc71xTy9P
	 Qz34WMkOIvgDZMVs/d2psPAQOOBcCs1fNMeFyLtUL+j/h2vvDaVCGB/C9hU9ddeuNE
	 VEMiKpgzDkgwQ==
Message-ID: <sashiko-outbox-217547@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] mm/damon/core: introduce sz_ops_filter_passed_last
 stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattathias Pinchover" <mattathias.pinchover@uber.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261116-damon-sz-ops-b4-v1-1-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
 <20261116-damon-sz-ops-b4-v1-1-1cffe7227e6d@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:19:54 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
>=20
> DAMOS stat sz_ops_filter_passed shows the total bytes that passed
> operations layer-handled DAMOS filters, accumulated from the beginning of
> the scheme's execution.  Users who want the amount for only the latest
> apply interval, e.g., the size of a workload's anonymous memory that is
> cold as of now, need to keep the previous values in user space and
> compute the difference with the help of nr_snapshots.  Because
> nr_snapshots is increased once per target per apply interval, the
> computation is complicated and error-prone, especially for contexts
> having multiple targets.
>=20
> Introduce a new DAMOS stat, sz_ops_filter_passed_last.  It is
> updated at the end of each apply interval of the scheme with the amount
> of sz_ops_filter_passed increase in the interval.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-damon-sz-o=
ps-b4-v1-0-1cffe7227e6d@uber.com?part=3D1

