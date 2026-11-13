Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585780;
	b=jmVMEtcROgS+/VoAI+jlh0OgZWMNP+usWVN7LFv2rn8L6ogDx7MIdQKwWzHm4k1/8jgb
	 5LYg0z4ZDAac+7+jeCz1euvq3kdDXjCuqRzWCOfM1TMrzI2Mq38WhiPZ8zFuDisabjzVC
	 6mgZic/nU+LND6JgtibnHigU5FfOjsutVV/BKCa+MhWE3TeDRPS+wxTxZJenvKRO85eAR
	 0Q/x4dgESH6i1vqilxsng6AsVN5b21Z7hrvjUen8xyqWw6bObddh+pW1fMT0Pq2EAlqQ2
	 Ff0orP3JpDT0uZZdSF1WcJpTJjPSxLHmG4awT8UurHgHEG2hvu7fwnptaGhYRNKc7Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+C8G8FpsqU13KolXjdgyUS6ojYocyrI4i1FnX41eIPM=;
	b=q7AdOFssggDJy59gE3IdCaykSxZmvRmPAL21YZL91uS+MIaC0lwLqnkdWiIl95sRrKm9
	 T0tHYc6oTxOoe3ZnGFUtIKwxxCUnH7YwYCWdWie4N6/LkACj9MaByEm5PSP6YazbRd6Sl
	 NzkOJK0E2RrhZxuNNvrc06PgPIq2J7Fhwnxk/3UIz6TwwJSLC7Ndu04uOlgCY/UDeQVtz
	 VJGMaepii5RchybX6rPEMAxT/eirI3uNc2N2ObbuGWj6aIqHcqQMgAA8Nfi02VA0oaaP6
	 nPSHYWMJfWEwimxwJA4wMTctQTYbsMZbXrkgZAeQP6wcoRXzuIrJNfQKNNf6ZvAQETw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMbtTsGV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5CA606D466
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMbtTsGV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010291F000C4;
	Fri, 13 Nov 2026 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794585780;
	bh=+C8G8FpsqU13KolXjdgyUS6ojYocyrI4i1FnX41eIPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eMbtTsGVNHyIHmCLcRXmniPRAHVRqvoQBlEF0SZZK2pDuX8DXWawSPNtMhGcc7ABZ
	 gdi+F/NpCJfQKZQ3ZHI2kkHD+FvARBtinKeutzur9IQ6IcY+6Xbz/E75cltEOb6mlO
	 2BpShUoyLYsCnnduoxHzKYwymwLiUyy5OzG47XVpPR+uOQUnO+1e7CMq+PtioAv1gA
	 Z18BJoDp+Sha6IsBgyG5NoapGvSpausGxETE3Y1fC9fFTxwlhHm995OH3g4+JHLd10
	 gNTOuZjX/XynkMNC1VCDWyJfblHLhSjnLwI3sqJAar1K0v21UIZA24+pbPD7ybX9Un
	 JeWG8RAGJ27kA==
Message-ID: <sashiko-outbox-213144@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] mm/damon/tests/core-kunit: test
 DAMOS_FILTER_TYPE_AGE_MS interval changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Angelov" <jasonangelov@ucla.edu>
Cc: damon@lists.linux.dev
In-Reply-To: <20261113-test-age-ms-filter-v1-3-b99eab2f71bb@ucla.edu>
References: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
 <20261113-test-age-ms-filter-v1-3-b99eab2f71bb@ucla.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:02:59 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMOS_FILTER_TYPE_AGE_MS defines an inclusive range for age in
> milliseconds to filter for target regions.
> Aggregation interval can be changed by users or intervals
> auto-tuning features.
>=20
> Add a kunit test for each:
>=20
> - convert region age to milliseconds, correct behavior at boundaries
> for defined filter range
> - DAMOS_FILTER_TYPE_AGE_MS filter keeps correct behavior even when
> aggregation interval changes
>=20
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-test-age-m=
s-filter-v1-0-b99eab2f71bb@ucla.edu?part=3D3

