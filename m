Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8E3B52E7
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871976; cv=none; b=kkt6olR59RU6VquULajJ+hY2WON1yYmo6ql78Rj1WIwGR5MR7ZM0PE/bPRdZ/h2cEQfweGNnc7NWZZqFiGOAylftjpJFuLwilHTRDC85oArlLuP5REepibgvw+4VttuXoHy+UuDmotdfzLJxKp/4BwZR7xVwAkJOuO9ADu+wl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871976; c=relaxed/simple;
	bh=ajB4lOZx+IR/ppOFJw4x9DqGnimz5mhq7yxvPN12qfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uPrrrvEg71lJ8vqfY6ea/WMFXBRQaY/zHxC/UkchyKUHcgaqSU7b1ANPKd9HGhedguNXnA7/E8zdb6ruPnhujgD2g/FE0twAqSwCWX0NooPNFKdI61p26MZKSw9avTZutB/w3feZpyuDmOSlN2gLuSwbXrVjcKZgXmBAKUoeq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku1hGSB0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku1hGSB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCD11F000FF;
	Sun, 20 Sep 2026 02:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789871969;
	bh=dpcsn70ImJsLJ9XM+qRQfatli19xp9AsQa7lATscPCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ku1hGSB0XokIv2qJeRbTHKRby6OaP7xUm8YxVvr//r/hgBGyiwNH1jJ9NjoFVfA9q
	 Q96Dt4hmaXezdyhAZ+5cuo+B2t7VkDKJAGKx41AiINH2FLWYO07W0hkfQ11bp1IDWp
	 ZFs4KejIkm7xij3NTKgd4UVFIuspUqYm/xQWy8NXbSXLgq32QeD6/p4qiZ7WILcDOz
	 KTOoXAv99lMrmkHwEMbvPFG3cd2GygNLphKyQJtOl8dz+Beqraml4LWjqi/0vZGiMH
	 7tKQX/jvFTgy5oGv21freOPxkp6M1XEqcNEfqKmScpNA95r6s/r0w+Ye8MjGgdld02
	 2wd4nhlg2Jo/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] Docs/admin-guide/mm/damon/usage: document the
 temporal tuner's quota limit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260920023111.2466265-4-donggeunyoo.kernel@gmail.com>
References: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com>
 <20260920023111.2466265-4-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 02:39:28 +0000
Message-Id: <20260920023929.0DCD11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The temporal goal tuner converts the size quota into basis points in an
> unsigned long, so a quotas/bytes above ULONG_MAX / 10000 does not fit,
> and is handled as if no size quota were set.  On 32-bit that is 429496
> bytes, well below the "echo $((1024*1024*1024)) > quotas/bytes" this
> document instructs.  addr_unit does not raise the limit, though a larger
> unit does make it harder to reach.
>=20
> Note both in the goal_tuner description.
>=20
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920023111.2466=
265-1-donggeunyoo.kernel@gmail.com?part=3D3

