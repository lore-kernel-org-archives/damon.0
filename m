Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39541078F
	for <damon@lists.linux.dev>; Sat, 18 Jan 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737164830; cv=none; b=hIGdPQ41HnhzcF1UXjHUo+Hgo5L/6faytri2S+yj0JTV6KmAuZ9cYXKWIagMC6oRW6cRjuVEPgIxq7mnYIZp0PzF4F9kw5HMe3uyYodPntJ2v3JWFMp+JQaQWRgD8569cAoGm6xiOEk1Z+Ctj8eTqZReMsoYo4Sh5VzWT7pNc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737164830; c=relaxed/simple;
	bh=BYg/j7bT2AKoVbpvaulMKm0Qwq9+2NyOYI76DiR5YT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPX+PB++DpfKsrdfD7G6kyoKruV5R9bpBUCVEqKoR2VWgWF9vUqWbqyV+4lhy0rpJskxptWSKD70n2ew8xgBEqNbBhQPNLg5iJNBTMPGb8K0eTqfuT1EL+K0u3MNpQ2FAhJ0Mzc3GZh3Hatz+nH28cBtENb35JLWsCzFAJKOzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mod+4dgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mod+4dgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E56C4CEDD;
	Sat, 18 Jan 2025 01:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737164830;
	bh=BYg/j7bT2AKoVbpvaulMKm0Qwq9+2NyOYI76DiR5YT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mod+4dgEuJ6ug8Y9AnJhD5zA98P4aYPyNk2+Vj3X0b8ly5KSWZCIUDCKzadmVrM3J
	 8zwZgy7/XjbUyiE5yX9zAdany0nAEFbOhilLAro5+HHbeMeKA2w3iIpuEWxuFlPw0F
	 WOJmQQDQxiwrcfvnsVopDzpopawCNxJFEqNumXEJwzj77P9OpAvzVJEe6KwjRn9kEc
	 /XNJuAI9bx5LtWbg8ZhXc1mnlE4yfVc0YwV4bQyNFDBF39GXnJD/7WatCYPZUqMorq
	 hC0/oHp9FISbVHAJvmom1idcoZVNL7LwYKafwa+EWcrZBUxX39T+IQx02eP9+lhF8X
	 hITK8to9QEUJw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: Two simple ideas for DAMON accuracy improvement
Date: Fri, 17 Jan 2025 17:47:06 -0800
Message-Id: <20250118014706.76776-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241026215311.148363-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 26 Oct 2024 14:53:11 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello DAMON community,
> 
> 
> There were a number of grateful questions, concerns, and improvement ideas
> around monitoring output accuracy of DAMON.  I always admitted the fact that
> DAMON has many rooms for improvement, but was bit awary at changes for some
> reasons.  Now I think it caused some unnecessarily long delay.  Sorry about
> that.  Now I want to invest some time on the topic.  So starting by sharing
> below two simple ideas first.
> 
> User-defined Regions Split Factor
> ---------------------------------
> 
> DAMON's "Adasptive Regions Adjustment (ARA)" mechanism splits each region into
> randomly sized sub regions, show their access temperature, and merge back
> adjacent regions having similar temperature.  The split factor is hard-coded as
> two.  Increasing the number make DAMON regions more quickly converges in right
> shape.  However, it makes number of DAMON regions in usual situation higher,
> and therefore induce more overhead.  It will still keep the user-defined upper
> limit (max_nr_regions), though.
> 
> The optimum value of the split factor would depend on the use case.  We will
> therefore add another knob to let users set the factor on runtime.  The default
> value will be two, so this will not introduce any regression or behavioral
> change to existing users.
> 
> Periodic Fine-grain Split of Aged Regions
> -----------------------------------------
> 
> If a region is continuously changing its boundary and access temperature, it
> means it is converging, or the access pattern of the workload is not
> stabilized.  Either case, this is a healthy signal.
> 
> If a region is consistently showing same access pattern for long time, it may
> because the access pattern is stabilized, and the region is correctly
> converged.  However, it might be because the access pattern is changed, but the
> converging is slow.
> 
> To avoid the too slow converging of aged regions, we will let users
> periodically increase the split factor for regions that kept current access
> pattern for long time (high 'age').  Users will be able to set the 'age'
> offset, the split factor for the aged regions, and time interval between the
> periodic fine-grain split of the regions.  For example, users can ask DAMON to
> "split regions keeping current access pattern for ten minutes or higher to five
> sub-regions every minute".
> 
> The feature will be ignored unless users explicitly set those, so that it does
> not introduce any regression of behavioral change to existing users.
> 
> Discussions
> -----------
> 
[...]
> I believe implementing the features would be not difficult.  So unless someone
> voluntarily steps up, I will start implementation of the features, targeting
> v6.14 merge window.

TL; DR: The features will not be available by 6.14.  Please make a voice if you
want the features get prioritized.

I still think the above features can be useful.  But I was unable to make any
progress for those due to other prioritized works.  Linux v6.14 may be released
on upcoming Sunday, so I don't think we can make it on it.  Sorry if you were
waiting for the features.

It's also not clear if we will make it on the next major release.  I'm now
trying to prioritize the monitoring intervals auto-tuning[1].  Please make your
voice if you want me to prioritize the development of the features, or step up
if you want to implement some of those on your own.  I think the first feature
(user-defined regions split factor) could be a good DAMON-beginner's task.

[1] https://lore.kernel.org/20241202175459.2005526-1-sj@kernel.org


Thanks,
SJ

[...]
