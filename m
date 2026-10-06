Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B266367F58
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267515; cv=none; b=oHCqSkhw31ZUa8thANJyF24rBha1NZ5qhLqUxmSwNWliirPGigMpBhv5BaBNhQAkv7cu3+hAxU7mFR2HJHvksTWFYepYYM7Kh1Vhagdc38POqpDqbHA6H/kl86USDlZASLboKKYJMEEJuaDfdhqE4rRkXGIokdAo2uMWmOkI07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267515; c=relaxed/simple;
	bh=gK659i08Ep/P6JR6UboUU84Rh6pPMqYkMNNFq3lSom0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kRLvdlUsmvstjtGJJiSJZZWJ06+nbgTHLA8JDAVFmRJzWoiJJ5NfDEJqsE/qaWsTlicdmjNd+Okd5L7UQwojzH9sioCV4LdlMjpV3R2FYhIT6qxhBMeb+9j39upr/lyBzc3Q5o/9Fl2cq3b09Rm1v6Vmwvk+skBbFLA/zzJRxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWt/pasx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWt/pasx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08371F000FF;
	Tue,  6 Oct 2026 06:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791267513;
	bh=gK659i08Ep/P6JR6UboUU84Rh6pPMqYkMNNFq3lSom0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XWt/pasxi9Cen3+PxwEP7d4HLzz3313exvSdQ+h3tUq2rdGA6UVaiWgVPwrP79Yiy
	 gZ5X6lc9aRzKJNmoP619T/ARUpQfpub1z86HEQHrBikZYyS1udxhez7QaehC47mIbd
	 MqXyqJdSxi54rcAG9I9l9QyOJvFQYy2HN7Rd2ERMJQutCVy5SNopyB/r1NfOKgkCf+
	 W/14nqkM7xu+Lz46Z4zjHTgbCQNx1ImFv63FA2ihyOwgdh8zQbb56VAU7r/R9egjjo
	 B1Dy4+rBkWmVUkIzy6DVbdHrkKiIJVXnM6TXGjdyk90htLMHP+xDXSkYGeZF7ly7+B
	 //n8VCXFbwLHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] Docs/admin-guide/mm/damon/usage: Fix incorrect
 option syntax in perf example
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWRyaWFuIEh1YW5nIChMZW5vdm8p?= <adrianhuang0701@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261006061549.627-4-adrianhuang0701@gmail.com>
References: <20261006061549.627-1-adrianhuang0701@gmail.com>
 <20261006061549.627-4-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 06:18:33 +0000
Message-Id: <20261006061833.C08371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The kill command in the DAMON documentation uses an incorrect
> option syntax in the perf example.
>=20
> Use kill -9 instead of kill 9 to correctly send SIGKILL to
> the perf process.
>=20
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006061549.627-=
1-adrianhuang0701@gmail.com?part=3D3

