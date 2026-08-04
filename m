Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DE468C00
	for <damon@lists.linux.dev>; Tue,  4 Aug 2026 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851918; cv=none; b=QD87SAfRfN9BQE6kzYNadluznD8qCrYdlONXyO7vMIevH5/Vt1e16oVnxUmdIyBjQWlLByYpGnLu4e72AKRYFsDH97TzXiCUh4AadOISz1Cql5M1UA5OevhhNAuHTX5bXycggdO33yFZnxgz4uVkoyKPo+Vz8uaKzh5ddsqfPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851918; c=relaxed/simple;
	bh=QhY5IZ4dBPw5oX12E/ARp9YHAQYiNghZfeHM7CedrXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2D9msXH6IhYZZ5uT0piO1KgOGeWI/UBJjZW30VwLgRaAq0SPm65Gn+Q7ZAdudfqx7UW7Avpndw8QrGVKh5W5QMZco9s4xmmblrBEnhQ7IDjoJxCTFzHN3DgsNM4nffOo41G5VgPltuw6MX+bFfqUgDRdYX7Qh3FV1tw9OyOazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtNpQIZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtNpQIZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC81F000E9;
	Tue,  4 Aug 2026 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785851916;
	bh=DU0+E3W+eQadbym8RaRuTNZS2KUE2FrjK/dIbBsihDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtNpQIZnQh8lQRERkNoHf2vK5fudFe8UQgx70t4vhPWxz9Z59y/QD9ta3hYGWrUDy
	 bPHF+fViw2S7vLmZU+GxAJVbi9anE6OL+IgkJPKjv9sbiEsliUTsl1ogNL+4yf/drr
	 ahsJuQ8N4RzJCuoQWSN1lVHSoGZHSgL+/6ohrWMxrGph8KyMnTVUjeV+6WvSoTw7eo
	 VsOW0IqYAKjG74xEuXHm8Ck6Nbe3qZWkasiwWrQB/MhlekwrTFn6OIqIfCUmq4b0bs
	 gUwNBx9on663FjPRFGZO6TxmNj4kXf2DKPuNQcxI7w1VNRIaWQcToaR7IulstmBNkt
	 +Uhq3tGtA68kQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: introduce damos_sort_type for re-ordering regions list
Date: Tue,  4 Aug 2026 06:58:33 -0700
Message-ID: <20260804135834.86511-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260804100719.116538-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,


Thank you for sharing this patch.

On Tue,  4 Aug 2026 18:07:19 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> 
> A DAMOS scheme filters its target regions using an access pattern, which
> is constructed with the size, the access frequency (nr_accesses), and
> the age of the regions. The age here means how long the current access
> pattern of a region has been maintained.
> 
> For the pageout action, the age.min of the access pattern effectively
> acts as the minimum amount of time that the target regions must have been
> unused.
> 
> The definition of cold memory highly depends on the devices and
> workloads, and thus setting a proper default age.min (e.g., min_age of
> DAMON_RECLAIM) is both important and nearly impossible to make suitable
> for all devices and workloads.

The recommended way is setting the min_age naive, and auto-tune it using DAMOS
quota or aim-oriented quota auto-tuning.  Have you considered using that?

> 
> Solution
> ========
> 
> Add a per-scheme sysfs attribute, schemes/<N>/sort_type, whose default
> value is 'none'. A scheme can set it to 'score_desc', which makes the
> scheme to collect the target regions and apply its action in descending
> order of the regions' scores, as calculated by the ops.get_scheme_score()
> callback, during the application. For a pageout scheme, the callback
> returns the coldness score of each region.
> 
> Instead of modifying the region list, DAMON copies the target valid
> regions into a temporary array, sorts the array in descending order of
> the regions' scores, and applies the action in the sorted order.
> 
> With this, the scheme gives absolute priority to the highest-scored
> region. For example, a pageout scheme with 'score_desc' reclaims the
> coldest region of the target first. Users can thus keep the age.min
> relatively small and let the score ordering do the precise
> prioritization.
> 
> Note that regions are applied in the score order, not the address order.
> Therefore, the address-based quota charge resume mechanism is not
> available for such schemes. Instead, the quota is spent on the
> highest-scored regions of each charge window. Applying an action
> resets the age of the applied regions (except for 'stat' action), so
> those regions are naturally excluded from the next window if the scheme
> has a non-zero age.min. Also, when a region is split for the quota, the
> age of the split-out part is preserved, and thus the highest-scored
> region is continuously applied until it is fully reclaimed, even when it
> is larger than the remaining quota of a single window.

This sounds like very similar to DAMOS quota's regions prioritizing mechanism.
Have you considered using DAMOS quota?  If so, could you please add why
proposing this new mechanism, with some comparisons?

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
> I am currently running the corresponding benchmarks to ensure that this
> does not introduce too much performance overhead, at least not on my
> device.
> 
> The purpose of sending this patch is to make sure this is a right
> direction.
> 
> About my device/VM
> ==================
> 
> CPU: AMD Ryzen 5 5600H (12 Cores)
> RAM: 8GiB in VM (4GiB + 4GiB ZRAM)
> 
> I currently foresee two potential issues with thiss patch, though I
> have not obtained the test results yet, so these are just guesses.
> 
> 1. Excessive memory allocations and deallocations 
> 
>     The default aggr_interval is 100ms. Executing at least one
>     allocation and deallocation every 100ms is very likely to cause
>     unnecessary performance overhead.
> 
>     I think this issue could be resolved by having the scheme maintain
>     its own buffer.
> 
> 2. Performance overhead of re-ordering
> 
>     Although on my device the number of regions is not very large, and
>     DAMON's default limit of 1,000 regions also helps avoid performance
>     overhead, I suspect that large servers might not stick to just 1,000
>     regions.
> 
>     A solution I can think of is using a Top K Min Heap, though that
>     might significantly increase code complexity and reduce readability.

I'm indeed concerned about this.

> 
> As a reminder, these are just my __guesses__ and do not necessarily
> reflect what will happen in practice. I will send another email after
> completing the benchmarks and micro-performance testing.
> 
>  include/linux/damon.h    |   6 ++
>  mm/damon/core.c          | 125 ++++++++++++++++++++++++++++++++++++++-
>  mm/damon/sysfs-schemes.c |  57 ++++++++++++++++++
>  3 files changed, 187 insertions(+), 1 deletion(-)

I to be honest feel this is too much for "just guess" based patch.  I'd like to
get clear reasoning of the change and/or test results before reviewing the
code.  So I'm holding the code review until the high level discussion is done.


Thanks,
SJ

[...]
