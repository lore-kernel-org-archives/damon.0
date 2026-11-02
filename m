Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634143;
	b=YrNcCdyyQpcmgVGO8l9rW16GKyOn/BAGX5tvmnt0/653eHNAEbBm+puHEZAzoSf3z4sP
	 laam/2I7+C40H4EzHM1IJIn0fNPlf5jgZlp4n6MdivdSERmm7EmG4ClBf/NQvF4568WbX
	 PgB9B9c3iig1HuOXVdElBtl5jqE9imf0xftXG2jPwai9zRhjOBxpABpgAKDEmicWHCQ9J
	 Ldy8mfeKRXrdq4G+CxxyQzQQnj2wxtsVUXiUgdQVGeCjgq55UXFjSNZXXuWjtxm7dmGUR
	 sKS34yongmmlJKuulsANmrGaMEA0fshKbHMagc379Az8s92bIAakGGInpXQ5kDQvRlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634143;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QAGx15uN7dLdhGIoQatwDfvdWbzTB+LHWJYgV13AQkI=;
	b=Cr+ZnnZCvpCjeYSgDhFg91SUj/CAoj3vDBAffcG8ARaAp156E5nZ27W14e1UdWT+3ag7
	 CFgKiyltiluh+ZCFJqeLA2Xb85SwN/PL8eBANH6P+4PmfhXgAV9NXj5JsHMgnZWTq5wkA
	 YaR1p5Mpc42U/leC5x/np0SHJDJQpJ7oAtylc4KKWG6fURi6EZWsQ6QzC/DjrlYmJKiNI
	 QrtwdB1ts50BDUpecq68H14Zh03gY752PhdcLuEdVhWc0alEHWGKXyBnc0tdDWsp5jgQh
	 9sEvqNaS8AoHcs+JjbNbPKeJiiu8vg/QsqJKXUvYdaeOtcK5XqqlJYd+WfdmH9fEIeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=np4pkOiN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C4607672A
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=np4pkOiN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D901F00A16;
	Mon,  2 Nov 2026 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634143;
	bh=QAGx15uN7dLdhGIoQatwDfvdWbzTB+LHWJYgV13AQkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=np4pkOiN+OafKpSQGCU0AxPiMu+tuQTrxeX7qgS8NwZ3/Rd7FXeX88vmsjW6urzib
	 Y4gV8TajKNKVjyt4GcmSME+NpPpfhhqqWcHumdjmYMiWEf3/m3KN7bhm70j9F2u5qC
	 WMKpivHWcOE0ImudnWI4CFdNN26Ak8LJD9Oqrx5OG6f+FJbx+cAoOV6I/aCv0vZN5h
	 U6NVzncPln9syRTcKpghWpOIPr3HI1kySErxh0Qby3Ux82C3szu4RiyeFyHypLp6cS
	 7z2vRpbcrBPkNA3Ln4Em5uYPaxx6WQOltucGbtJZW3g0QK5+RMpv5M5orP6KpGAb5t
	 7xxMwtC9Sw6dA==
Message-ID: <sashiko-outbox-193696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] mm/damon/core: use only installed probe in
 damon_merge_two_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102153753.97769-2-sj@kernel.org>
References: <20261102153753.97769-1-sj@kernel.org>
 <20261102153753.97769-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:42:22 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Suhaas Joshi <suhaas@s-joshi.in>
>=20
> While merging 2 regions, we iterate over the entire probe_hits[] array,
> whose size is determined by the DAMON_MAX_PROBES macro. However, it is
> possible that we have fewer probes installed than DAMON_MAX_PROBES. In su=
ch
> cases, we end up making redundant iterations. Therefore, to remedy this,
> iterate over the list of installed probes instead of iterating over the
> entire array. For doing this, start accepting a struct damon_ctx in
> damon_merge_two_regions(), and update calling functions to pass this
> argument.
>=20
> Update the damon_test_merge_two() test to use this new signature for
> damon_merge_two_regions() as well.
>=20
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102153753.9776=
9-1-sj@kernel.org?part=3D1

