Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6443E074
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456008; cv=none; b=Dalb21lGxP15c5FSGDtS6WKwDBcOCs6LTEv5gbx6ycHchLcwF2HAWVgzP+NUwOE+dHcP5BKucLLJSLOWXlpxRdu0ooroXKwmIGNBueGh7ilaV0FNQti9z64c9CLyroY5GUEy3xJZ3hhacXVfcWLaIL3LpGIBIJg2jgvIWcMBboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456008; c=relaxed/simple;
	bh=rfHJSoIxy9LEwh9LU38JsxkedXxMODEPVfxxUL2fS6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXQoqjeUTmv9h8yw8r0PF3fm/dXbWnpxzJ54N9CZWBBZaMYcuXPOxzVyUO3Q8S4tRRbI1awI4JqYf9PJ4F6bfJm5sV5cfi2bPrPOrWWAnocsWaCwzOPL/SWo64Wa8Zy6/ED7Y5F4++rzsNTUFeg7+/d3pP8aqr/ae3NldGsKce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX9PVhp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX9PVhp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8411F01559;
	Tue, 11 Aug 2026 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456001;
	bh=GtL11n8OdaWgBaMEgmB3HonaWO11FGXgueUh8Z6UWVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XX9PVhp0hYtWXxPGD+TlKqjokKHxQd1egfWfY1SRsjmI3Au38K5m3PeG0ORWS0uOJ
	 S/6Vd03u2cn64RrNKAQu0t96T936JCkDfP3RAU2qpMhp7joNB7yuXoLFOODyn3YTyt
	 M7nfkLrGGn/wnifof+GRy1cLyL5TUrzqR1MbrhOyo3vGcl0+pWMS7Ey8e7Qzo4qamk
	 /X88RhP5Fm6GXyhKe+30DRKrYOdE442v+k3guoXMi591K4QSZdY5t/8TaazcrabBG5
	 aXNBxFbBkqB8dDOZyKjCuFH/q9yMX6dW1l0NHWWuFT1epn9RxIVsupeplPlcyaFJSn
	 kHAFSN9VshsfQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/3] docs/mm/damon/design: accurate semantics of nr_snapshots
Date: Tue, 11 Aug 2026 06:46:33 -0700
Message-ID: <20260811134634.4407-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811101841.804596-2-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Aug 2026 18:18:39 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Change "tried to be applied" -> "tried to be completely applied" to
> maintain consistency between the documentation and the code.

It feels bit confusing to me.  The completion in this context is for "trial",
not "application".  For example, someone might wrongly think the number could
be incremented even if a scheme was "tried" to be completely "applied" to the
snapshot, but failed due to a quota.

What about "completely tried to be applied"?

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
>  Documentation/mm/damon/design.rst | 2 +-
>  include/linux/damon.h             | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index aed6cb1cf483..939298f2a9b9 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -847,7 +847,7 @@ scheme's execution.
>  - ``sz_applied``: Total size of regions that the scheme is applied.
>  - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
>  - ``nr_snapshots``: Total number of DAMON snapshots that the scheme is tried to
> -  be applied.
> +  be completely applied.
>  - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
>  
>  "A scheme is tried to be applied to a region" means DAMOS core logic determined
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 0c8b7ddef9ab..d642ce4fc83c 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -357,7 +357,8 @@ struct damos_watermarks {
>   *		Total bytes that passed ops layer-handled DAMOS filters.
>   * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
>   * @nr_snapshots:
> - *		Total number of DAMON snapshots that the scheme has tried.
> + *		Total number of DAMON snapshots that the scheme is tried to be
> + *		completely applied.
>   *
>   * "Tried an action to a region" in this context means the DAMOS core logic
>   * determined the region as eligible to apply the action.  The access pattern
> -- 
> 2.55.0


Thanks,
SJ
