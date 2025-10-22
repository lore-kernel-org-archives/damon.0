Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81BD7262A;
	Wed, 22 Oct 2025 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094000; cv=none; b=YdsXJpoymdNs8iF7AgUNRga2K03d1jfBxNq4OjHc4aNFu+DgiIlvEianIRE7kuOLp+pNQ6czJ6FMipf5zM2iqd9RTCkKiIQyVYfzP8XzsqQo/+Vh4cF8OGT4z4L+QtyKGze1KzDnai1SQwGu+p3s/mAawl+6ggwE9FKXPdK75xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094000; c=relaxed/simple;
	bh=goRiRUZ7sLTgCensnC5aP5+GySLWz9riJcQIkmhcGh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rnibbura9g41sFXM/KEKwI8d22Ay+eXcn6uB74BqhvNSpFQQQ9bnjeJieN2hhPhqaMGMro/FvWzawDsTSZT91K8fnch5Y8l+r79N16eV/Pzdv2V87Nwj0KM0Y/OzFk6ZJQrvR+f7gp/VJLqa77dl3x11QS/mEV7ADljszNkbYow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2w2Escy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2w2Escy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B784DC4CEF1;
	Wed, 22 Oct 2025 00:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761094000;
	bh=goRiRUZ7sLTgCensnC5aP5+GySLWz9riJcQIkmhcGh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2w2EscyYS5Hpa+kcsHfoJeHMyQAeTCA/OWsOxJNz+zmybaorMUOs7EmKx5jVImeB
	 OKO4hZ3q0yJxaT3ecb78et9Kmx5uEwg8uxRJyTgCih+7lM0Pl4WWFMBfqbfatlSoQ6
	 g9DsXHzlv08RiH1NFEUGzVlCB9fuxl0Xz4ysBXpDX/VE5jegPCyijZsELDzCvdrAHz
	 jM+nQrhTmrTbflWdiKigNM67gJs7JIWlwhNDJJ324cyTqgRfc5j90DidvNRsQ6JOUo
	 qyhlIhQnb94+EI2PC2n2ODYFmJF9aSxsuXD6+4HL1Kiy4TqWOsuqMpuQeRlIgXl2BV
	 0pq9EduwChm8Q==
From: SeongJae Park <sj@kernel.org>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list),
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] mm/damon/sysfs: Remove misleading todo comment in nid_show()
Date: Tue, 21 Oct 2025 17:46:36 -0700
Message-ID: <20251022004637.119085-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021215323.29734-2-swarajgaikwad1925@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 21:53:24 +0000 Swaraj Gaikwad <swarajgaikwad1925@gmail.com> wrote:

> The TODO comment in nid_show() suggested returning an error if the goal was
> not using nid. However, this comment was found to be inaccurate and
> misleading.This patch removes the TODO comment without changing any
> existing behavior.
> 
> This change follows feedback from SJ who pointed out [1] that wiring-order
> independence is expected and the function should simply show the last
> set value. and [2] checkpatch.pl complain about number of chars per line

This is another revision of your previous patch [1], right?  Thank you for
fixing the things I commented on.

That said, marking the fact that this is a new revision of other one on
subject, for example, setting the subject prefix as "[PATCH v2]", and adding
changelog from the previous version in commentary section could help review.
Please consider doing so from your next patch.  Please refer to the related
docs [2,3] for more details about that.

> 
> No functional code changes were made.
> 
> Tested with KUnit:
> - Built kernel with KUnit and DAMON sysfs tests enabled.
> - Executed KUnit tests:
>   ./tools/testing/kunit/kunit.py run --kunitconfig ./mm/damon/tests/
> - All 25 tests passed, including damon_sysfs_test_add_targets.
> 
> Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
> Suggested-by: SeongJae Park <sj@kernel.org>

Reviewed-by: SeongJae Park <sj@kernel.org>

> 
> [1] https://lore.kernel.org/lkml/20251020151315.66260-1-sj@kernel.org/
> [2] https://lore.kernel.org/lkml/20251021010847.68473-1-sj@kernel.org/

And you should have put the above two lines before the above Signed-off-by:
line.  Please consider doing so from the next time.  Again, read the document
[1] for more details.

I found Andrew picked this patch on mm tree, adjusting the above two lines
properly [4].  So no new revision would be required.  But I'm noting this for
your next work.

> ---
>  mm/damon/sysfs-schemes.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 6536f16006c9..760279092b4f 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1112,7 +1112,6 @@ static ssize_t nid_show(struct kobject *kobj,
>  	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
>  			damos_sysfs_quota_goal, kobj);
> 
> -	/* todo: return error if the goal is not using nid */
> 
>  	return sysfs_emit(buf, "%d\n", goal->nid);
>  }

And this results in the code having two empty lines.  Just one single empty
line would be enough.  But that's too trivial, so I wouldn't request a new
revision to you, or in-queue direct fix to Andrew.

I only hope my trivial comments to help your future patches be easier to review
and more smoothly be merged :)

So, thank you for this nice patch.

[1] https://lore.kernel.org/20251021021712.59017-2-swarajgaikwad1925@gmail.com
[2] https://docs.kernel.org/process/submitting-patches.html#subject-line
[3] https://docs.kernel.org/process/submitting-patches.html#commentary
[4] https://lore.kernel.org/20251021183613.C4A6DC4CEF7@smtp.kernel.org


Thanks,
SJ

[...]
