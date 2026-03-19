Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9789346E5A;
	Thu, 19 Mar 2026 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773901759; cv=none; b=W2Eqb3GGQZUvTRDmvQQF77DWgUWkVieQ0RYW1urZNT4zRK9dXc0EZ8ZCx/qduyhnYaqzq2eK0R+Ztw2ruxVI6rtSpYvGjTWK9+K2e+EuJIyAmzxsGpcZYfwNrGewK7pJYX6hf8alX7hN/I8M0kn9ewAA0wmUYBbOrZuTLOu8ri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773901759; c=relaxed/simple;
	bh=f8KRoUgEZ6BfqFTgvZjmWr9krDqWtElmbj+tt3G8zZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8DFU9SKUImx5f5qSl2ptFycl1uvonFh69IcwNTYKlPmKsacRsg/zRnaminaT17qQzvBBn8+CqyOd2XngBfpsJL+W8AS4oNSlTlSHEowSIXx3yPyJS5OhJwkC86yAlIh4DaRFAYosBSAjrGx1S5wNROeOk0W8Po5lqBrGXtac9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lsdtv1wN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsdtv1wN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6978BC19425;
	Thu, 19 Mar 2026 06:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773901758;
	bh=f8KRoUgEZ6BfqFTgvZjmWr9krDqWtElmbj+tt3G8zZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lsdtv1wNjXhyKRk5gYZ/88+Ukqgyuq3m6W3FNTVwgHS1dyfIaKNZf98lFTfkwaxLK
	 6csCbEEXLVDO0PWcsLXZPY9JhOTNI/bh5snNTbKxDpaGhzG08DzQno6rU36EEDpV5q
	 +hNeRxypDsuUzzYfdsaJnqk93JYOIWLJASMnEYR9j8yO/s+2S7w7l7p4lcU5+pYORK
	 mFdhqpa7vabmZ2FeCayGdmEjhVMPrXKunisL/hnJHr//tAMoh6vQom5IEdbH/nwVIZ
	 dfRDNHBTd1j+qRrwkAfGbIChHDZYmDQ1TIuBi1nn98ilbFLxeddh0ymyoTJ55jjrXr
	 6HKB+scj9PZHg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Wed, 18 Mar 2026 23:29:10 -0700
Message-ID: <20260319062911.77252-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Mar 2026 22:21:44 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON supports only start and stop of the execution.  When it is
> stopped, its internal data that it self-trained goes away.  It will be
> useful if the execution can be paused and resumed with the previous
> self-trained data.
> 
> Introduce per-context API parameter, 'paused', for the purpose.  The
> parameter can be set and unset while DAMON is running and paused, using
> the online parameters commit helper functions (damon_commit_ctx() and
> damon_call()).  Once 'paused' is set, the kdamond_fn() main loop does
> only limited works with sampling interval sleep during the works.  The
> limited works include the handling of the online parameters update, so
> that users can unset the 'pause' and resume the execution when they
> want.  It also keep checking DAMON stop conditions and handling of it,
> so that DAMON can be stopped while paused if needed.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 2 ++
>  mm/damon/core.c       | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 3a441fbca170d..421e51eff3bd2 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -811,6 +811,8 @@ struct damon_ctx {
>  	 * intervals tuning
>  	 */
>  	unsigned long next_intervals_tune_sis;
> +	/* pause kdamond main loop */
> +	bool pause;

This field will be directly set by an API caller.  But this diff is defining
this field in the private fields section.  I will change this to be defined in
the public fields section, and add the kernel-doc comment, in the next version.


Thanks,
SJ

[...]
