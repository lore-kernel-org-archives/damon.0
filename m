Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176135B657
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267551; cv=none; b=JejrInIlDmQwo7vrgCEKWQTv11f29fP88kYsN1WCkU18Eu68FCbMrHbupJhSkyKrPHa3Q6YEVp81HgGb81WS0hyKcyjeh+gct8M9TJavUQlWe4sgWgFOTymxMc+JRMwVlm/SR7dFQV0gdIdE+LmNfZeVl78kn1g+TMA8VAIipGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267551; c=relaxed/simple;
	bh=NmRSkjxr7B/0bcmkVshOumIMhxk1F3K2rziL36XPRLU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X+SLr3QuxRmQLyemM+3NeTVPqzcA26+BN7BH/9K398LOQOaLNS1IKePhD+12bTgqcVJyiHhC/UTtwdvI4MkU1JF0zZhw9MTmsJ4Udk6x7TWcxmjzI9F9hQhGjDfmQLDuK6n3gKiq8qOb73Xt7/ck7KjzrSOqcyn2DbKdAy5EVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSoTLQS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSoTLQS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9111C1F000FF;
	Tue,  6 Oct 2026 06:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791267549;
	bh=ShnAQ1DG0PTA28tahC+8etYq5ORYT5KQfO9gRs7ewjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSoTLQS9SuRCKiUlrpKFdh5B6/dBbijnqGxPE0r24m14Fetm7vaV1csIwDziqnafJ
	 +VC27Govi1yTwYj4OkDDrf3vG90ZojnXt8GzvXkSniwPc5g6MNmTjUznmTtTBbpSC6
	 +IF8ge0331C2/0TrC9wBM3ErJ8AWsDPudQVmAoabkh0APmB7SnVYXY9hxOnjGqVFtL
	 WRDdk07lTwE2MRyXY1JJgABSRZ0S4uzgpyX5VDAzn1N0sLgjZtUaenqa/0duL+JJtR
	 gBRbUo6I/FnqXeprFi834LPkE6ZRFIc5Z+Doi/F8r67vUl5TGoef8ri25uAwtf7g8p
	 VOMDbqko9WTCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] Docs/admin-guide/mm/damon: Fix various typos
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWRyaWFuIEh1YW5nIChMZW5vdm8p?= <adrianhuang0701@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261006061549.627-2-adrianhuang0701@gmail.com>
References: <20261006061549.627-1-adrianhuang0701@gmail.com>
 <20261006061549.627-2-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 06:19:09 +0000
Message-Id: <20261006061909.9111C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Fix several spelling mistakes found while reading the DAMON
> documentation:
>   * trusworthy -> trustworthy
>   * DAMON_RCLAIM -> DAMON_RECLAIM
>   * charget -> charge
>   * hetmap -> heatmap
>   * colun -> column
>   * evelenth -> eleventh
>   * idlee -> idle
>=20
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006061549.627-=
1-adrianhuang0701@gmail.com?part=3D1

