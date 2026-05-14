Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A7390990
	for <damon@lists.linux.dev>; Thu, 14 May 2026 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797692; cv=none; b=Jc6vg31YoGoYMHTlWPSrpstV51nSiNRxRve+BPr+Z7SM+PvyMyWQAKokQqmPS5g6SNl/V+n3N2vHS0jjgumg3uNijgi3q/1C0m1gUuBbrYZfviHwFPvlbfSW5dfXjzCi7J0qGPXKG6UbqLpj3jXbz5OzB2Lo8HYK/+wCLUWW0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797692; c=relaxed/simple;
	bh=yocSHA6mtMitwpJgEJ++nHtgXbYW8U5lSR1gVEr0FGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dZr2WSm1cmnjMMKoxjo0qabOGmCb/kjj2x98BFNjQ16UpQARrIaartYSKnAOjx8aJWbwU/hIHeZeJJWgwmwQ2+07fUVJe9COOI2sHYFXCer7R4wZAK1JC82NPppxH6HMEAkqhokBVN9Clsx4v2sSDppWy2bTCTRDwCKdV1OOSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d/s13rNg; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d/s13rNg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778797678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35+aOLZYCJOIgr3hdyL+9n448Kqo/As9pT7sb3XObfQ=;
	b=d/s13rNggnjd7bnd4CNJqRtLbTaO+0gieeY5kpQZngzdcmR1TskTLgD3Ucf5ekWo57Gwpm
	E2S5xDhJeZfKxHB9ItTdqZZ37GZ81Ox6YxVLwnr2KCMXtaMuRmjjmuRZEQoFntltMMC9cT
	I53KeCqCM74QEfkWtMwtsOOFfBcxUjc=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko@lists.linux.dev,  damon@lists.linux.dev
Subject: Re: When Sashiko updates baselines?
In-Reply-To: <20260514205555.51653-1-sj@kernel.org> (SeongJae Park's message
	of "Thu, 14 May 2026 13:55:55 -0700")
References: <20260514205555.51653-1-sj@kernel.org>
Date: Thu, 14 May 2026 22:27:53 +0000
Message-ID: <7ia4pl2x62za.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

SeongJae Park <sj@kernel.org> writes:

> Hello,
>
>
> I posted my patch series [1] after rebasing to the latest mm-new
> (0cec77cfd5314c0b3b03530abe1a4b32e991f639).  And Sashiko smartly tried to apply
> it on the mm-new, but an older version of the mm-new
> (7505bb13a9bb1f214310915ccc06643119fdafc9), and therefore failed [2].
>
> I could rebase my series on the older version of mm-new and repost, but
> wondering if Sashiko will use the lateset mm-new for the new version and fail
> again.  Is there a way to predict what baseline Sashiko will use, or give a
> hint [3]?

Hey SJ!

Sashiko is periodically fetching from remote repositories, but not on
every patch (that would put too much load on kernel.org). There is some
heuristic in place, but it sounds like it's not perfect.

I'll take a look.

Thanks



>
> [1] https://sashiko.dev/#/patchset/20260514140904.119781-1-sj%40kernel.org
> [2] https://sashiko.dev/#/log/baseline/20264/2
> [3] https://lore.kernel.org/sashiko/20260426204746.93567-1-sj@kernel.org/
>
>
> Thanks,
> SJ
