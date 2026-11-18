Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988038;
	b=GT11G6ypR0wPYkMk11b1MiPI9HaoIp1e3Pe+C63tSs8ck/xEXVCUuHLQJqrHk6uJoXsY
	 CW3km4zPomGTPuvg8ZXeYD/Put+zUzqrLdqAPSxRGcgdB6hrKhgwz+dFpC+xWMM3Df1QK
	 wUSEEnEIAYveLevLcUmUr08G0dQVUql1jCCm2PNknODRnbjlfe06SnZiNL2AxrRxQ79kf
	 fxWVZ+q3id2OKQt2JhFy+BSjJ2UNY3cN22RSVW8R513ShkSvrTzGO7rsC7UFUuKtmdfu0
	 Oc25/ijsN5Iz/cNEJeuvmb7zjVbt0YUpPcr3VsI6Jf7mo9/Z/J3HsvpMHWzFHbq7Lcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sPXhasoJ1P0el0PjtZ/lAo2LPDJtJ/dTEJS/DLXt0nY=;
	b=GPqAvaYloXgpl76n+UXYz+WZG9i6MgzRZA1wk36Rcjra3XxPnJx9o/l7gnsI272AC/Xh
	 ZLXbJsoJWx807hG0w2k2Mb9kBu5EJx+FrSfh0jooOD05nbsU7iyGHyTRqoMtePs6jvKET
	 XjV6z+0YIi0yl/OUGiGkJE0jJ2lITghx2Zh8Sdv6uPp4vuiWrgq1m45S6XgbcIMxnIEOq
	 /w+ZZACSkF4L0XccAq6Bxcf7BJyw5Be86Y6fWlqB2+NLX+iVVi9d16gdaxyo6oJi1eRCN
	 vWVbOZn/EZFzyHGnWiGGof+H7AYM29mECClZ1ZfT4sxVvh6qrdPA+cOqR5a2hAFcVeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkdHak8Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556B606A337
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkdHak8Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CE61F000C4;
	Wed, 18 Nov 2026 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794988038;
	bh=sPXhasoJ1P0el0PjtZ/lAo2LPDJtJ/dTEJS/DLXt0nY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IkdHak8YyC96ECGt07wT8KGPSSwj9FRamrARtx7jEVPlaiGJNhOtfkGkasFZg2jyF
	 rO0gKpK85jSTUBx/qR7q/qM9k4w+TgmPK6Fobx1sfZH3hwoOSJuxC1NApmEdWPtns2
	 PU1oZZeAzH/gAT9ac4Cy/SUdwpASZShjiwNVkn6XC0GfSXMqZ/wiNJVERoKH98ab93
	 qB7pWj1kBnhovkZCgksRU4+PVT8iNpPILCpExeyRXSXSbl/9jkhx66xXbrSnSMIHg/
	 9EOuRDccTdfVDMw4HwJzmkOOn4kYeTJMyxSMTg/y4Vxx2IK6kQVUiIUPx0DFsdlGvb
	 gg4KwVKkq35Mg==
Message-ID: <sashiko-outbox-220354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/paddr: skip non-LRU folios as a whole in
 pageout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118-fix-damon-hugetlb-pageout-20261117-v2-1-547a65a3206e@gmail.com>
References: <20261118-fix-damon-hugetlb-pageout-20261117-v2-1-547a65a3206e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:47:17 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_pa_pageout() uses damon_get_folio(), which rejects folios that are
> not on the LRU.  For a large non-LRU folio such as a hugetlb folio, the
> loop then looks up the same folio once per base page even though
> pageout cannot reclaim it.
>=20
> Use damon_get_monitor_folio() and skip any returned non-LRU folio as a
> whole by advancing to its end.  Do this before the filters, the
> accounting and the last_applied check, so that adjacent regions within
> the same non-LRU folio are not walked by base page either.
>=20
> In an x86-64 KVM pageout microbenchmark, traversal time dropped by
> about 99.7% for regions covering whole 2 MiB hugetlb folios. For
> 4 KiB regions within hugetlb folios, traversal took about 1 ns more
> per region.
>=20
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-fix-damon-=
hugetlb-pageout-20261117-v2-1-547a65a3206e@gmail.com?part=3D1

