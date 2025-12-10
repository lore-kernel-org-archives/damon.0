Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDEA1E9B12;
	Wed, 10 Dec 2025 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765403384; cv=none; b=QLR45f+ewohjMpP7acywzATJggQoaWWXO8J3qNuFIVglFMvMscnzXWbJ2DHGlLZxY8pr3rOhiEJD5kCmGoxO+wa+KQkzkI9GwhT4LH+CZflXtPXMx22B3UAy2TrqbatDzVb02QIStzMQFfxYcsbrLaAlesoevTZxyHLlyVU5C+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765403384; c=relaxed/simple;
	bh=r6ZOZ8yM+7+ioWVUbdUX9Oobm1iYnDniUDEQ2yzX1n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJmE/5PXBmCRTa9obKXybakaS3QwJUkQ0FpYyEG3IavcAcFWR1L2TIvMbmrXHBRQ+ZowKaFwUmeuX9zxfVx7790wBvNhoelXCjHT/DrXewMtaZ19HrPjyY8LkxGoN97aQNlGSDKlDUVJm8YPHvVUMzIi5JmlxRV6U4SCN++B+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBTs+i3V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBTs+i3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4398DC4CEF1;
	Wed, 10 Dec 2025 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765403383;
	bh=r6ZOZ8yM+7+ioWVUbdUX9Oobm1iYnDniUDEQ2yzX1n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBTs+i3VE5xWFYKivrcjKmNITsqDTSTnpYlpIVFR646Lx8IpwCp8fYsFyT2bxeSAk
	 DubexRQGOJriGM6qnHt/zFLHR0Seau+D7ViformhIMg+whTwQQcM9MrKBaGzEe6S6k
	 CD5X9rqDIwdn19ST5ibUYHkEbREVq3gnWd5cGVmySwSX1zMzheOOiN8p2XgrS7PyjY
	 +X/N8v/UAK36rXJqMxsP94//ug4VwMtXv3MFgCZ9Aj5yrLBnZDtX/69EZ1WL3MAQIh
	 sKIrgfDjuHphSuZxeN9RlmQG1I+WjVtBUVLG86g9/Jdb4uTMHWzM5FYrKz36QMn9ox
	 TuU4LPSS5Z16Q==
From: SeongJae Park <sj@kernel.org>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] mm/damon/sysfs-schemes: Remove outdated TODO in target_nid_store()
Date: Wed, 10 Dec 2025 13:49:39 -0800
Message-ID: <20251210214939.62774-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211030707.16417-2-swarajgaikwad1925@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Dec 2025 03:07:08 +0000 Swaraj Gaikwad <swarajgaikwad1925@gmail.com> wrote:

> The TODO comment in target_nid_store() suggested adding range validation
> for target_nid. As discussed in [1], the current behavior of accepting
> any integer value is intentional. DAMON sysfs aims to remain flexible,
> including supporting users who prepare node IDs before future NUMA hotplug
> events.
> 
> Because this behavior matches the broader design philosophy of the DAMON
> sysfs interface, the TODO comment is now misleading. This patch removes the
> comment.

Thank you so much for this patch, Swaraj!

You sent this as a reply to v1.  In mm/ and damon/ subsystems, we prefer new
versions of patches to be sent as a new email, rather than a reply to the
previous version.  Please consider doing so next time.

> 
> No functional changes.
> 
> [1] https://lore.kernel.org/lkml/20251210150930.57679-1-sj@kernel.org/

This kind of link is useful for tracking the history.  Thank you for adding
this.

> 
> v2:
>  - Removed the logic changes (validation) introduced in v1.
>  - Updated commit message to reflect that only the comment is being removed.

This kind of change history should be placed under the '---' line [1] below.
Please consider doing so next time.

> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>

Other than the trivial comments above, change looks good to me.

Reviewed-by: SeongJae Park <sj@kernel.org>

If you willing to, please address the comments and send v3.  Because the
comments are for only very trivial things, if you don't or can't do that in
days, I will address those and send it as v3 on my own.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ

[...]

