Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5373EDAA9
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512308; cv=none; b=FhZqPtrryL7Llvz5XDy2Ex2PofcDn2O5W9HlJ+5cwPH7vn2yPOHigmuRkP19pAVmjGOyeI5Ee2GTT+lHdahtOpfLGzv3VdzKEc9I0LsKy7fHNWuquyBFlIl7CChBxRyeTXzjp9dZRZ2Vrn5oYo9E6b+9CB/VcXAIIGJJkLMw1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512308; c=relaxed/simple;
	bh=vRh6cfVABnC8rbYLoersV1r+VLduurOfl8UOB/2umhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOukzUaGf9n4Gs7+BIbZkfIbI8Zt7P2dP5WPsc7Nv5sQwtHYC5bFlXd852CnkLAawJyCaEZKqfaMbUJ7jOaTt1tA9EwRqbTlM7lCYCVVTxQ0rIZ8FEBHFjhGNsAZ61KGa7xyRVJs9DxyHIb6K3tFOfJnHoXTP6u086fvlb0E4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bICY0Dq7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bICY0Dq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5321F000FF;
	Sun, 27 Sep 2026 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512307;
	bh=0vS160L1glxIrrTviirKIvJ/4Znz2Gy7OpOzPWKOhhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bICY0Dq7z1ehv+S9kf0RCLlzHBo959q1QUyyt0ySTXQ5Ly6p6kMhqd7kd9teDTWJU
	 TtWjlSrUmjkmtpSVSn+2LsPK6q1elVpnv+PkWTwLgWAwYmXLv7PEnumuOYihK5EeUM
	 XZ4fiOk86JyTaDpdOAaZYdOxdVak6fBbxH/qA+sBuHwt6LY9FhCP4FMdQEaT7CPwuA
	 NzCdsJWr+C+FFFaxQ0LjKaB+frXD1hJZrJUl4T+yKqGkhzpLOSpLby/c3sCQGSp7+U
	 5znIsksextn3xMZGv6WlZAeSpCgOaxmxqbTw4kV+7Wz4HYBLfkJk1Wld/7l/niTu2E
	 Ud0X3RVhB8EOA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v4 3/7] mm/damon/sysfs-schemes: support quota goal complement flag
Date: Sun, 27 Sep 2026 05:31:42 -0700
Message-ID: <20260927123143.58046-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927121953.2C2741F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026 12:19:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] damon/tests: build failure due to complementfalse typo
> --
> 
> commit c13d1579fc49797d69a40d8e22286757e16cdd20
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: add complement argument to damos_new_quota_goal()
> 
> This commit extends the damos_new_quota_goal() constructor to receive and
> set the complement flag value. It also updates all API callers to use the
> new signature to prevent manual configuration mistakes.
> 
> [ ... ]
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index df84d9cc7d204..20bba7421a406 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -930,6 +930,7 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
> >  		 * Make it kfree()-able.
> >  		 */
> >  		goal = damos_new_quota_goal(dst_goals[i].metric,
> > +				dst_goals[i].complementfalse,
> 
> [Severity: Low]
> Is this a typo? The struct damos_quota_goal does not have a complementfalse
> member, which causes a build failure in damos_test_commit_quota_goals_for()
> when the damon kunit test configuration is enabled.

Yes, it is a typo.  I will fix it in the next spin.

> 
> >  				dst_goals[i].target_value);
> >  		if (!goal)
> >  			goto out;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260927120533.50484-1-sj@kernel.org?part=3
> 


Thanks,
SJ
