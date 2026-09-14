Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3F368D51
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396770; cv=none; b=gzqsZlobWldvg01H5KlM1Ib4F22jL5Di7wUH0W6vmSR3jmuC6a23ZKLt5qc3OSb6Q/MlW0nopDFHtunpEe4RxHJ5oi9uy33GEEsKCtedSLj0lrV8Z6avocFT1ecc/7kvhM+fnHzp9D5MqY3YEbrLsYD/2ve/TdZS1zWTc/5Iloo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396770; c=relaxed/simple;
	bh=byVPTMiMiVACxunp6aNfuooznWz2ekGISHkVAoS4Eqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hqdW8HVoQYThLpM8geQ5IR2G47i0K2ZaNlRnMelDp8Q9e2loAWRgQn50Q6HYYlKG4CiFB5rwiK3Ze2E0a46uxuAF+5wIoKxlpl/+S3NBx/U2uV1XihyrZg3gXvdOmhIZYXTBskwC1tngJUsmjOtDdAEBlDBaDdCIJOyu1cgpSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjqNwhkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjqNwhkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C5E1F000FF;
	Mon, 14 Sep 2026 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396769;
	bh=CbRL6/efy6iD9HkCiTbn66gOMNoC1TbnI7tOfrhCk9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjqNwhkBjkLz5aMT6g1304AHnToqQn++f6xzp2kSHJ+fTVs91FHs95ZfPoZrDfg/S
	 kfcn++tAHsZgv7xTK44I+MaCHqXKDOU1L7gzTxXvzgHsjgbz+9pfiz6FByt2iBBeO9
	 tLncwxIfV5hvRSmzi7874lGZlghFlyY98GWogmLf0gDtf/6C3pciRCKPKqm4ob78lW
	 7vtUm3MX1+PM4ztr3JVJ/SyE2MROz7ZbhDBiX09oqmh3Bk49/YLXKwQ5lh4Dm9TSGz
	 +3IoFFfi6iE+lBhr8y7hg6ODZoi+FZipaENdwiuGAp9e397bY1+7lglOxo5olyh9lW
	 Wnn+tDZPglw9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] Docs/mm/damon/design: clarify when qt_exceeds
 increases
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914141952.91465-6-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
 <20260914141952.91465-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:39:28 +0000
Message-Id: <20260914143928.D3C5E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Liew Rui Yan <aethernet65535@gmail.com>
>=20
> qt_exceeds counts how many times a scheme's quota has been exceeded.
>=20
> When using the temporal auto-tuning algorithm, the effective size quota
> becomes zero once the goal is [over-]achieved.  In this case, the quotas
> are still set, so qt_exceeds keeps increasing once per quota reset
> interval while the goal stays achieved.
>=20
> Clarify this behavior in the design document.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914141952.9146=
5-1-sj@kernel.org?part=3D5

