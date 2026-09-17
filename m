Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769A390224
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 04:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618287; cv=none; b=bw2t/W2mW36eOWNM6di2oVUZ7RTUkIUR5BgVvg6KZXvzn5hRnUfqiZEf+CA2VQvcyhd+arIA6oiWTYTJlm9bm9/TTMjZai3vO+KWCAaZ8Cx9MNQIPsZ+jQtdiCRvsm4yWr9jF3KY+yAhnbE1QmnPhnqp1amokUY3UPOv26mi44g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618287; c=relaxed/simple;
	bh=rGBRScrEn3vGgzXLTwVnRmdP/LyWDX1d/AEFf0lNZQ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EoazvHAuWXuwXkgkGlBlaYK+u+di2gZOUb6F127wd8JuzjpA5djIK3iIUd5kSa5djwsN+1iQNCqFB6oTrQAcRqDq4JopQrx9G6ij/XEtUREmDjyob6GELRUawAVgLTCnVts1hr/VxqqJZw3sNT1FcAK43Ek0VxhzEe1IWd111Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtWqwy8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtWqwy8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E781F00893;
	Thu, 17 Sep 2026 04:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618286;
	bh=ZtNem7k8f+La/I0FCqQFwtG7EnZ1YOiKtoMtk2h3ipA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BtWqwy8fS+4fjHfBiCrj5OFozx5CcPCpZd5owdGrF6JcLJQQKyEwy8CeERGIWjGgc
	 phlKfOJkKCnYsUSbK7u/Ia9O45EEctyCNfEYNLEElLGA2Fx5aBAKLN0chbS0/gpyc/
	 +l7u0A7apvqMPqWSFzhJzPuy8QPB+jku56kKopgRn8w95MJLGIfqZxSD25E38vn8Up
	 lpqpVM9N9f0FIDoCndqB9Ls3mZcU5VvJyItmarCeTh4I2bLB2f4SFI2KfSbj69syam
	 xfEZeo0l7UZYrdHMSYwsaGAyQ3wuW6XezW1RW1e5LJFnncwEyGtdu2sgVTa4nV4pd8
	 x1xpJw1Luw3HQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/10] mm/damon/tests/core-kunit: test
 eligible_mem_bp commitment
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917040537.107341-8-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
 <20260917040537.107341-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:11:25 +0000
Message-Id: <20260917041126.13E781F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> There was a DAMOS quota goal commit bug [1] that doesn't update the nid
> field for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric goal.  Add a kunit
> test case for confirming nid commitment.
>=20
> [1] https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040537.1073=
41-1-sj@kernel.org?part=3D7

