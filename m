Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478617;
	b=Z3i4yFqf34lOUz6WuHNrympUt/cJ/vK2kVBQkM0O5jDGriBPNyClrBEKxuIomgzAKwWB
	 Dw8GR/DzG8pr2J79bZhROu9s24SQ8twNZNam6vGMOaBsq53vYMIfIwEM1luJD0iOWrIRt
	 y98i2drX/29GeXzr3rJnWW0HFdkdY/+D/FlNIWBxPm3fyW7YYTyDsFmLAEfq6e8ZZ+OxP
	 gu1LeZCyeyabwmICtT3kdEpDO26vC12Ys35tetNRuIVAm25/lhh2Aay8hfJ+BJDk7Mltj
	 xGekiV9RY+pRIKtgzaE56VGnilCwMasasfE0TZUym4fCk8iZVY06QbK8c+dbBmabo4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478617;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1fDqTaTnzItqKJiEa93o1780rEP/4xwBGI2TQgrlyQg=;
	b=xFaT8A5eGwtKrYhooXjMUGh760C419DxrH61Cgy9coG3e/XCwVtKGx/xXZkfeVSBczNa
	 D4lcx4lI5/Z+5pytYLWmYr8/dWjYrKLHGbbHv0POe6aD/J8p57D9hVZ5NgMKuUMWKZX+x
	 iKtvySwVDcAqz3SjnFPQCFRA8chkuN+uu76kGuvP9aAG0eX5M+Lkwdps6zLtE4Tszz62w
	 gqOMm5ZoW7R9h0+owR8w1jrkUOsPshebUL67cXu5Cf8LK8eW9qPVAtroA3CH6wPB++1Zw
	 qBZunPYZkxAKlCytbzDSOeeDsznFpIY9S06IIpZy/S5H/5XdCRHgXSuGUHhW++TCHQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pbt9bVrE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D1606A31D
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pbt9bVrE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E501F000C1;
	Sat, 31 Oct 2026 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478616;
	bh=1fDqTaTnzItqKJiEa93o1780rEP/4xwBGI2TQgrlyQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pbt9bVrEd1lNTNG07X4hwXoP3tjVXN14Ue1JZALL8CnEdd1hNMV4m59EXjUodj1s8
	 z7Pjk7YZL3/QIYyQpf1sWF7xMQ5mOj7P7yV+TA2gOJnVW5A4ahF+gRLrCDU01t8Mvu
	 DtjjM5aMJRVte+OPwtWvkWEINWV3yOVS7KdWgbr4SRdLinYilfrvWCLBXQs91Z988K
	 ysSCItZP8HW0s1XpqNTrjw4ahelBZ1YxbHxQuDPWsdfK4Bpfo2WkanXuDsoqXSL4gX
	 9gslYV1pJAhMdUBI+YgF7bRNU1HBdaF1Br7aG3mGdoUzTM1aQypjs+5F1T6OMK7ySd
	 xk1oQzSQxIh1w==
Message-ID: <sashiko-outbox-192116@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/6] mm/damon/vaddr: advance migration attempt in
 folio level for filter out
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261031202614.96036-3-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
 <20261031202614.96036-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 20:30:15 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_va_migrate_pmd_entry() finds folios to migrate under the given
> pmd, using a loop for the pmd address range.  The loop advances in page
> size if a given folio is excluded by DAMOS ops filters.  DAMOS ops
> filters work in folio granularity.  Hence it is more efficient and makes
> sense to advance in the folio size.
>=20
> Advance the loop in folio size for the ops filter out decision.  For
> that, do the folio size based loop advancement offset update before
> applying DAMOS ops filters.
>=20
> Closes: https://sashiko.dev/#/bug/linux-67c34df7-6dfb-4e18-9ce0-0d26915e5=
785
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031202614.9603=
6-1-sj@kernel.org?part=3D2

