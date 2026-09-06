Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CBF32B132
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720715; cv=none; b=bYGeddGs6PeFLdbxJqzztZpb6Yu9g0gEWDgd2ClgwkbHLbnMF9oajktKd2OJDdh4KAgthM55SuiO7oYuO3wyh7dR3YEjG4ul71atqtTNePF6O9jC2XKjIB6+S89r+WEppwStuHJpkX9NK9aGUKmCk5alnIrwA09//tHs+JzYr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720715; c=relaxed/simple;
	bh=I0v6PLFH4FPjSwcvklGY569pzQno6C7K+rOgw+FCjkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AoMhbmttG0hRwN5aKES5qBpJ2U4r4FAU/vctfCgjKiCe6aILUHWPcVX4GYboQAqk953uiBdYWP7wMwNUGJdS92fj4UZSBI4s1KZhzm/QBnxaMhGmRXXgDeRNI51Voiryp4Ych4EBFx41HVS9xI9cS/VHju5NzqjidxD9F5X+FO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzXoLegO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzXoLegO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8A31F00A3A;
	Sun,  6 Sep 2026 18:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720714;
	bh=KhWhpb8CbTuva1YBBHVoPGgo7FHm4cDNalIItT5QhMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SzXoLegOPI/CRZkkR9rK84aFD733bB+0tlvDL8IT2N++jElpPhZE2Qo0sfExojIW1
	 2JpjmNMolZ9g48NmvCVW/g1dePFTNidGsoBliil0lxuuqWcT7imTBQix14vxMy2tWg
	 bRswBuAaJZH4zPJbrCBhxm0ZzdU1LioJD5PspIrzvsprw1oh1uTJfLdEz7xSBP/N/o
	 OClX6baWI3KfCbsdIOcAvcom4QNkAo/ojmmMZ+3eK7xXFE6MJbMElvxYZl320PjY+x
	 QgQSy85a1JtpxmafikwBzq+LhV186CP333NDwbMyZUbQoZFR1Ws60rtVt1Mf8diXnd
	 IklPLzMsmIdFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] mm/damon/paddr: move probe filter handling to
 ops-common
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906184417.96621-3-sj@kernel.org>
References: <20260906184417.96621-1-sj@kernel.org>
 <20260906184417.96621-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 18:51:53 +0000
Message-Id: <20260906185153.DB8A31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Probe filter matching logic for anon and memcg type filters in DAMON's
> physical address space operation set (paddr) can be reused by virtual
> address space operation set (vaddr) in future.  Prepare the future by
> moving the code to ops-common.c
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906184417.9662=
1-1-sj@kernel.org?part=3D2

