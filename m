Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA71FBC92;
	Wed, 24 Dec 2025 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766554521; cv=none; b=knPjGj0Q5exlLe7FXBvk0dCXgD/wcgWQ4Z+7wYio9lUVsxbfIOXBHU96Yp8ZRPp+VvLu35J5P0CqNvbthBoq60u0PRCgev03JQwo+P74Mu3GdPAax7koV1NwcbKiGBtHU0yl/4WwtlAfsMzzoovdaS5D1WhCCLfp/x6hxVUKL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766554521; c=relaxed/simple;
	bh=kr2K4L3nDuanEYjfqLQ+AGLazgdSZ4R0ehOzcVzdsMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O992Qqc3oFDo6Hh0sfBP5FrP9vppFiGide8UxRM4Qx/GRuq2IzsotqxRrh7CXhVjCwutoeqsqJozmBUm2k63+RIeA9CcHn+VkSkQtBSHw34jsx/Jqho68lfDGgdw7oUfS6kIEFpqr9uLTDh666eiqAb5DsRVdnRxSAYJgrrWcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M07Y6ig2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M07Y6ig2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7742AC4CEFB;
	Wed, 24 Dec 2025 05:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766554520;
	bh=kr2K4L3nDuanEYjfqLQ+AGLazgdSZ4R0ehOzcVzdsMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M07Y6ig2cYKW+kZ0yDXgiFUKnM02zeak/k5F5+URhIx55kQbPqhdqSzEpbwnogyvD
	 z0PMXoa6Itzcg020JgqJeqODDMJ7bjBE73r5ezY2AMKMjitNtX/me4MoJ+tD2R6vnI
	 5GRme92FzDdTi57Yop7gBZGJGuvWvwz+20Ubu51Rv/xrFp7VWyDyVRejYPp5540HkR
	 idNby+cy3k443yDMxuYwElqx7heJQpoJGCg4W6lz8omjbMFps20wsflbQyAp7kQ2J3
	 BklQr4GVlarJi+bKFQvHgQsJQPNWof3CNnSXsvAWk3UrtpUvg2hAMI4j6Y38CAU7QW
	 PHKz8L6gAXmVg==
From: SeongJae Park <sj@kernel.org>
To: Shu Anzai <shu17az@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] mm/damon/tests/core-kunit: remove a redundant test case and add a new test case in damos_test_commit_quota_goal()
Date: Tue, 23 Dec 2025 21:35:12 -0800
Message-ID: <20251224053513.82011-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224042200.2061847-6-shu17az@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Dec 2025 04:22:00 +0000 Shu Anzai <shu17az@gmail.com> wrote:

> Remove a redundant test case from damos_test_commit_quota_goal() 
> as it is already covered. Instead, add a new test for 
> DAMOS_QUOTA_SOME_MEM_PSI_US, which was previously not tested.
> 
> Signed-off-by: Shu Anzai <shu17az@gmail.com>
> ---
>  mm/damon/tests/core-kunit.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 36622a2c11f1..4bf1d172436b 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -601,9 +601,10 @@ static void damos_test_commit_quota_goal(struct kunit *test)
>  			});
>  	damos_test_commit_quota_goal_for(test, &dst,
>  			&(struct damos_quota_goal) {
> -			.metric = DAMOS_QUOTA_USER_INPUT,
> -			.target_value = 789,
> -			.current_value = 12,
> +			.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
> +			.target_value = 234,
> +			.current_value = 345,
> +			.last_psi_total = 567,
>  			});
>  }
>  
> -- 
> 2.43.0

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ
