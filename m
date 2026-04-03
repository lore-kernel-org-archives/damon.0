Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1E2F746D;
	Fri,  3 Apr 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233252; cv=none; b=G9+JvhB2QlEu4GNDRE705g0Dn5Nflv2mvOKi/I35flxGdGipTEM8vJc3DA418rNGqah0NRYZV6s/kuR2B1/sn0sRVpYgku9+s+IRvn9XZXNougv0hzXcwVgmJiH47b+qsWVCw6xd7Edu5Qz/uPUiZsqXCdVxOqfHDQHAA2Xub54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233252; c=relaxed/simple;
	bh=Ds4Y+cyyYXN24nPdjxMnzx1viX9Vnik98lXxpbdexNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js8x14Censp26KWSH1MrZ3TY2VsDW3Pm1wqWIPgOdGCK9i8lwnzMhaa/mwOUCTD+HgVr1CcbbtWnkCrWQnEo7rt+BDrjSUEb5cEtLJtI1SmWgpT+9EvbURyaEvvvl1agoOP6LQQU7RY74kKaCGKopdvZx13xrrHC2lcSNLDzgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBzEjqFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBzEjqFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9875C4CEF7;
	Fri,  3 Apr 2026 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775233252;
	bh=Ds4Y+cyyYXN24nPdjxMnzx1viX9Vnik98lXxpbdexNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBzEjqFJ1M2qH9kDhXArAiBA52bw9oPlUpcxKq2q+U/lWvaDw3J8QC8jOFGh/G/lf
	 KfdobvROy4Jj/QIhPTA1+wq8v2MxUx8UyMZS6zYFcxoLUzvEJrV800sceWdXm1rHxT
	 JrJ1siN49rXwG/EHOhrNymsDa6vV9ExazJceml+wMWRIKeYha4V7yZI61dItQbTA4w
	 rUz5HMe401+QZvGMqjIDijYrgVYdLUVF1q6PY81MiaJlC+DK7wqsz2/PUPLVjxqH3E
	 kpo0I1RnHUnYlVgtOsfaadZJVGoGVS0vlmGy2rNsekQRKmMC4/yLa7U4mMrS/ORDIE
	 T+xNsYlufIonA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 09:20:50 -0700
Message-ID: <20260403162050.65121-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403052837.58063-3-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  3 Apr 2026 13:23:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> The damon_commit_ctx() checks if 'min_region_sz' is a power-of-2.
> However, if an invalid input is provided via the DAMON_RECLAIM interface,
> the validation failure occurs too late, causing kdamond to terminate
> unexpectedly.
> 
> To reproduce:
> 1. Enable DAMON_RECLAIM.
> 2. Set an invalid 'addr_unit' (e.g., addr_unit=3) so that
>    'min_region_sz = DAMON_MIN_REGION_SZ / addr_unit' becomes
>    non-power-of-2.
> 3. Commit parameters, and observe kdamond termination.
> 
> This patch adds an early check in damon_reclaim_apply_parameters() to
> validate 'min_region_sz' and return -EINVAL immediately if it is not a
> power-of-2, preventing unexpected kdamond termination.
> 
> Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
> Cc: <stable@vger.kernel.org> # 6.18.x

I'm not very sure if this deserves Cc-ing stable@.  I posted more details on my
reply to the first patch of this series.  Let's discuss further on the thread.

I will skip reviewing this patch until the discussion on the thread is done.


Thanks,
SJ

[...]
