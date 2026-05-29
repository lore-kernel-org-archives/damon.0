Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE73B3BFF;
	Fri, 29 May 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065881; cv=none; b=ZKr5mPixe9yi/4Zl+h35uApLnIYcbmOQduRHl246rsGpKZKm4N43XNCFVM0d78l+aZnMfg/utkMb7rWCdxrEgSLeGaqsIUt80I+vUMekoGz0qEErYqG4laKMMQl6vG4+C1aAm4yd/LiwBUJB33qAYuBkRXTrQncN6B443Mf3HK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065881; c=relaxed/simple;
	bh=Ol6joHspgRP0ruux+ian57qzjqjKtPb5K5tMzrXlook=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLpBcCohZOj3yvyk0/iOCaZTFlx1oQP0iaSEHGGHGDRPNegqYkQ09+OOfi5UVhkXenVd91gqtxwLD1GcXBl0gx4pJTEJaR7zVjjj0JUx4Xb/X5dKND1uWW9cNd0pPtBLQmI4PsyIgbXMYBeQ52QBfJU4gCSw8CDLyeZkuCthC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F68S+BVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F68S+BVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ECF1F00893;
	Fri, 29 May 2026 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780065880;
	bh=eSDXs1iBErDS79NVdNdY9EDtRW55Oz5UnXhb1rHekmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F68S+BVIcO7kPPYdQx2I1f5VR2PTd+HJbmJNR8WPxoi84zXHrZ9zTAZsBh28UzmuX
	 8RfsK7Jfs2M/rIkssc9Ka32W9NuMGY47tK0ipgDsnbEORXCko8nNHiEUFd9y6Nc6Cf
	 77XoF7ml7YHp+i5bFYPzNYM6DCKqzR8xu7fKTLgZXjwcIhuRlePiag944fUsLi/55H
	 8njBfyF5yy5Hx7Jc8zuGYrkvo47+S2qTt4mIP/hxJhYBhN6WaG1k6v9x+EpUybKQDl
	 gen8amrxTbYdeag/BrCtTZIRAyZt22LlLNVrmoZtpEucwti1eVD6zNW89zYVuPq/xT
	 vnP7LtiJjn1ZQ==
From: SeongJae Park <sj@kernel.org>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon/stat: roll back context on damon_call() failure
Date: Fri, 29 May 2026 07:44:35 -0700
Message-ID: <20260529144435.83930-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529031519.1617000-1-dbgh9129@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Yuho,


Thank you for sharing this patch!

On Thu, 28 May 2026 23:15:19 -0400 Yuho Choi <dbgh9129@gmail.com> wrote:

> damon_stat_start() allocates and starts damon_stat_context before
> registering the repeated damon_call() callback.  If damon_call() fails,
> the function currently returns the error while leaving the context
> allocated and stored in the global pointer.
> 
> The retry-time cleanup added for this path only runs if users try to
> enable DAMON_STAT again.  If no retry happens, the failed start leaves
> the context allocated indefinitely.
> 
> Roll back the failed start by stopping the kdamond before destroying
> the context and clearing the global pointer.  damon_stop() waits for a
> live kdamond via kthread_stop_put(); if the worker has already completed
> teardown, there is no kdamond left to wait on and the context can be
> destroyed.

But, having one damon_ctx object in the memory is a real problem?  Why?


Thanks,
SJ

[...]
