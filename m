Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012117;
	b=5D7Afi6TOqah6PZ/cL2R5KgK1llXOHOxS4N/AlWpSh//N0Ua/rR1AMQXBI1BuTdxhPH3
	 m8m0+TdFWIC9DRvzu0+51wALbRzJXVrrckUO9SxhL4538juxwJd32s0ZQi1Kriqzw6ITD
	 1tMcm8dKnfSdCihQyvLvD9r6PmdRt5woy0b17D+tUJqsXkBDuSdhDp5vLrHXvnMJP0/cJ
	 xw9UsnAFj1VslnqCopmwO3WniClcqPVnljC9ycq5GVDMBA2w4htBcd9j4jz3hL5v3UgwM
	 h3+MdnomLOFosw+a24TFQxEJeqzsg2yBcvRCmy05xGEvQHk725ihf/C8GNeW2MUePwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012117;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GUT52vgyJgPuz0uybFsuYJgMVSReQWxsEW446+mnG/c=;
	b=ZRvZVDzT/44hu1RsciX7uaVIZo7QVoWJ5Ditq2T2idp4Wqm21ggZ8rpZVDYRiU/80p0Y
	 QpF/+PAsyg07MbO4ReJ3CC1ECNLXgygKyGauQ8A+ZnK8TB6Y5TGfoPnN59mF8Hw9V3kQ7
	 4dgbuOri9i8OOm9/YJvBDv/YVo/b9SU1RA0vO0B5x9oVXAkbZgMOm6gVS884CC+wlDekI
	 NgRTnloqurC+sOtv5RE6XwmFl+je3rCLesvfD8O5vBWhE0hNElER+b6c9UBB3DjU+kOEV
	 X1WQ8J+WX22TBYBeO3h7+mkf0e7YJkwuTNoaRCOGpf8iiqP9jSTAT3P8GTbQIR6OGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kog+7qaZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAFB60A2600;
	Wed, 18 Nov 2026 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kog+7qaZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1881F000C5;
	Wed, 18 Nov 2026 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012117;
	bh=GUT52vgyJgPuz0uybFsuYJgMVSReQWxsEW446+mnG/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kog+7qaZykWYE2vmZ/oH75pfch5xTnHflU8PorPT1BHhJGz7cxBdAf4dIILq/VQgq
	 Hit16GWSGZjpiJxNbNDcRNaXe0uZj7X9F/UwdTcUXH0+V3En5Hk21w5dxkSXxAnwvL
	 rwrk+GinlXzbEaFMRyUodCXQCnPz1OGSvdemf2P/q6uiJfNYmb27xjRhzUrv7H6W+g
	 OXVohld2oiuFRgPx5r6mO7wm3Tt3oSomxX0dZymKO6RvQMXWyEIQIACJu1eZP7zk2u
	 uI0yMdf0idyVkZagkDkHqKqAF/Gw5yq3jlnLeGMf7NgZM2FK6kQnsw4rSrpO3hFEaZ
	 fo71rGJpydlIA==
From: SJ Park <sj@kernel.org>
To: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/core-kunit: add test for damon_call()
Date: Wed, 18 Nov 2026 06:28:29 -0800
Message-ID: <20261118142830.90113-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118063755.37749-1-saileshnandanavanam@gmail.com>
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

Hello Sailesh,

On Wed, 18 Nov 2026 12:07:55 +0530 Sailesh Nandanavanam <saileshnandanavanam@gmail.com> wrote:

> A newly allocated damon_ctx has call_controls_obsolete set, meaning no
> kdamond is available to handle call requests.  damon_call() should
> return -ECANCELED in that case instead of queueing the request and
> waiting forever.  When call_controls_obsolete is unset and
> damon_call_control->repeat is set, damon_call() should return 0
> without waiting for kdamond.  Add a kunit test for the two cases.
> 
> Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
> ---
> Changes from v1
> (https://lore.kernel.org/20261117172219.26725-1-saileshnandanavanam@gmail.com,
>  https://lore.kernel.org/20261117174834.29182-1-saileshnandanavanam@gmail.com)
> - Merge the two tests into damon_test_call().
> - Drop the list_empty()/call_controls.next expectations.
> - Drop list_del() on the stack-allocated control.
> - Post as a single patch.

From the next time, please ensure all discussions on the previous version is
done.  You could do so by giving more time before posting a new version, since
the last message to the previous version thread is added.

[...]
> base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca

Seems this is the mainline.  Please use mm-new [1] as the baseline of DAMON
patches from the next time.

Other than those,

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
