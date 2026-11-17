Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958051;
	b=vY4rDOXpj2nZ+OXpSStxYdJFhzCDfcKrJT/p0GxReq31ElVVCbAxe2O7/4hjcaXZAGg1
	 v0pTYBuGERGEXdG0Ej6TXN9E/hwnJ/jXajbCnUmVXBNlkfGGRFo1t0T0GLFZJyG9mzbqs
	 vgQdT/Sv1Gv/aaAM1/qEYwiqsFrMqx9oAqCB7Q/cXmokGwuSAA+iZJc8idvi+V7HDOltt
	 MBts0QsZlF0gmzLBqRSu5nw0OhBqWOg7ylpgDFay21iHk5lFQlKwhO/KdUbu1HzeRUPou
	 hPubBhaXWCX1kVHvGnfiYlnlFA/ZpiQkLARijjGfQEB2Ofp7hfnlvo6oJ8c4F2JVQ2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958051;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lq2/gbsAwWpX91AkMIG+PELrP3GUhzvzwoS0i8v9+R0=;
	b=r9WpnEnFN5z97cItfrcUiz1WwJj+Vhl0csdHVYSmFSRPgrOG+m5Ehih6gH3kGhfLNDYJ
	 0yvq0ebQPvU+iwP8E1MzyDm2DnCnYDoh/SGMvVI+4QlpzpKGbWRXLKlrmt5ZhbxirPbsZ
	 kEhZYZ/DQ4RuzA5cbclOs+kmp7prJ3bpJAK30rlrtt6ykIaW+0jZiFaXW9uba7OxVoUe2
	 UxNjVZy4l4munxybMTjNsEqlHDiRvhoRLsjdJAvypkHOjiQPgaudGPUVMOWmYZKOsPeIh
	 e+MG5EfhOPgVqBkh4iQJoljvOj5GQuhQK6o5XjQb7tiiDDJXv7urdljkoJMknmGQ9FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvSQzcnm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE0606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvSQzcnm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2A21F000C4;
	Tue, 17 Nov 2026 23:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794958051;
	bh=Lq2/gbsAwWpX91AkMIG+PELrP3GUhzvzwoS0i8v9+R0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EvSQzcnmXxir+yKgy48XWqRCwFEJo0ivPpaFtJATCqc8HnJ33BVhS6bEwR+Zl6iXq
	 KOGwxoNltfNSU9bCHH3nSKu3nUzptPdLgMV4oBeuViYpOiXfwuZ4uZTsOpbmb0e3AD
	 b2awkiRJuaKPU/MHOQKIApNEgq1w5CJrzIs3zG2ubErGzrhoeikqc6T6HtJzqOXjoY
	 Ho16rjgJOfPUAdIlKp5S2vIxGjv+JLsIF+Y/LBSrnrFmZ5n1H825Cq4CT2UvSEZugV
	 h48tcpj//X6O6FCxvkxn6wnE29gKgdJ5M29kxNyTn6sn0muauCRLtLXXydwkE2soLz
	 FUxO2B+S2ytuQ==
Message-ID: <sashiko-outbox-219794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] mm/damon/tests/core-kunit: test
 sz_ops_filter_passed_last
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattathias Pinchover" <mattathias.pinchover@uber.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261117-damon-sz-ops-b4-v2-3-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
 <20261117-damon-sz-ops-b4-v2-3-439888fa04ac@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:27:30 +0000
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
> Add a kunit test for the sz_ops_filter_passed_last DAMOS
> stat.  The test runs kdamond_apply_schemes() for multiple apply intervals
> with a stub apply_scheme() operation that reports a given ops
> filter-passed size, and checks that the stat is set to the value of the
> last apply interval rather than the accumulated value, and that it is
> kept unchanged until the next apply interval is completed.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-damon-sz-o=
ps-b4-v2-0-439888fa04ac@uber.com?part=3D3

