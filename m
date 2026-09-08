Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131E54DAF7
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875696; cv=none; b=jVcb1Zyz2JQPUXrxkL7xmE7bH7RKyQy7WlJxly2J7jrVrLrWTzx5La8gJtdXqhF0E4ZiX7d2HtFgObfKccoD282UKp3iuU4fKESqO8emQzIFXWYpRMo+b5I6mm0KjcmAAagiIp392/LzqS12xTm8OcWmZhrONDbsHbWq/9VpBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875696; c=relaxed/simple;
	bh=VVM1eok7As9i7a27eClmqUVswZaYepJbRXReH7wqqwo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p1Cl4bgTxXto7YQQw/8bZdLSZQEj2rZ3wDo9lvG0MuHI39+OwaZaVLEGWBXYUycdkWTuUyvU6EWbq3dlSm5jrnHov1WQhu813WRsL6jopXV4HvXwH8k/CrIaqX1FZwWJZ7qJs1Bltr6R8Ypk3QpBzKUkgss82HNCB3X7XMmGDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+NZRwvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+NZRwvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5B31F00A3E;
	Tue,  8 Sep 2026 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788875684;
	bh=MHPmflHW8TdNChviQRUuBNIsWw6wVmfWQoYngP5ezx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+NZRwvl4uZk0jH3mJS2ab4GKIbSsuWMI+7NKypiwJ3+crTAsYAgnLfqV7Ur3sJ+f
	 d3zzgAh3zWKlBZidCGP3USNSDASJHo0mDErXHbLrWwLgyC80iVGntxdm7IlNpEvTqi
	 gE4vNAEBlSU+4ktQGmPa3lgGT/IhcMpopYz1zI3L6t3idJmlfKZtRrjSKvotQW3Tww
	 j/J3iK8EbUaW9XzbMY/P4xJDI1AHgwEgx/aX5Ez1P2scgb4osP5R3wM+uQGBR/BTPw
	 AceapPt5QILfmNiUnFxV0tVMN9wkv/VmATneZwW3yZu3PqoPK6JdNPiTKQMJUY0SJK
	 WoSFJBDNsFAdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Docs/mm/damon/design: fix broken :ref: usage and a
 typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260908135257.97523-1-sj@kernel.org>
References: <20260908135257.97523-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:54:43 +0000
Message-Id: <20260908135444.BF5B31F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>=20
> The Statistics section refers readers to the DAMON sysfs interface
> documentation for how to read the statistics, using a ':ref:' role.
> However, the role name has a superfluous 's' appended (':ref:s' instead of
> ':ref:').  Moreover, its target label 'sysfs_stats' does not exist; the
> correct label is 'sysfs_schemes_stats'.  Fix both.
>=20
> Also fix a typo, 'frequenceis' -> 'frequencies', in the Adaptive Regions
> Adjustment section.
>=20
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908135257.9752=
3-1-sj@kernel.org?part=3D1

