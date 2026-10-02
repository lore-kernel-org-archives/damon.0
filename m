Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257DD4BEE45
	for <damon@lists.linux.dev>; Fri,  2 Oct 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950466; cv=none; b=Sno3PP4T9PUwssVbvoZ6jWUXY9PnIxKozKBYepJWbJXSyNSUtTx8RHbNTjtIlKXEXaRsFyhQoZZfMV9pzzacDHiUQoaCfKyC+uXn3CT9tINlCg6iVsDD8hxLfoklW53Ivtg2cM9+vhdD15I35vvBkoAAn3eH7nhbWzlmQv6X2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950466; c=relaxed/simple;
	bh=+4vJRMekIHrsHQpr0/5pUA636nHtZUrddj15roTs/AA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dx+dt+LJXstddTF4Ab0i0YsIzSC85h84vn/GyGYH31Fi1yUQONPAtJ+c6JuD6zhHZEHyWgUMIrjLDVrotl22M+0s9tNoo1EnX1JHkplgerwmH1kcIaOkSKoPDP50Dqqp1KhNEj0W+xMsOkcBrDNiCW5AKwR4ZM9hQp5PPvnpWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RifgIKG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RifgIKG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3431F000FF;
	Fri,  2 Oct 2026 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950461;
	bh=thcJqXIv8El2GlsMlzWInuKFbF6xQ7Gr6YF931O0Y/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RifgIKG369XjejzEzgzH8wVD2vzqtCGsSLmnuRgDYZIV3icQad/AW6t1uYZpQLDs9
	 ervx1Co7omDdep7K6HpHaaI3gFnaUEHRc5CPXmcFTlg53JNfJfzfojucgyv721cj7e
	 AzU4cUlX2I5DhR2INMtbay82ZgaWEdutQ5AAxt3C4XcvLj1dndy/qNp14gR8Zam9Yl
	 Qe5+Y6Z5s6Fys86KM1EjpV8qBU2sStgwy1MfLNl3Htn6JoAM4ibu2zGHFRJ8Q7NEEW
	 ezwImMqTbrpjUWNaQ2E/Vr1PwqV1J/r8c0CjsQjryW4N4sxY+Wr9jpM8Vk93+gs2Hh
	 d/3s7euhvMAjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: use damon_get_monitor_folio() for hugetlb
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261002140727.701709-1-gourry@gourry.net>
References: <20261002140727.701709-1-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 14:14:21 +0000
Message-Id: <20261002141421.AF3431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Gregory Price <gourry@gourry.net>
>=20
> Hugetlb folio acquisition is open-coded in three places:
>   - damon_hugetlb_mkold()
>   - damon_young_hugetlb_entry()
>   - damon_va_probe_hugetlb_entry()
>=20
> DAMON already has damon_get_monitor_folio(), which paddr uses to
> get monitored LRU and hugetlb folios and to filter them through
> damon_folio_acceptable().  These paths bypass that check.
>=20
> Use that helper in these paths too, so that DAMON acquires hugetlb
> folios and applies its acceptance policy in one place.
>=20
> No functional change intended. All callers reach these paths with a
> present hugetlb PTE under the page table lock, so the folio is always
> a mapped hugetlb folio and the helper always returns it.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002140727.7017=
09-1-gourry@gourry.net?part=3D1

