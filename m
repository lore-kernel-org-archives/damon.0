Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E3346E54;
	Mon, 30 Mar 2026 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914220; cv=none; b=E3UVUI1PT/f/641aZ2qJjbwjscOXOPlsRY0WmFD/OZi2JJxVQviLJRW5ceUWJI8MKMdJVXH120jaP/QnnGaFyUCkkKn6jzxrqR32RuwFY9VuBJdpG5vQ3PZEuTYaeOdM85punlljDzxPE4wkcnllwkC1oVHprkF+uRXk/Iagg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914220; c=relaxed/simple;
	bh=BkHehICuOkyvWnfYUgcSXkuf4Vg4IEC4jTYJCRzvy0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZk4R/irw/1miQ9K5TRart0vm39RBjksSCvr/A86y0yOIzoWvzR+tOBVmEtw1UDPtxt2fEl7zxZl+8EYc3tMNVhoWlcPy/aeGF4Cqofi44RQEbUroMw6fZDGC98pi6m/i23JNU7Ozmt84uUyEYpHs5HbmyqsSCK9nXTWmineIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V32nZ1nX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V32nZ1nX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E38DC4CEF7;
	Mon, 30 Mar 2026 23:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774914220;
	bh=BkHehICuOkyvWnfYUgcSXkuf4Vg4IEC4jTYJCRzvy0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V32nZ1nX6h4IaF7f3ZViBed93BgbvpTgBNJvuAs+n3L7ZREOKatCKze34ek3ihNwV
	 UMn7VIT7lgZJ9dyl3PYn05JdY4q0jGkJQ+5/uslu0u9GzdibSkeQA9zqQd5IIKr9Y2
	 RDnUdS4R1a64dnRWzkSF0OfOaSbHvMztPmG0uVjAPc0+46j7+EREcxL1dACdczCq+v
	 ymZSvakC8FjfNpU/WOt7N8uLQ8Qc1NEshs9hjLjQCam+/6o/6wC/P3C898GTg54gAK
	 Q+Q/XPxmdhjP2fnNYzRN0EY0UCKFZc5C26+tOaiAOdU7sdD3hRy9N72f02B5omcjVg
	 Nk2xBRQigJ3ZA==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: (sashiko review) [PATCH v1 1/1] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Mon, 30 Mar 2026 16:43:37 -0700
Message-ID: <20260330234337.4456-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330145758.2115502-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260330145758.2115502-1-gutierrez.asier@huawei-partners.com
# start of sashiko.dev inline review
commit cd78854e55ee90102333f0331c58417c16e8d798
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action

This commit introduces the DAMOS_COLLAPSE action to DAMON. It allows DAMON
to synchronously collapse memory regions into huge pages by leveraging the
existing MADV_COLLAPSE mechanism.

Link: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/

[ ... ]

> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index b069dbc7e3d2..dd5f2d7027ac 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -903,6 +903,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_NOHUGEPAGE:
>  		madv_action = MADV_NOHUGEPAGE;
>  		break;
> +	case DAMOS_COLLAPSE:
> +		madv_action = MADV_COLLAPSE;

Could exposing MADV_COLLAPSE to automated continuous execution via DAMOS
trigger a pre-existing use-after-free in the core madvise logic?

In madvise_collapse(), the lock_dropped boolean tracks whether the lock is
currently dropped and tells madvise_walk_vmas() if the lock was ever dropped.

If collapse_single_pmd() drops the mmap lock, *lock_dropped is set to true.
On the next loop iteration, madvise_collapse() re-acquires the lock,
validates the VMA, and resets *lock_dropped = false to avoid double-locking.
If a subsequent iteration does not drop the lock, the function returns to
madvise_walk_vmas() with lock_dropped set to false.

Because madvise_walk_vmas() sees false, it assumes the lock was continuously
held and the original VMA pointer is still safe. However, another thread
could have freed the original VMA while the lock was temporarily dropped,
leading to a use-after-free when madvise_walk_vmas() dereferences
vma->vm_end.

While this flaw pre-dates this patch, does introducing DAMOS_COLLAPSE expose
it to continuous background execution by kdamond, making the race condition
much more likely to occur in practice?

> +		break;
>  	case DAMOS_MIGRATE_HOT:
>  	case DAMOS_MIGRATE_COLD:


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260330145758.2115502-1-gutierrez.asier@huawei-partners.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260330145758.2115502-1-gutierrez.asier@huawei-partners.com
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
