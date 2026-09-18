Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF14FC339
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744166; cv=none; b=qdVcB7DTiz1M5qkyaUsbRrSbLVoCzdyTOHcGocki+MIRgDC4srYWgvHJDRfEWPkuTBh3p5Q9qcuAEsMertrOqm+De62DSnW/5VxvGOx0AYyvbTIi11J9mRAoO5VqyRq/cyS4ViVczv3ptpLlDksW0igGpLrqxY3O6etp6KEHbo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744166; c=relaxed/simple;
	bh=Eft+OeJGEoS+rGtVktwAPxMSE8wW0o0LucaOpt99xyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KL3FjdVzTcdkc/a0pwoPu+6p+XNEvALUCOmfy6rVEgQ+WKR+F/hufORKq/+B0aFBWjl+YdoLUceVhQNnkO/jwCCKkXzzTipO2m46LS3UdCYDYMPeICX7dQ0IVOOx87a6AoN5vuob3v6kJhyckLLm9Lfk75Ke5GxMG5WqE20ouQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbN9owg7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbN9owg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D795F1F000FF;
	Fri, 18 Sep 2026 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744164;
	bh=3ksU396FFv7W3wSNnVJmckFWGLLNlZZfMPNLQXvKRz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JbN9owg70rC/FETxbbBlet2Ef3jLBq45GWsk4AarK/frsJ571K707LgZf09+L11IZ
	 DRZfcRVw2IzTlEPzx2rmxrey7JYQuG88l30y8FcEY0bRsXL6fNspTwip0EEEYq/cYt
	 olYl5+MisVVHZhryISJee7/iUgArm6pvOAMc8CRvwi0GnqNWxuKubg5xN5/uzm3iYU
	 Z3TayK84NQkzaQc2LwrpmL1YLVPsTkINJqWAqJGuCvJQTrPw0RaWAJeebhMVSMgOkT
	 jxbXgmrCWPgCeXlBI7RjzJhqKnl21lOzvD4C8oU+d2apERbeGo0+WzVDBx/14D5ZxE
	 RpDy+ahF7M8cA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/7] mm/damon/sysfs-schemes: support quota goal complement flag
Date: Fri, 18 Sep 2026 08:09:15 -0700
Message-ID: <20260918150916.86314-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918150536.9AA851F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 18 Sep 2026 15:05:35 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: unsigned integer underflow in damos quota complement calculation
> --
> 
> commit 8f39260b8b618fca6e69e55388bee135a86971f3
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: support quota goal complement flag
> 
> This commit adds a new sysfs file to support setting and getting the
> quota goal metric complement flag. It exposes this flag to user space,
> allowing the complement value to be passed to damos_new_quota_goal().
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 06af417bc9a2f..8f083611741fd 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> [ ... ]
> > @@ -2869,7 +2898,8 @@ static int damos_sysfs_add_quota_score(
> >  		if (!sysfs_goal->target_value)
> >  			continue;
> >  
> > -		goal = damos_new_quota_goal(sysfs_goal->metric, false,
> > +		goal = damos_new_quota_goal(sysfs_goal->metric,
> > +				sysfs_goal->complement,
> >  				sysfs_goal->target_value);
> 
> [Severity: High]
> Does exposing the complement flag to user space introduce an integer
> underflow risk for PSI metrics?
> 
> When the complement flag is enabled via sysfs for a
> DAMOS_QUOTA_SOME_MEM_PSI_US goal, damos_set_quota_goal_current_value()
> in mm/damon/core.c performs a direct subtraction:
> 
> 	if (goal->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
> 		goal->current_value = s->quota.reset_interval * 1000 -
> 			goal->current_value;
> 	else
> 		goal->current_value = 10000 - goal->current_value;
> 
> Because DAMON runs in a preemptible worker thread, natural scheduling
> delays can cause the elapsed PSI time (initially stored in
> goal->current_value) to exceed the nominal reset_interval * 1000.
> 
> If this happens, the subtraction underflows, wrapping current_value to
> near ULONG_MAX. This corrupted value is then used to calculate the quota
> score, which completely breaks DAMON's throttling logic.

I will fix the core logic in the next revision.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260918142827.85303-1-sj@kernel.org?part=3


Thanks,
SJ
