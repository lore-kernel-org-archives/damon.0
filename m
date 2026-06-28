Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4D374735;
	Sun, 28 Jun 2026 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782682934; cv=none; b=t3O1oFl82kf6uOuZwkCjTp4/sTnREppi1snudSWHioViLJNonK3I5CFWk5aC1xbdNC1ue8Flp83bacSzHkwxCFsB4T1ytc0IvQc+o+iU+uX0xGvGvwm0Tw9JRFe2aMwJRneX5hABN2dSjKNOylDGJn3OIAUDFs5M163xOocvzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782682934; c=relaxed/simple;
	bh=jDqk4rAnBBz+pHzIPz/8ZmuIj2JF44Jakg0T1AJv+T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyPu0mvgdD2lJCxBAeSRKMiR7MksO1g9MllEVtW0qv18QJ/GfrUs1u4TrHQ/aXxGJ0s2sVZlHS0mR/aTliy6x1EpQZuJbso47seCy0oQ6aW+0/8i9TKaEIYaTPwkFXQPQE/komEYEaXq7dBZvvCDmYuxBTSoWK6exQ/IeCJCNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzQP8hnP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzQP8hnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338D41F000E9;
	Sun, 28 Jun 2026 21:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782682932;
	bh=EbdMQQtZX/wQMqAhMHFL3ANnWsMXWow+5Kt3DUx2tcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzQP8hnP9w8tQjAlNhhCeNJYVMnTumfbEguSTvHdROlE3x2ub3H8uev+FllmpXJeS
	 oPo2iWuJKX6ISqKynapiZz6QoeBPP4NZD0gm5+iqS4JWa5iaRtT//0im6OL1xEaoDK
	 33iz663ery6mQiUmLZSH+tcf5X0vgl9juP3G2kI9qzRNzOk5PiXJ199LNZwA5gWy/N
	 2PhfWqdBjRrs74m7xEZ2YN3U6w6USTiQZEfPmTw09Ipd8GiHthMFYzDVYoXotO4q0C
	 l0AU/vgxJjIoEmkqN731PVuP4oFOgIw4P13A8e/XLn9oI/mlPD46eUhjyBzX7FOVgs
	 5SxIVvR4BkfFA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Release Newsletter for v7.2-rc1
Date: Sun, 28 Jun 2026 14:42:08 -0700
Message-ID: <20260628214208.94619-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628211904.94361-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026 14:19:03 -0700 SJ Park <sj@kernel.org> wrote:

> Hello community,
> 
> 
> This newsletter covers DAMON features that landed on the mainline, queued for
> the mainline, development statistics and misc events that were interesting to
> me that happened in v7.1-rc1..v7.2-rc1 time period (2026-04-26..2026-06-28).
> 
> The newsletter covering the previous release cycle (v7.0-rc1..v7.1-rc1) is
> also available [1].
> 
> TLDR
> ====
> 
> The last development cycle for DAMON was the busiest cycle of its mainline
> history (~6 years, since 2021 September).  12 Authors landed 106 DAMON patches

s/6 years/5 years/

Sorry, I'm definitely not good at counting.  Sometimes even worse than LLM.

> for a number of changes including 7 new features on the mainline.  A roadmap
> for extending DAMON to utilize AMD IBS, Intel PEBS like h/w features and do
> per-CPUs/threads/reads/writes monitoring is made.
[...]
> The 6.17 development cycle was the busiest DAMON development cycle in history
> (~6 years since 5.15).  This cycle broke the record.

s/6 years/5 years/


Thanks,
SJ

[...]
