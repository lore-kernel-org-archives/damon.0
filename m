Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272895;
	b=bRgazCm15AFvO2nxgKhX1Wx7Vnn7zkuNjwHvxrMeBn7aIPh5SQ0cZR6GFy1wcfj4/VW9
	 11cXdmGREW9vQREyXrg11E3UiYrxjwkcuu+QWcbLHEqn89/Zgvy2MYJkzp2W7EEFcHvEa
	 lw8GGInLAEqFYrZjAxqO7wNkwopTBHUf4iQtKNN0WppTt+SQa6ERAufg8pbTNgmCAXavX
	 gQU8CdT0KiKrwhyDGNKGekQPbbw/2qRzWDCZrFeuVVZ8/98iMC+gEynZ/nObJK9fKkmQS
	 hHXt/AHVOHwjMEgVhHusLPM66N/FXCCdJbWI7yr82uZeT/0dzsdQdWix3fwfrau5bFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272895;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1CCmTrgKu0Y6qSwR7W/7lNIm2pexAYB4aeDVUnht+0g=;
	b=WQ1VIa7nne0iatLcJziNbKrAaYDkuYyOcYHLFFm7oWA7tmTxYR/nnWh8wEIBvJAvvN09
	 lgqeW7xGWtanwIM7I06u6cm9mdAJQ2vlnWEmz98BdhtUxiob6D6glq6HoNXIqnNNtIQGK
	 OKGAmNhWAmZWhIEB5mJSWHF51MSznsmWPiWj2fFt4ufTZesFkH2utwHZzNEWeam7DqTcs
	 pdWIkBXSXae7qFinBBRyxHru3CUc30uYp3/PfhCkW6VypZnpt/mKwCvWX1V0/CtFnC98h
	 koEbwu7ttWlHsqyJHDEtnh/6DcN2h2f8FR5UKLTTvMvHBpvqqo+XMq6AHYuMnTKIi6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REAit+Bv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB657606A321
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REAit+Bv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B4B1F008A1;
	Tue, 10 Nov 2026 01:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272894;
	bh=1CCmTrgKu0Y6qSwR7W/7lNIm2pexAYB4aeDVUnht+0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=REAit+Bv+2bvNtp+Ngxpa5+n/Ty1Q7pHevXUhxzu9ZtVF8yymlFPWq1nXr11SQb5E
	 zvBzsgpYkUjTtA20duBCISIlWAz4XXb82wVcBUwbGiQma6pjczduaL8mDS0Cs4naa4
	 ph0Ps8nswl0KgkcBAlSY8eOwSYkraOAR1rOwHMq5N6rMk/YVcbEA88qTMGe4T8Jx5M
	 9Bjq890AucXIDFcVXt1ghjSjkWH04swI9XWNbj7ILmaGxGuT4LrKLXRZ3jsbzFANxE
	 /6duyczYalQUT7yxFSfTGkN2jZEch8YbviL6cPCfkAB0uq9hWfrjRsREBB7TTI3h1T
	 kMybf9BMcTa9Q==
Message-ID: <sashiko-outbox-205942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Docs/admin-guide/mm/damon/reclaim: improve language
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110010558.104905-3-sj@kernel.org>
References: <20261110010558.104905-1-sj@kernel.org>
 <20261110010558.104905-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:08:14 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Manuel Ebner <manuelebnerli@mailbox.org>
>=20
> Fix upper case.  Fix tenses.  Replace 'set as' with 'set to'.  Add space
> after sentence to make it double space.  Rewrite and refine complex
> sentences.
>=20
> Cc: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110010558.1049=
05-1-sj@kernel.org?part=3D2

