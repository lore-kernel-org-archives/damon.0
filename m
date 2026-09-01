Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0773A75BD
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237746; cv=none; b=TMwgRX7NJtND5C7PS8Lwcr7KIBP7+C02uJd0lVfVg9ALCsKgfSJQJZ3ME0YWSpaKf5ZivstmpwI7PqCfou4r/VZu9KxL+6kzM9mjs1n9LhSv7OUj/VnJvAkvDPvPdgF0UR6cjatFq/YddHOSffCANma0TuVkK1pcnqXeVQu3mSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237746; c=relaxed/simple;
	bh=b1kRCI8YrTeaEUI/r60UavhgOVYi+gnYwAD++67MQxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KijCrp5TsyPmexUm8hX9Gmq11UQkjSogAgZ7jfuuH9WgoavFEmvgcGSn/dLybGQVZoqv25/4fz9gLjOUt8X5HzDCMnZV2FqfhsEl9YvCY2gySKEQRkmR7pRq/a5VllK2vVbdMv7VFGGr2rUefS5KxgABuM++Ob6QCScvr88lDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv1Mizfv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv1Mizfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357DE1F000E9;
	Tue,  1 Sep 2026 04:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237743;
	bh=b1kRCI8YrTeaEUI/r60UavhgOVYi+gnYwAD++67MQxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fv1MizfvkDq08Kns5FK/PG1t5aFY4vXA/3yH7zpfT2CAkgwjFW7RnS/9aBmfQigyi
	 IvAfEdnodgbttGi4NkZXUUDTlqGIqunH1ZCrqwomMaFfkIct1xznaBHHl2RuRt/YbO
	 nhPRQ3QfSYwR/Y36ALvO5KckCh5TuJSPAcBWoVgWAX2PSa054MYwzsAPlHDGyGcRkU
	 3eKBRznrqap0L5AFZh9v/7OVI/GPIGn5vF6rLXew7JrBNciuhOjUF77HR0tTruSm6v
	 35ne9QMSoLDuN3UyATc2RvrmvrzFvX4k50ftE7IWLhG/EXT23EHKeKnqiRsSsshkBS
	 e5j2+hVwO/apg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/17] mm/damon/sysfs: support pgidle_unset probe filter
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-4-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:42:22 +0000
Message-Id: <20260901044223.357DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend DAMON sysfs interface to allow users to set
> DAMON_FILTER_TYPE_PGIDLE_UNSET by writing 'pgidle_unset' to the probe
> filter type file.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D3

