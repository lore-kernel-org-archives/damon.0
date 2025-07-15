Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC927991C
	for <damon@lists.linux.dev>; Tue, 15 Jul 2025 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618066; cv=none; b=cvI0T0aWBoL1DLJEn9DvUA//4o3T+QlP41AkYjo9E8XhgFavO2mQfOXeOcNN/J5b4iRkXp0ilYZpJFvdom/leuH9XT758/DBGfy7zuDoY21koTuU6+hDRz/GiHrNGXugb4LFACCfakmGLim0kH/U5CnmhAr4AzSAZyGybaa3xZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618066; c=relaxed/simple;
	bh=LuhtKMKEXKLjbj//2iu1jZAyZthZg3GLEu4j73vVHKw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TPCnn4DqTaT5xkM4reFEfZZjTFsU7gZxE4azJL+kLepyazM1SPlJBjEG7naikwO7K4PD0XW+oIDwMiTHiB5X7v8VlKs3PYZpr6TCpxd98QJ4Jbtr8g6bCPLdZdxTSWeiFPvoMZaBx/wT0zatHeSntV7o+CxCN6vSQ4MowrRqXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a3-6876d44aca76
Message-ID: <923d9fe1-b959-4fba-9da7-10d2b3126858@sk.com>
Date: Wed, 16 Jul 2025 07:20:57 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
 kernel-team@meta.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm/damon/sysfs: support periodic and automated
 stats update
To: SeongJae Park <sj@kernel.org>
References: <20250712204650.155988-1-sj@kernel.org>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250712204650.155988-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsXC9ZZnoa7XlbIMg5WHeSzmrF/DZvHkQDuj
	xZP/v1kt9l0Eche2LWGxuLxrDpvFvTX/WS0Of33D5MDhsWlVJ5vHpk+T2D1OzPjN4vFi80xG
	j8V9k1k9zl2s8Pi8SS6APYrLJiU1J7MstUjfLoErY9OqXcwFf8QrWpuvsTcw9gp3MXJySAiY
	SDT1nGGBsRfd3s0KYvMKWEo8mNXMCGKzCKhK/NlxjRkiLihxcuYTsHpRAXmJ+7dmsHcxcnEw
	C7xglDi/9zcbSEJYIEpi5+9+dhBbREBR4tzji2BDhQSMJRo2HAGrYRYQkZjd2QY2lE1ATeLK
	y0lMIDYn0BH/Xs1jhKgxk+ja2gVly0tsfzuHGWSZhMAZNokJi66xQVwtKXFwxQ2WCYyCs5Ac
	OAvJjllIZs1CMmsBI8sqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMBoWVb7J3oH46cLwYcYBTgY
	lXh4d1iXZQixJpYVV+YeYpTgYFYS4Z18CSjEm5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQ
	QHpiSWp2ampBahFMlomDU6qBccZ39xOHlm7uUZjAqRyfsERj9YQGNYECx8MsdiEXZy0+15vz
	5OJ90YPZ799Od84SVXvCefSppOQKqwvaeyMkq9MrNz9a+UDLYj9PwCyzf3cve1839lba4Sdn
	u+R3VtZBlr8bP00+tGED30O5h2cDf786dTXslrHb1mIRvf+JLcvXZfSu3Let6p8SS3FGoqEW
	c1FxIgA20qCBkgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXCNUNLT9frSlmGwY+DrBZz1q9hs3hyoJ3R
	4sn/36wW+y4CuYfnnmS1WNi2hMXi8q45bBb31vxntTj89Q2TA6fHplWdbB6bPk1i9zgx4zeL
	x4vNMxk9FvdNZvU4d7HCY/GLD0wenzfJBXBEcdmkpOZklqUW6dslcGVsWrWLueCPeEVr8zX2
	BsZe4S5GTg4JAROJRbd3s4LYvAKWEg9mNTOC2CwCqhJ/dlxjhogLSpyc+YQFxBYVkJe4f2sG
	excjFwezwAtGifN7f7OBJIQFoiR2/u5nB7FFBBQlzj2+CDZUSMBYomHDEbAaZgERidmdbWBD
	2QTUJK68nMQEYnMCHfHv1TxGiBozia6tXVC2vMT2t3OYJzDyzUJyxywko2YhaZmFpGUBI8sq
	RpHMvLLcxMwcU73i7IzKvMwKveT83E2MwNBfVvtn4g7GL5fdDzEKcDAq8fDusC7LEGJNLCuu
	zD3EKMHBrCTCO/kSUIg3JbGyKrUoP76oNCe1+BCjNAeLkjivV3hqgpBAemJJanZqakFqEUyW
	iYNTqoHRWUQ8smSj4hmjMPHvf/y8IiWvzokJMDqrd+4Ri67DoZbl0keWq2ameEvL/sx+HWDr
	pipZocm9bMvM7EPd1a8e5ojddHF96fbeYacrA//ak5OuHE75pb6+1e5VeZOh5gNfWbb9UskF
	C/8+PpZ0/MDGu/uTtxnMUrG9c5VhqXRiVdOuxhebd7xXYinOSDTUYi4qTgQAqqXJRXkCAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

