Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026465;
	b=lNle1YxoIuOXKAO3wwuKDPfGiZe1GR4PManZQH0WSiTsYrS1oFOHmMhL99WTqUCupos1
	 cvYZ3Rr5Hkv+Y++uDermwCfV1T19omSQGvzNGZ0sOs3wXQ0ELQRQ0abMH6oUs8KDnwWHk
	 TFtp/L5fkZmPjjIhW97CV3th1+Hb+lv/OpNyZKt+pGAkPANfHPtlGsrJBQK2qKeDuZ9mg
	 ly3OZDzn6wOkWAq6+KhF/ynL823wcCl40MpN1PCb5H6HSLrtyvSY384cRvEgJ1cl6JvfD
	 oiPcWq/SuU7I0J0m4G+ckCoP/l/ZjMo4LYB0igQxYZiCS8ns2sQhOqpbpF2lF755fIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026465;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AsSM5NtB7qFzzfdTKjGygUEvP/PLSZ0yfQxJlbFW6Yw=;
	b=tMFFOKWAyjV9FqhDqqSF7rrbRPxboVx4PKj/+aGUTb/MLZ8zGg+3ifV2PO2CrkZ5bNdV
	 fOnUsBoOGFQB+XQeyzaeXyO9wwbaBBWVBA3tWW3pBH9y0TChEuaEp8qyKTZR41cHyDPBx
	 fYRam6BU1Irt0lZo4ll0ArfCC1Jl9qa3/RmoUHkD48L34XPQp9TpoMkDZ218jZKawkwAd
	 FzFpyX1x/YNzH+qsx+5N/tONoPr0Y1LcWCmHOfPAjQ0NEvNJ5bL8kIt3NFPAv0BlcVbFQ
	 qExV5SULF35nof/L/QP2WRKSvumNSp4zRmr+BXe61wRjJD2Z3vdRKNNbeEuMwXCqwtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM1Mmixo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F8606A31B;
	Mon, 26 Oct 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM1Mmixo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27A71F01825;
	Mon, 26 Oct 2026 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793026464;
	bh=AsSM5NtB7qFzzfdTKjGygUEvP/PLSZ0yfQxJlbFW6Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mM1MmixoH68pbNiAXJycnQtTEeaPFCUPUoB+GZpt9547zsYusm/yMT9IgTdypw2Un
	 ZBu6oW11WvFBctxkQ9r9U0nE+i0JoF/FsCCYdNFPKqgQWoCVw+3nvSyowzRtIxdIVC
	 4ZwTJA4xAp4n5FSsoqU9jP9AqvlVFqXzkDp3W63INSFFotBWKAVJNSFOUy7zmlTvXO
	 nuTdgLOVGKUZN7d3e6lRziBkF9A2kcVBjcrNxLS16k3BLPYURoe1xP+xoj9oT1rz41
	 AdfUZOINoJtz9giy7YSM1s84r+HHDY5IQCkxrEItZFa763FeuKk95RO8niShmBt5n7
	 PG6c/k1JR9eQg==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] Docs/mm/damon/design: fix grammar and typos
Date: Mon, 26 Oct 2026 07:54:16 -0700
Message-ID: <20261026145417.150739-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179301327249.2.12612582132957329203.damon-docs-grammar-5@gmail.com>
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

On Mon, 26 Oct 2026 22:14:37 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> The design doc has quite a few relative clauses that seem to have lost
> their verb, like "pages that assumed to have" or "filters that handled
> by the core layer".  Fix those, along with some agreement issues and a
> couple of typos: "Parreto", and "Use space", which I think should be
> "User space".  Rewrap where the lines got too long.
> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
