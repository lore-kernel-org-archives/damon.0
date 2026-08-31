Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078DF36A377
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199602; cv=none; b=jjd2OjCQaKWoMzvThhZFrScNclvPuH7P2HhpnmjV5NKnpTRxuEg4fm6ik/bfzTU8wZAjRKf+/IzbisTYMYCyx0UoIW6NTN24TQxgtv4ICgBkZXUDfMLNeqgbKxEseWPvj8brXzlLMioEBa5cttd81gaPP4Aq2zrbJrs0t7q5jZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199602; c=relaxed/simple;
	bh=Lt9ViTOV02KlKUF0Ul4MKvbg5JbuMuZNDD3mdlqBgKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eMxd7WkhGOPbBy6X54y4IETc1ZxcDk65y2NADeACTiMA6OvoRBqEMU86zHkaL5SYgn5uROmWyAXLk4LYBssEqVVBOv4q/BEjlUTHoV4QXpF/cj3TSjnmJomHGp6X/ZbkS22CXgH8ZiWn3qHTlAvJX4hIh1dCpuuL6FzKUQdYKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzXYraG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzXYraG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879101F00A3D;
	Mon, 31 Aug 2026 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199600;
	bh=Lt9ViTOV02KlKUF0Ul4MKvbg5JbuMuZNDD3mdlqBgKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzXYraG7XxISK6sALsEqF3aNmZ0PS3tB9ImB/PIlcNq6JOM79BBbuGGoQyP4aCz2I
	 +2N4bqBsYnQSc9sjl8ReXZce+EOtFDiAVIKSB/F57bWYLG+sact8r7sfRNMFHtAwxq
	 KAHiWSalz1pBqsGhXVhFwmlSRKMN839p5dMDpOME4gwiDCv6WqsdtPhD4qdmQc2PCi
	 CSkSe/qpNMzrQA9Zy6+BiVEXFfxakSdod5INpkk0YwGZt6pnsZ3U8FTDwCH/T9dANW
	 xvkz2kVfp2X/lGVlAaDajF9w6Dc6Dfe3HmI3Iq8lGDuDrQF+f5EKdPir+mmxXbg41T
	 q8wG1RmTXbtZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] docs/mm/damon/design: fix typo of
 max_nr_snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831150227.83416-4-sj@kernel.org>
References: <20260831150227.83416-1-sj@kernel.org>
 <20260831150227.83416-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:06:40 +0000
Message-Id: <20260831180640.879101F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Liew Rui Yan <aethernet65535@gmail.com>
>=20
> Fixes a typo (nr_snapshots -> max_nr_snapshots) and corrects a grammar
> error.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150227.8341=
6-1-sj@kernel.org?part=3D3