On 7/13/2025 5:46 AM, SeongJae Park wrote:
> DAMON sysfs interface provides files for reading DAMON internal status
> including DAMOS stats.  The content of the files are not automatically
> updated, though.  Users should manually request updates of the contents
> by writing a special command to 'state' file of each kdamond directory.
> This interface is good for minimizing overhead, but causes the below
> problems.
> 
> First, the usage is cumbersome.  This is arguably not a big problem,
> since the user-space tool (damo) can do this instead of the user.
> 
> Second, it can be too slow.  The update request is not directly handled
> by the sysfs interface but kdamond thread.  And kdamond threads wake up
> only once per the sampling interval.  Hence if sampling interval is not
> short, each update request could take too long time.  The recommended
> sampling interval setup is asking DAMON to automatically tune it, within
> a range between 5 milliseconds and 10 seconds.  On production systems it
> is not very rare to have a few seconds sampling interval as a result of
> the auto-tuning, so this can disturb observing DAMON internal status.
> 
> Finally, parallel update requests can conflict with each other.  When
> parallel update requests are received, DAMON sysfs interface simply
> returns -EBUSY to one of the requests.  DAMON user-space tool is hence
> implementing its own backoff mechanism, but this can make the operation
> even slower.
> 
> Introduce a new sysfs file, namely refresh_ms, for asking DAMON sysfs
> interface to repeat the essential contents update with a user-specified
> time delay.

Thanks for working on this, but I have a few questions.
1. Could you please list up what are the "essential contents"?
2. Does it mean that it is different from writing "commit" to "state"?
3. If not, then is there equivalent action to writing something to "state"?

If possible, then this kind of information is better to be documented because
users might get confused if something isn't udpated when "refresh_ms" is set.

Thanks,
Honggyu

> If non-zero value is written to the file, DAMON sysfs
> interface does the updates for essential DAMON internal status including
> auto-tuned monitoring intervals, DAMOS stats, and auto-tuned DAMOS
> quotas using the user-written value as the time delay.  If zero is
> written to the file, the automatic refresh is disabled.
> 
> SeongJae Park (4):
>    mm/damon/sysfs: implement refresh_ms file under kdamond directory
>    mm/damon/sysfs: implement refresh_ms file internal work
>    Docs/admin-guide/mm/damon/usage: document refresh_ms file
>    Docs/ABI/damon: update for refresh_ms
> 
>   .../ABI/testing/sysfs-kernel-mm-damon         |  7 +++
>   Documentation/admin-guide/mm/damon/usage.rst  | 13 ++++-
>   mm/damon/sysfs.c                              | 58 +++++++++++++++++++
>   3 files changed, 75 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 982b86e9191292ffcd0f30018981cb16f9fac5c1
> --
> 2.39.5
> 

