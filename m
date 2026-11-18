Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968340;
	b=mGt2ts3YnH1Uxgc0dNO8hmbex+G1wHxNT0dIBKmuGuZnN+54VvV87gnHgK4eo3XPXVX+
	 66XZNn9wmF8yHDRBFeDy6I3PJJRPhQ/W8VFOItgC9yHK5lCoWJfCfDj65NZ0nfgahZ0CQ
	 6iyJbEhbSrkSc+XRcPFduUHqg4u2EULE4pi+Udcv2wqePrugpVad/eF7uz13AjxNdYth2
	 X4tOr7QSTN3UE3wEhBaWOyBM+DgedNgH5dm0nysBGt9z1dZOgtBv8aENIYE8Gf5mGRpZ8
	 a4GdBVAmvi3wyJGit3ZQPIGlJF4W88+r6ZzTFecZosKYTCJkQ570VBN7d5muVYrjt1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968340;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0QuAID6gYCgQHLnYu2K0S2/YQFv95gs4xYpBZYbbrMY=;
	b=nAiyRmn5lEWdNAiTFTTRghIbpM62CPt2lQV5d5fKobRxYQO2P7OAYEHllSH9Ay/jUkR0
	 PW3oi+gARnTbzdpMMQfcgVZu+9wT5+uXl1Wau+HFx32CdSchEESsVjP8xsIk4bpPXJRnG
	 rKjbtGmDaBX3Ff0qUUy72nFi88XcIeWSXu+uZkafjj091U3v+wTEwo0z+kuCnmkoP3DTJ
	 ctdeDkeoy2lFk2qsghcOpmRfvNoNtLBW2g3q9k5WYmV5zobCE+1qPG3Dw25EWyvqTt9lY
	 XzmA7HLHfcSVKvyTL7VjmhLcE7FZBNClRYeuIqmAEoE5eykhiV8g0wUz+W6YwRP0U7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyWxjUBT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F130606A31C;
	Wed, 18 Nov 2026 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyWxjUBT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4C31F000C4;
	Wed, 18 Nov 2026 02:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968340;
	bh=0QuAID6gYCgQHLnYu2K0S2/YQFv95gs4xYpBZYbbrMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PyWxjUBTcge2zprNhDW5qHno/QbUTPi0FHn1B6mxQ0AZp5yajfTuET3DOHi2jWL04
	 c3/cmNMroDwrMWdgmZ5UD8F4ALizOCi1ih2Vi6YsMe37YfwNbZJM1AqwryEsqpa2dG
	 mk+UPwwHbyJ3V99nnrIr6m4nDASTQD4iWkwtL3w20ndnpXBfi9tmMfqz8kGfxgdwX4
	 OJkfHhOEu/PekVgSwJr/j3YP4fwjGvK78CYFTKwniMsNKZYaabR9jjbTtBgadvpVjq
	 mRLmVc+1+u+JstZMu2X2f6/eXiDubM2bIdo5faiE1dzGUJn3GoeYHGkekYSjQrZAh4
	 XGwN/a9/ZMMfw==
From: SJ Park <sj@kernel.org>
To: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: add test for damon_call() on obsolete ctx
Date: Tue, 17 Nov 2026 18:18:52 -0800
Message-ID: <20261118021852.99595-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117172219.26725-1-saileshnandanavanam@gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Nov 2026 22:52:19 +0530 Sailesh Nandanavanam <saileshnandanavanam@gmail.com> wrote:

> A newly allocated damon_ctx has call_controls_obsolete set, meaning no
> kdamond is available to handle call requests.  damon_call() should
> return -ECANCELED in that case instead of queueing the request and
> waiting forever.  Add a kunit test for that.

Please check my suggestions on the reply [1] to your another patch.

[1] https://lore.kernel.org/20261118014632.95656-1-sj@kernel.org


Thanks,
SJ

[...]
