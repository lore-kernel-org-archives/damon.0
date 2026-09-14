Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11738B7CD
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396724; cv=none; b=ikksKY9iXTw0ssoxAwZhluvhmoEvqvAPVYbVw2FyIPWSvtyVDldaJz0Edq+bEAUXvA/5/5gxC0UPT7pPO7eDPYnWOWKxZ1M7dX2YPYeQYxmO5/xzXllnPLaczp9tQsyyALnK3YXhLvDZ8sUTIAgGXbwwmMp0JUTZK/yv8WW4AkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396724; c=relaxed/simple;
	bh=+KURuOB4/Tjd6Dc3Pveq57SVwrD3wyC2d9RVxcH49B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cPb0PEmr5dRK1Vl47BGhK2K6c7lgLnwVvC+BMEYiBXmER5viNd5fUrf0NmS10x8SS/KI86rSF6udHQujgNnd78whDrjJypi0j2wRJPeRX4v3JYXMg1URlCtVbFaNmsyWrfAQe76kGb2+8kfymIH9VsioW781oXq984lq0HeaRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbitVLUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbitVLUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8C71F000FF;
	Mon, 14 Sep 2026 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396723;
	bh=+KURuOB4/Tjd6Dc3Pveq57SVwrD3wyC2d9RVxcH49B4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbitVLUpsOkLJVoHAI2NX1s8o0py1UXXuEw/bRNiv1gMddSaGvWhPHxombmzHs+02
	 TTmpOvU4tFORg++L7H2ODamOr2atzsqdf1uSGbRld3BC9HvyNiUNm83X9mGhdOufzE
	 T8gEBxUl+kaAxtNNFqzrmEkmf2FF9Zsti9FTtXbiFLn3EPZ8kAx/c6wfH828CHvFmX
	 EVVM6zljIbCFxBo+D0k+8aUPZj1LlE2lZUNVoxZgwoCwfqUcduKrCyhw8jCEFk4xP+
	 LxHVu00KmDb/h7sYNNUmKKgESAJlHAW6wdO/gRlvhUtAkgcypAYWKJ2FHLgbc4jNAj
	 XFIhiAXycBDHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] mm/damon/tests/core-kunit: improve
 nr_samples_per_aggr test isolation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914141952.91465-5-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
 <20260914141952.91465-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:38:42 +0000
Message-Id: <20260914143843.2C8C71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kunwu Chan <kunwu.chan@gmail.com>
>=20
> Test the zero sample interval case with a non-zero aggregation
> interval, and keep the zero/zero case to cover the zero-result
> fallback.
>=20
> Also make the overflow case use an explicit sample interval so that
> it does not depend on the zero sample interval fallback.
>=20
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914141952.9146=
5-1-sj@kernel.org?part=3D4

