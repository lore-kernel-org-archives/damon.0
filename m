Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132146E000;
	Mon, 28 Sep 2026 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582154; cv=none; b=f+/Sbw6wmbJlKW87RGkJzadVLOJMr5tPB3t7c5X98M2o1Z2IWh3wFxYGmOrHlNshwZd/l+zwq/cbMxeVulb2qKm/IT/Je9+9pvV8jD7oOWpeNv3IAfTXOO+Xwyb/1RbufH/ebfpR3JfrB8S86qo/Ga3jwRf9tJR06squbwaZICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582154; c=relaxed/simple;
	bh=2V2gO8NHErdRYwrUDu1a37PN8Fc55iIj0o4lNdh2Eh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/e1r+dCBrlZj5mPjhlWQ7KWpeUVnNzQ1rV6fJcwoNHTtsmIfmQJZcXbNOvRLRJ6XA+3rQvndT7PLDxZdBSt9L56l+kczml+osKxDHQP8OV0j+mmJY93UCEeD+uO0d6NUqD9+EQEXn44mr0PLllS25KzEVxz7Tfs8gFX5X55HD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmPRuxMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmPRuxMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285381F000FF;
	Mon, 28 Sep 2026 07:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582153;
	bh=2vs807hViPAPmQ9mexVWo1Ffl9jfECuMvazzU5hbaGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fmPRuxMK/a+e4TwACWc5HtJ6DJAB+gkltV1d0bapWhBEummTA8lzp2ErDw6jteGX5
	 EmbYrrWdyRTYwEUMvSTsMnaYCyIeUjV32Vat7b94B1UVc0/FbEIu2gpo0HdfyBy7jd
	 /U3L8gYEZLMtWf77VnhLCELnKVBIKVUCZFohnctaWiWR+/nX/UCoztn3YUpXdT/shm
	 aVqA4K9AhMboTxpn4PvOHIXkjIBT5M1HJis/TCw05RoXxW1oDJwn0SCf0pM5Q4Pfzo
	 stpUnnAwQ6VLjrEJLfou5ofdH57NqTsOngBkyLcyg82aH0XGQl5EfPDivxDw4cCP1X
	 NH54nED/cTZkg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Mon, 28 Sep 2026 00:55:46 -0700
Message-ID: <20260928075546.3245-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927175159.60703-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 01:51:43 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Commit b3723b596b54 ("mm/damon/core: fix unconditionally skip last
> region") fixed a minor bug.
> 
> Add a KUnit test case to cover this behavior and prevent regressions in
> the future.

Thank you for adding this test, Liew.  Looks good to me.

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
ping me or Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
