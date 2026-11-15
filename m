Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774721;
	b=WpM6rbOIf3Gocm5Mu/YmvrUu8dtgm0yfub/++o9DxuqLA6xC8ONyqpfQ/SQ/pG20Csyw
	 JudP8dIL7sdpO/3DyOjGh6YEVHywi0dvhBg0PL6FVh8WdXMUP8jj9P/Z+oajzqN8svSj2
	 Mz5WpAJZ01TXFizfwUu5Q/b+xAOuWxIoHelqA1H3hNxCjZwqneevjcn5m84KzShJ38eI1
	 fPU0nuuGc7ynLqvBYOvlzrx3yT/jgbkl0WYxwO9wQKXMcYbaMGFTOF9rMKFLWxqiJabey
	 T1oQrbr72opZpHe2aoxXn3dIDrMeJe+jjw3OGORMPGsp0A/KaGUtt/rkUDHvaFoO94Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774721;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IAzdQRxpUVoRgnnSjSQb9WzO8MU7gdGXIMPPOk7Bq1k=;
	b=vOXJYMmakkGD75YEvAvajrFo+rl3x0rqgUu0DTQ+19k7K/US4Hvs5qc6mzZEwC6RCdAF
	 QbWE16YiNmI6iLf4U1W/yZ31su+C0aPeNwyQJTVlP7RFCVRGhdD/m7IZJkxQ0AedXNVXu
	 50IrXoZBt4JB5Uzz0vegRcNebBFn6P+IStsrymqWczoGjqu4MiXAd4DAWVcAlQ31+CT8b
	 4I6GHnRRBYG0QqW5SuGRaJtMFAR4iktyoosa5LoJOqtKJpp57ZwrR0AI8LPbHDnDcDaqe
	 gutdJlU3987kFmddTvAFQ1wjlUsZdDBC+crx+lKYJO2xZJZaI4H+bbphlKslU4lBLcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6CImSA1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08345606A31F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6CImSA1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE1E1F000C4;
	Sun, 15 Nov 2026 20:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774720;
	bh=IAzdQRxpUVoRgnnSjSQb9WzO8MU7gdGXIMPPOk7Bq1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G6CImSA1AVO7S9Zh2KDS/LHhG2FDkemUC0YZIhDr6xiIavTheTcA5TWrRo8AO89ah
	 jyPvduRg2hZe4U262VknzmlokzPKbcYRgHyM6D+QrHGTtyBF+5p0hzCRxPInJtjvMG
	 THO0TDk1ESaVZ05eXZyfkbS9UplYNmdNkbelF3gxya3BS/OjmXGGorDR8j6Bb+QTJr
	 ZFjNz1jcTGf8dKr3Sf3BLtP9eddnGGaaTn63/SwRENCWw0SkE89MF7jmJX74zoKC4S
	 BkcuG/d8dTO5jouSpQEx0lBfGRD+gWxOvHnsLj7FNz2lvi98oPR3uEH+zyroxfQPHb
	 O6fEjENyeWzrg==
Message-ID: <sashiko-outbox-215822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/27] mm/damon/sysfs: add reports/producers/
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-6-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:31:59 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Add a new sysfs directory, producers/, under reports/ directory.  It is
> a placeholder for files that will be used for controlling DAMON report
> producers.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D5

