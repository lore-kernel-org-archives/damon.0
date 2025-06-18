Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7FB20297C;
	Wed, 18 Jun 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264414; cv=none; b=lby31DSsMcj91G3VGfd1BWrI6raBi70LZEUXiQRz4d9j4xUDXhQAJEO3sEfmrjZ4Wa7OfvsVyy4BOrIUE0cnJlinxBEHQ1kfuN0S3ZwqsMwpl4i3KSD0h0BB/wavoLjARbpz3gRi1p/PMYQBTP1UXLKZJ72H2f2trJxGcH6iJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264414; c=relaxed/simple;
	bh=gVqtGYViFPdtjcJ2fUviV2RrXcjKdyqo5GEDXb2IMQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PfQ02OQOiTOdWcgBgo8T4dv+AFewBbiZbP4j2kL6OKgm7an6i30S/UEXJuIypAHWDh1WluKbCXw4A5ASrvMd7VxL5tag3jT6UxqbR2Uy0ZVjmVx/Z4YB8Z6BfmSUPJwTKyvPTWx7pVmpaE6XzRQ0o9PDosTMf82/EOmgz5hEN0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4aTl3lV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4aTl3lV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966AEC4CEE7;
	Wed, 18 Jun 2025 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750264413;
	bh=gVqtGYViFPdtjcJ2fUviV2RrXcjKdyqo5GEDXb2IMQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4aTl3lV94Pwg3WQN4U/snDSm/f2ycEMp2uQqYm/yB7fmv8Wl0yg163doeq7QHqjO
	 tsA54n3wBCVgDh7axINKL+E95M99ahk6TPIaRhiTrluCG0gJO4hoC/aycoSumXAfbw
	 XPcKhRltO91gf2+fLl9GrnsvBZWPXyrlxdnyxqTmyKXWNuKLRKpQcAqSyhh3Ul0FUd
	 Rjhrcy4kJvsPmG0b2Be42TyJKKMJ3V5uEdxD02M3yuIaWhMHOllX7ngjsOqZqWgO0o
	 oMVMaEv9y+gbTEeJSibt13Uk7QrmouRnZQCq0x4J4Axnfj6uzL9PmSVXnxa5opy9JA
	 teFKZWOlqRLcQ==
From: SeongJae Park <sj@kernel.org>
To: Nathan Gao <zcgao@amazon.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix minor typos in damon header
Date: Wed, 18 Jun 2025 09:33:31 -0700
Message-Id: <20250618163331.54910-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250618063940.43400-1-zcgao@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Jun 2025 23:39:40 -0700 Nathan Gao <zcgao@amazon.com> wrote:

> Fix typos in include/linux/damon.h

Thank you for fixing thse!

> 
> Signed-off-by: Nathan Gao <zcgao@amazon.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  include/linux/damon.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index a4011726cb3b..bb58e36f019e 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -450,7 +450,7 @@ struct damos_access_pattern {
>  /**
>   * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
>   * @pattern:		Access pattern of target regions.
> - * @action:		&damo_action to be applied to the target regions.
> + * @action:		&damos_action to be applied to the target regions.
>   * @apply_interval_us:	The time between applying the @action.
>   * @quota:		Control the aggressiveness of this scheme.
>   * @wmarks:		Watermarks for automated (in)activation of this scheme.
> @@ -656,7 +656,7 @@ struct damon_call_control {
>   * struct damon_intervals_goal - Monitoring intervals auto-tuning goal.
>   *
>   * @access_bp:		Access events observation ratio to achieve in bp.
> - * @aggrs:		Number of aggregations to acheive @access_bp within.
> + * @aggrs:		Number of aggregations to achieve @access_bp within.
>   * @min_sample_us:	Minimum resulting sampling interval in microseconds.
>   * @max_sample_us:	Maximum resulting sampling interval in microseconds.
>   *
> -- 
> 2.39.5 (Apple Git-154)


Thanks,
SJ
