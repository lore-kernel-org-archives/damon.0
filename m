Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A44368964
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780618; cv=none; b=OVhXJutc/rf28hyt9xygkOg2Ig9McSyb6Jlhgvs0/z3yR/4iEN0hodSutTGsIPDtXx+YEkznF43NjB/xBPfDGafpBb7pYQfKbYqrJNlo9s4QH13qiYBiAKKNUaepJAxp5ME1+/YxZN+uFgj2oUtxXtz548d6bTjuxAzghLT5YWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780618; c=relaxed/simple;
	bh=L3Q0Sm78gPcTkGZUvPSp/Rp4FtqXeQj/FxeQ0RFNtIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HHpbauHOvHiTODQpEeOkYLQJcJ7mVzFPf2Qc/btOgApC8Dhpuy81UWhgfHe9JiXHUGzlXhWN9RG7Mho9I4q7IAavw99xaU4cgWDPrqXKIBHTllZMaJrfJPNEXrRkUW36VCpAMvS3syx9UV/HjlN+bV9KTbzeZvoQdAFns6LXDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E16Hy1mv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E16Hy1mv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6FF1F00898;
	Sat, 19 Sep 2026 01:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780600;
	bh=L3Q0Sm78gPcTkGZUvPSp/Rp4FtqXeQj/FxeQ0RFNtIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E16Hy1mvFSCIScO3fzp1+/G6Nw6dHUTKxp0Tg1mRa0Z6vGv+6FbFCLhGg041wmt7a
	 TED4h+jP4fuJQ/AjrdUtn1NvuwcVF7pY19WONYTYkbwlTLgO5+1DmKOL9sDdz1xXx0
	 bLqn7wCBkcX56lSy4ySIYvy9tWCmmtkmKuP8F4WCcX/2V7qoqvOFKlbyfeQ3x7404y
	 UsLIyj04kKbfa6RwXeUpF6zC5txsGO6zWvNjDPHRRJoIPZA0gM8Nc683XtWu01UGZl
	 L54vCFVJhGlL0uK3P2Uwplf7HPy5mUcs4GtGQlNG9GAW+Ocs7wQTBi94U7yARYfqMd
	 NLeVN7F95VWDQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 6/7] Docs/admin-guide/mm/damon/usage: update for
 quota goal complement file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260919011359.88921-7-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
 <20260919011359.88921-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:16:39 +0000
Message-Id: <20260919011639.EC6FF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added quota goal metric
> complement sysfs file.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919011359.8892=
1-1-sj@kernel.org?part=3D6

