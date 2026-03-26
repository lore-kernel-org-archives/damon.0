Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CB3FE662;
	Thu, 26 Mar 2026 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536839; cv=none; b=lVcZGNfFmdxdj8Gw1GyzLdafiDQbgccq4CNaNUNIEps+VqcsntlTI09vXOF2656qBqikCJAp1bFZYP+zlU7y93kiQJSfWcdFiUwcJohJMlFyeS79uqvtJPO4CbuGhIivGQG48DQU9gXK1+kM6idUnuscWjvNBow6Br59mN/ESwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536839; c=relaxed/simple;
	bh=BLR/RJhF/jZELhqDin2ZuSm044v9f2wMVcye1L7PlfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QV71XWOIlysj7vjkv4pbtnX6IRlYfOg4xaAw59BIXwzt9wMDOoHv4LIV6Zrrnbo6z1YguCqAc1YUyvfcZAZucs9jxzp+g+LWj62BjBYVm+XkucOdfD/8fffkjVWs6hoV+88V1T6xEnN9HdYAedLupG4/S5rOd3s3jf9BAefuwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7Q6fhSe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7Q6fhSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656B2C19424;
	Thu, 26 Mar 2026 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774536839;
	bh=BLR/RJhF/jZELhqDin2ZuSm044v9f2wMVcye1L7PlfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7Q6fhSeG14zhc+CXBstEdP4CNpqQHZqzkK0i4Le3yB6kKm+tha4a1dgM0ckZUuGJ
	 jGr8AgqQQH6BZ15/N8bxNVB75o/l171t7qNjMFKJXFVzCQ1CyVB4t2gWKmq757gpYK
	 eXNZPhZFwFyrERS7KB2mn5abR2FL7EnWEkGYHQJ6NVHWx+jY5u8rgMTsnU8GxRdg3D
	 D7FwODquU+jZ2iq20B+hAtLYrTeezP6A6UTHEmcFdf/TT32BQ3+cW27ucdgb1WlyUi
	 kgZmxR67nCIjPF5qf/0+VX/0spUnKkwUzs1utSfQd3teaGJWlYSHgYcT57xwdlTdTy
	 p/wjkgh01+YWA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [RFC PATCH 0/2] mm/damon: fix damon_call()-related leak and deadlock
Date: Thu, 26 Mar 2026 07:53:56 -0700
Message-ID: <20260326145356.92319-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326134209.90377-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Mar 2026 06:42:08 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding sashiko.dev review status for this thread.
> 
> # review url: https://sashiko.dev/#/patchset/20260326062347.88569-1-sj@kernel.org
> 
> - [RFC PATCH 1/2] mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
>   - status: Reviewed
>   - review: No issues found.
> - [RFC PATCH 2/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
>   - status: Reviewed
>   - review: ISSUES MAY FOUND

The patches are hotfixes, and have no reason to be one series.

I will send the first patch as an individual one without RFC, soon.

For the second patch, I will go one more RFC round.


Thanks,
SJ

[...]
