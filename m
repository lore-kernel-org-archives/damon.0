Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02853CA62;
	Thu, 15 Oct 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074581; cv=none; b=QgWHmFb0HNZbFKS+2qbjd6GO/ffDrEk22lRpsga9rcsO+gmSWiIjlJoBxvGDypoPyunk3P3jIgCSNj+vYkO9O7dI63fW/0Mfqbp38ip8+lN2s/u2fJLP/R0DUzVnb+8H3phdRMEhD0WLA0kf9/0iLlbv4vvKFC+1mfzmzW09DQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074581; c=relaxed/simple;
	bh=VN4DQTig9qciisvZLkjKSLInD+6EeDGJGqhzQ5t7log=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPqRxKbUGirvzBRkh2mSTnmT0RQalmcLEw+tnxvOhfoWhoMyyU21Sg+m/h3jztiA5Kk9CXeh7xdCIMvZjxknEZBe71Hjy5rNjpv8KolMooKeHbmD3fhuUSEAqt2Vn4htarnvcmlqzXAZDRR+d7v03mxz8s0nL2Ou7Ko9YJa2L8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYKJd47h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYKJd47h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063BB1F000C4;
	Thu, 15 Oct 2026 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792074580;
	bh=SPAts+uUcTI+ZJqIZJfnKHgPxPJV/e6f95NzFOwiLqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYKJd47hiyUzqHs8MMIh9FIivuj2meXfyydKxLinzssikP8bqOVeKCS4lU/mRu/RB
	 KBQfnN6Z18soRyxT9PwnIE5wwaZWphUveb5UbF2SjwrWof6w9q1s6oVSl4Jr6ZV22c
	 GRIqqPKGakOgl9e5VKAsjea+t/FpSdwk1AhptsS+B1VFYStzCxA+NS3CnjZME2lLK1
	 UqcVxkfY5yLi2AFeosxtglgQtz4eDph7AkPwgzVqsIq0jKc7y1dWKmAS7JHh5+etdP
	 guqtz9p9yUWFy+YCjNBoiQ3hUtUhDTcbZoLNQ0VIOr4p9AMCHowrh6wok5eERQkF6g
	 TuFMG89luTMkA==
From: SJ Park <sj@kernel.org>
To: Suhaas Joshi <suhaas@s-joshi.in>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] mm/damon/core: Iterate over installed probes instead of DAMON_MAX_PROBES
Date: Thu, 15 Oct 2026 07:29:32 -0700
Message-ID: <20261015142933.105760-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015135533.18761-1-suhaas@s-joshi.in>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 19:25:23 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:

> Hello,
> 
> This is v4 of a series I sent earlier. Please find changelog below.
> 
> There were two "todo: " items of the same nature in mm/damon/core.c. Both
> of these suggested that we should iterate over only installed probes while
> updating (last_)probe_hits[] during merging/splitting regions, instead of
> iterating over the entire array, which may have empty/unused indices.
> 
> So this patch series does exactly that. It replaces the for-loop over
> [0, DAMON_MAX_PROBES) with a damon_for_each_probe() over the probe list of
> the context.

Looks good to me, thank you.

I applied  this series to damon/next [1] tree.  We are now quite close to next
merge window.  It may better to focus on making mm.git more stabilized and
therefore ready for the next merge window, rather than adding more changes that
are not really urgent.  I understand this series is not really urgent.  Hence,
Andrew might not add this patch until next -rc1 release.  In the case, I will
request adding this to mm.git after next -rc1 release.  So, no action from your
side is needed for now.  Let me know if you think this is really  urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
