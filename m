Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827450;
	b=WmChGLS6CKPTQN7A/olMxWpovlUekTEeX4/I4O3465Ka+Sdt9ngwGw215Ig14xT2TsPi
	 ny3MUEeJpsW1+O3E1eeWY+CP3bk48uq4QKo8VD/1bjvcAVyptFygYxkVkLb0sCbpnl2/m
	 o6/wixrJxdghbCeEsPvPeOsHqnEKqHaY2q0tqIiIpOycvV8Ki4lfGzIRBfVpDwsnkAaiy
	 kjQmhqO4p505E7SNBhfK+YsKlaJriZOqMITzOIbAYPRKFIG8idSJfZHUj3w9C7zvfbZq5
	 vYWXkJFM+6PPzmefyDWiUprgz96+MGouIkY6I4RX0ZtQcF06tjL/FZaEhkRYgnGrDRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827450;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hKKvKvyNmETR2nkUkZtt7ehxnGoSeRGDmXPDcG2aF1o=;
	b=t7FiGIDg/WZQPVR0mZWw3mI6xgt2/k0qYMWhtT3fyt7QUIKcOIB1mTqwy+6ZEPpBgTIW
	 9gn4FlJTYeksF5AEAVBo9pQmP1qeP3fg6SRr7pDAxyzrjtyu/0BUKQwdBsgatHWh9HpDy
	 8hBxucxsCw0Mhrq0u+JIMmmh73UWcBLdpfrMJL85QvIKl5sQ7LVcLlGufg/Iacxo2xls5
	 R6qAdIrmFbkQkmxnI6gxY9Chr8LvAJ6RVqGLZrnW4wYAndv4BirRHgGYDvRLh0+xrlMCY
	 oTvET6pt+Pz7w0M21kvaPdtlcwC406aWuSgwWQ8D+hwg6wOyoWbMjGUxr7akCDP6p8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHwcFnpC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF76073C41
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHwcFnpC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4631F000C6;
	Mon, 16 Nov 2026 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827450;
	bh=hKKvKvyNmETR2nkUkZtt7ehxnGoSeRGDmXPDcG2aF1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iHwcFnpCb+CCczc+deIdiqSYgbbNeHNkHF0NyWUs0Q5utIM9zmi+ILHw/8AGCcYnw
	 4K+3lHGVPaXq27oNa/EHHPdOUOX8JodE1oawUn+Nus0Ie3UduXGL1PKlKcZTcrA2YO
	 G9Qo1gyOfNec6tW0TlOJRC2/qwTriu7zVTliV80Qe/citBkY/V9zm0pgplXwTilG2M
	 pGZN8ZJSnmDlRlJ3+x5Fre6OGaK6RQ0Yh/kVp82hgalHWJZQkBriIvgB7Kds9n1OPt
	 eTzyWHHuN0G7HhITVLm/YD7lU0BBuDTfREdpUZ5w3D7xXdhmsP4XjPU9jKWMs7uztf
	 znlbRDH0Wiocw==
Message-ID: <sashiko-outbox-216853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] mm/damon/tests/core-kunit: test
 DAMOS_FILTER_TYPE_AGE_MS interval changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Angelov" <jasonangelov@ucla.edu>
Cc: damon@lists.linux.dev
In-Reply-To: <20261116-test-age-ms-filter-v2-3-3b265d59ec98@ucla.edu>
References: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
 <20261116-test-age-ms-filter-v2-3-3b265d59ec98@ucla.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:10:49 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMOS_FILTER_TYPE_AGE_MS defines an inclusive range for age in
> milliseconds to filter for target regions. Aggregation interval can be
> changed by users or intervals auto-tuning features.
>=20
> Add a kunit test for each:
>=20
> - convert region age to milliseconds, correct behavior at boundaries
>   for defined filter range
> - DAMOS_FILTER_TYPE_AGE_MS filter keeps correct behavior even when
>   aggregation interval changes
>=20
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-test-age-m=
s-filter-v2-0-3b265d59ec98@ucla.edu?part=3D3

