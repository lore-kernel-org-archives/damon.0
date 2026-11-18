Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012416;
	b=0YYkAj3kZGYhpbBC4xtYS//Yj3FrbcLIMf72NpCirKqsfaeHMB2EPkYxREa7ZDJ1KXDy
	 A85Diqs9c22h+xcsYpme99tvEvbh5Ci5fscfJcSHVwRuhJpbWcLZ2eamCLLx2gZb+xln4
	 vJjj6rxQWdEhm7ZRGztGSdO5+mMynElhbdFw7vECtD3YEuzlG5+/SG3jNGI35IxWfivoy
	 eHV7NMtHm8U12wexBKPsB3QlPM8me5+mLk/YS99YB/aMlKv+smzaAB0UWKm9VrhTQmvy5
	 NNB/QDF+jlRH7IkMyN5T4XYBtfLG0KGURmcpzkRNT6hjSKAKuFItDypPYwS46fWPrHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012416;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lnjKgTm5vSNYR4pLlmAjDVsgJphmcl/khyWsdGHeBCY=;
	b=NQXQb1P/Xf9eflNuP9IcuiRbMiBD0CSAj2hggUle19UVlMU9Z2JHVj+hTfdemzPv0KZC
	 AcBymhxslw8zsFaSj10zAfihgrjO6tq1sLk0eNAZH+Z/PPxF8IKmcBffu16ah6m8ZiLig
	 S2upfPYWpa7CXs/2Ohwtb1NyKphDrF1iPqu+N4Fs4fPbNvR6XBRoMbbEEPBYRTYwHNm5K
	 AsDoNynkzyHlyxvH4xodgZsi3HhB7QKEzxHmyDUgiZFPCvUTvUmCcHCTMBi1JRWibULvo
	 ui6TOirZUO0W2opdG619iA2joq/6f82D6yNe9CqC7DvXrIMp21rK+W9woTdMr957GqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQ2pXbMM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77D1606A33D;
	Wed, 18 Nov 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQ2pXbMM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681EE1F000C4;
	Wed, 18 Nov 2026 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012416;
	bh=lnjKgTm5vSNYR4pLlmAjDVsgJphmcl/khyWsdGHeBCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQ2pXbMM8T1oX7wrQMY/hn6f1+xlHKRWE2PRIKDD/C+GPWSnoePr+Y84oMgigX5W+
	 oDYCAON3LXdYPMVXQXH6+cKWl8YgltIJFPwG6hsUqY7krMleYaa/qmEgxml1Tjo4HM
	 24MlTMxa3rBKD9Xi3czpMVqJYzNvVjf6y4dNl8muT25FY1OutVFES9qzdDLwjABHWW
	 f/5n/I8sSgbk50WZnUHIeVO2ANd9qI7oaAs0163Bcy+rsK2MZZL3LHAX3qtZsfMkv/
	 7wRIosaqy1C3ud+1g2rZwDZ9qKwdhPhxtIXt3nsR8zCqt1R6t+Jb1x9GV4Oe83R5ak
	 YzBQEwonLtJzA==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/paddr: skip non-LRU folios as a whole in pageout
Date: Wed, 18 Nov 2026 06:33:18 -0800
Message-ID: <20261118143329.92901-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118-fix-damon-hugetlb-pageout-20261117-v2-1-547a65a3206e@gmail.com>
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

On Wed, 18 Nov 2026 03:24:28 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> damon_pa_pageout() uses damon_get_folio(), which rejects folios that are
> not on the LRU.  For a large non-LRU folio such as a hugetlb folio, the
> loop then looks up the same folio once per base page even though
> pageout cannot reclaim it.
> 
> Use damon_get_monitor_folio() and skip any returned non-LRU folio as a
> whole by advancing to its end.  Do this before the filters, the
> accounting and the last_applied check, so that adjacent regions within
> the same non-LRU folio are not walked by base page either.
> 
> In an x86-64 KVM pageout microbenchmark, traversal time dropped by
> about 99.7% for regions covering whole 2 MiB hugetlb folios. For
> 4 KiB regions within hugetlb folios, traversal took about 1 ns more
> per region.

Looks good to me.

> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
