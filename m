Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5E288AD;
	Sat,  4 Apr 2026 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775335960; cv=none; b=ZKUKi+JJ5ar8VcFj0r6DM8Ce7rilOdKTv2fXtsFDw8m0feuKIDrfflO80u5QYu2TxYkBWwDaWLRnsXeN8FlqKO2UX/WFm5wDNxAQ0YnclwY4gk6i+/80/DIDZW7OKf8tfJaK6VFDyohlkrHfH5LeGRykJZ9vITV0L0bbzWB+ph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775335960; c=relaxed/simple;
	bh=7kjl5Z0GP1aijdZFzpfKWtsCIIOBoEr3kfUnJsk2E94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/2xpRD07YCwKrIlI0vEd35qYcp0OR5ZxoGhJhUt5LMK4fcDoeD8HghMYxqcCJzqy+xghws2tJmQJzb5rF3PaGLjsrGexSnZRrJoQn+hf4aN9U7PBE+3otxyPNPb2ri/AJFaKOiEa13gpRtbUhAiDiLP6bfHalqyMlqejqNLba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3RuPKPe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3RuPKPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99F0C19421;
	Sat,  4 Apr 2026 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775335959;
	bh=7kjl5Z0GP1aijdZFzpfKWtsCIIOBoEr3kfUnJsk2E94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3RuPKPekgG2Q5g0yCtbfxBxUqXoJ5xUVdvpsj+/LFLyVlr7U+uhFpmRoyWVpybGU
	 Cl/cTXJyKftSZS4xo8DiBWBt+y8RKTFW/PwrRfuSRybVgNIaAfOcnyIdtDZOqV9c8b
	 MH9CSNRULfIQAgCWNoz8mwY6Rks+iEYZ1mdC+osb1DYCKXXnYdrONwig/i7JctBoyo
	 TwtxH/YicsQyAHPzGgZQhQLJxcmY/8CMfKPbJYF26DU9Akw7smNcGtZEcd8s5Zqo94
	 Org6Bgqr2jqsRJQfQAEkcbcO8MjcrFurVPfcvxE4kqYv9IcsQns5IHZjSLh9FVqs9F
	 foFB3xZZ1600A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 2/9] mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
Date: Sat,  4 Apr 2026 13:52:35 -0700
Message-ID: <20260404205235.87148-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko found no real issue for this patch.

Forwarding sashiko review in a reply format with my inline
comments below, for details of my view and doing discussions
via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260404163943.89278-3-sj@kernel.org
> # start of sashiko.dev inline review
> commit ee565644ac37e8bfceab5e62746d85906fb91b43
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
> 
> This commit implements the user-space ABI for the DAMOS action failed region
> quota-charge ratio setup. It adds two new sysfs files under the DAMON sysfs
> interface for DAMOS quotas, fail_charge_num and fail_charge_denom, which
> allow reading and setting the numerator and denominator of the failed regions
> charge ratio.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 5186966dafb35..d5bfba79f105f 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> 
> [ ... ]
> 
> > @@ -1663,6 +1665,48 @@ static ssize_t goal_tuner_store(struct kobject *kobj,
> >  	return -EINVAL;
> >  }
> >  
> > +static ssize_t fail_charge_num_show(struct kobject *kobj,
> > +		struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct damon_sysfs_quotas *quotas = container_of(kobj,
> > +			struct damon_sysfs_quotas, kobj);
> > +
> > +	return sysfs_emit(buf, "%u\n", quotas->fail_charge_num);
> > +}
> > +
> > +static ssize_t fail_charge_num_store(struct kobject *kobj,
> > +		struct kobj_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct damon_sysfs_quotas *quotas = container_of(kobj,
> > +			struct damon_sysfs_quotas, kobj);
> > +	int err = kstrtouint(buf, 0, &quotas->fail_charge_num);
> > +
> > +	if (err)
> > +		return -EINVAL;
> 
> Could this lack of upper bounds checking lead to an integer overflow when
> the scheme is applied in the DAMON core?
> 
> If a user provides a large value for fail_charge_num up to UINT_MAX, could the
> charge calculation in damos_apply_scheme():
> 
> (sz - sz_applied) * quota->fail_charge_num / quota->fail_charge_denom
> 
> overflow the unsigned long value?
> 
> For example, on a 32-bit system, an unapplied region of just 5 MB multiplied
> by a user-supplied numerator of 1,000 yields over 5 billion, which exceeds
> the 32-bit maximum limit. On a 64-bit system, a 10 GB region multiplied by
> 4,000,000,000 would similarly overflow.
> 
> When this overflow occurs, does the charged size wrap around to a very small
> value, causing the DAMOS action quota to be drastically undercharged and
> bypassing the user-defined limits?

That can happen, but shouldn't cause a real problem.  Meanwhile, adding such
overflow check would make code unnecessarily complicated.  I will keep this as
is.  If it turns out this causes a real problem, we can consider making this
better documented or updating the code later, after the report is really made.


Thanks,
SJ

> 
> > +	return count;
> > +}
> 
> [ ... ]
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260404163943.89278-3-sj@kernel.org

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260404163943.89278-3-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
