Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C411F305692
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025050; cv=none; b=hwIw707W7g5R7ZTLaymUAvQtp6Wcw3C+w4e03ZjUkL9GJCabO0zuixEP1xNcLpsdZDwBnJXGU5penp37N+S1DGY3iArnMgZOLtHaALVU3B/z+9J61gaQoSyv9SDEdUkEuwt4Vgh33laiFgAmyjgmN5V2IH4Czjz9xUNeBCFUX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025050; c=relaxed/simple;
	bh=hVJKEf5ez1xC/DH+ZgLQm9kKdJyoH1w80vJMfjQlknw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FelDCQ9Eh1/ZJ30BbtOsdTaqWYrgvaF2Io/ue+K/FwEenZOJCd4OA2hgFbtFFIcgUW4NtCIbr9XOp7nRYgJqgwTjHmUFt+JEhpYiiWsr8202/Ayt0sGAuAPcU5DJj3qQC0B0QsHnJSPIwsKrnOTqLnD9XDClIkEr0TYcQPXBao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ7I9ipS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ7I9ipS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C061F000E9;
	Tue, 18 Aug 2026 03:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787025049;
	bh=YS1cd/eDG/I6/vSfTCexZSH6obt4Nc2pfYmw3KFap2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZ7I9ipSEy5ttpCZA+NzpBBR2e9D7dZ7zDThAj9vuMfokNnzcPMB+FYV2jQoHuAlj
	 tJK5VSK3ra7POqPRss01iA34/pBjsASwv/NPzOdSnHvRsngkg2al+kDHWlhzA7QMT0
	 521uwoTfYVJIKKrMyXoO4bJUcHPO/c/g1cup7jSJfH0qUQF8u+/EfFLKUxS+O7jlg6
	 GziM6Q+vzq763YrEZezlpiDHKnmtYIsK81HT+bTBRYWAsF6wtgy+TDPbNBx6ZxsMyM
	 EvJHoRKouRTF2cS1awBq7H1Y9b7KaCWGClKwT7H8UtyCySbmIt9P+Hsj7ymq8tIZ7x
	 tqEN7hCq/0gRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/damon/core-kunit: test
 damon_valid_probe_params()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Angelov" <jasonangelov@ucla.edu>
Cc: damon@lists.linux.dev
In-Reply-To: <20260818034552.11975-3-jasonangelov@ucla.edu>
References: <20260818034552.11975-1-jasonangelov@ucla.edu>
 <20260818034552.11975-3-jasonangelov@ucla.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 03:50:48 +0000
Message-Id: <20260818035049.39C061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_valid_probe_params() makes damon_commit_ctx() reject probe
> configurations that could overflow a probe_hits counter, a single
> (weight * probe_hits) product, or the sum of those products.
>=20
> Add a kunit test covering each rejection at its boundary:
>=20
> - samples per aggregation interval: U8_MAX is allowed, one more could
>   overflow a probe_hits counter
> - single weight: the largest whose product fits in unsigned int is
>   allowed, one larger is rejected
> - multiple probes: each product fits, but their sum overflows
> - no weight set: the validation is skipped
>=20
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818034552.1197=
5-1-jasonangelov@ucla.edu?part=3D2

