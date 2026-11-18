Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984035;
	b=J82MIkjiVLs5oyNWCxGKc1OSYgpGaoOoXtLFnHJxCbBOdssHOqZZACoqOfxa/Ld8PnJF
	 fIULl8gGlzwmhukhmzWrqOc58p381N2PqolJBCW3hEelCmePceaeqDNOhUUobxrukBgbN
	 4zcAH+qlhGQ4vVirD8ltrDLvinHLgJOz1G34dekx/gGEhlA/n0efBmgZpd+yL79LcW0TB
	 6bo7+XdMNAXNRzL1HiyduBhOI4fE76TcU/FARCw0zcWgq3gJTdQf5gzubtb2ERFnCyypu
	 mu6Wkmchg0wdMnLxwlb3iZVSJGyivT3aUon1qtjk0pSC/5SLEoGWGLpJBk7kZJHvbOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jh13ceJPr4btQ035CTYtA5KepnW0odUPZI1DFco8Zws=;
	b=jkDKJCBWSySXmwesrdHHSczc6z53glPEYKwpVPelE1/qPZoz8+wZMxm08vBrLNr7c+6U
	 Wc5vG/++HvLIWhePSqZpWk8Dx7XpTzn5XgzFlqPsNnEOAws/rIa5RxiVc4WkFrqaSaSkg
	 kF/1AHryRNKIH+sJFI0OouP9KZfFR7mzB0zYKVgOFRy7ZMzFaq0Vb52SD2OOqPrEbUuFb
	 J23OxKqJ7bFA/XaEPGf+9v3XU7IPb9p1kVbM9mobSWce5nVNDzeeKcQYPxSY4s1rZsRP/
	 O7uB4FsQCbTTso2FJVLqOw2zd5ikydJ/rHJ1qfO+lXfx6G5Q5TxdxeSerH2GIEdjY/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sdvh/NRC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762A606A32C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sdvh/NRC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F1B1F000C5;
	Wed, 18 Nov 2026 06:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794984034;
	bh=jh13ceJPr4btQ035CTYtA5KepnW0odUPZI1DFco8Zws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sdvh/NRCsTBwLTf+1aOJI+oWxrtVCLiY1Zu5AIQP4wgGr9yagwaHRU0ysAF619cQ/
	 2gbxbVd29hLibIM2QjpFFvRet70T4N+g80t4ju6i+oEQl4c6XTxPSaF4/rHUUcOT0N
	 GNhKi16SSy3dsEj3azO3CkVPniACvtEL5515L0NJM2u0VXkaupIolNri+mbckJEeL1
	 MJVuON/bFuWJidHqVvUCsFtDQOnUcUvrGgKOb7ixEDsBZZQt9wTds9/KcuBONzJr7M
	 8EBvSz5BTRQcLxrsPrSVc3pMUZDL38pkf/OmRlSoei/3yDojB3MV5lsO9MmSWgLlce
	 MKpPhIF15wYsA==
Message-ID: <sashiko-outbox-220267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/core-kunit: add test for damon_call()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sailesh Nandanavanam" <saileshnandanavanam@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118063755.37749-1-saileshnandanavanam@gmail.com>
References: <20261118063755.37749-1-saileshnandanavanam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:40:33 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> A newly allocated damon_ctx has call_controls_obsolete set, meaning no
> kdamond is available to handle call requests.  damon_call() should
> return -ECANCELED in that case instead of queueing the request and
> waiting forever.  When call_controls_obsolete is unset and
> damon_call_control->repeat is set, damon_call() should return 0
> without waiting for kdamond.  Add a kunit test for the two cases.
>=20
> Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118063755.3774=
9-1-saileshnandanavanam@gmail.com?part=3D1

