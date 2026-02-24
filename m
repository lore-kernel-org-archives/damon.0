Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76771A073F;
	Tue, 24 Feb 2026 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898095; cv=none; b=uZGgc2907Fcfa2r6oj3MkDZbwN6yCdxzDTnSches1wdCZQ1U0sk0F+dXUnA0xCt/IYut6AS9ijMt+uRXvizJkHY7qcgKpZBxVwOLqfOkuqEQXDjAjTHvJ+RWBr0kY4vkftl1vcGjnj0sxq8JIhDxgKcJK4pGzOZZlrT+HAAdrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898095; c=relaxed/simple;
	bh=ShmNycpJjFAr5FPie2HkibrMbfPM533UhWG1r/u6bq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VD2sr8aNxX4tfxK5Hi3bhLVI6ChvrP3hFHdRWjGKoRGZB4iU5U9O4RhIkpH8XNrzeIen7U1czC/095mCDgnra2UCF615Y6Xs0h15KNs9RTpl3kx2MO2S77JXIMbz+Rz2oWvAhgJjJRRwrdzk5v7pTBloKIju1T4iIV2rfvF++pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiBDSnKh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiBDSnKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1202AC116C6;
	Tue, 24 Feb 2026 01:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771898095;
	bh=ShmNycpJjFAr5FPie2HkibrMbfPM533UhWG1r/u6bq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MiBDSnKhOK5Qq9mmcTFXukIsQdfDvtLh8mSQqgt9uK3OlV8LqQDSBys2Z735Ss7e+
	 GcZScbjOca8l0KHbX4je9tDYvzulXti1ltBnOL6JktwVd8/QHMkFxC7c26w1f7ZnVn
	 2ISU0ekUzUtFLBZUmj6aS7jYWZ1K3JRMZSHSAvqlowuDVuAGhWCPi2AcBGFADhqjGQ
	 kuj2uUv8u0s8Zvo8day3Z1/fv+EFYFL8Kc2lRX34dCq3bNRrecNQeW4l/D3oe97au0
	 QlUAQ7mSqQhBQcb7cqK5P9IOTMaDKK0FPWLJrPX/OGf6HtyBoSyKclkJ6V34WYhpW+
	 eaPmTs2kheVtg==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v3 2/4] mm/damon: fix esz=0 quota bypass allowing unlimited migration
Date: Mon, 23 Feb 2026 17:54:52 -0800
Message-ID: <20260224015453.56879-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223123232.12851-3-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Feb 2026 12:32:30 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> When the TEMPORAL goal tuner sets esz_bp=0 to signal that a goal has
> been achieved, the quota check was not actually stopping migration.
> 
> The condition:
>     if (quota->esz && quota->charged_sz >= quota->esz)
> 
> When esz=0, this evaluates to (false && ...) = false, so the continue
> is never executed and migration proceeds without limit.

Nice finding, thank you for sharing this!

> 
> Change the logic to:
>     if (!quota->esz || quota->charged_sz >= quota->esz)
> 
> Now when esz=0, (!0 = true) causes the continue to execute, properly
> stopping migration when the goal is achieved.

But this code is written in the way because the current code assumes zero 'esz'
means it is not being used and therefore be ignored.  This change should be ok
for your use case, but could introduce an unexpected behavioral change for
other users.

One easy workaround would be setting esz_bp with a value smaller than 40960000
instead of 0.  That is, esz_bp is the bytes in bp, so setting it smaller than
40960000 will result in making it effectively zero, e.g., like below.

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2623,7 +2623,7 @@ static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
        unsigned long score = damos_quota_score(quota);

        if (score >= 10000)
-               quota->esz_bp = 0;
+               quota->esz_bp = 10000;
        else if (quota->sz)
                quota->esz_bp = quota->sz * 10000;
        else
'''

But maybe there is a better way to cleanly fix this.  Let me take a time to
think more...


Thanks,
SJ

[...]
