Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572E3BE154;
	Tue,  7 Apr 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577306; cv=none; b=T3G9rtI8Zpi2SO2yf0WOR+6t5w58b/tsC5ZHN7Y4HDaEdBgcLFCrCF5d5CSmGCCQ0qprXm+q0cADjMQrn+dUB2YNFZVeKGs9QStg0ZqJJD56RsTg0W6JegR+pg+9Wu+7377H4b3KBhFt4Qs1MVvupPcK0kRri8fI7LYfb4Sf56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577306; c=relaxed/simple;
	bh=bpiOOia207x4yViF+TMnhqBm+TS6r0k5rDi7kdxXoqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVobUlccm2SDlY7Qmywx0Usr/7fonyA8y5ijXg3KbV2p+Q+QrCrBZYb+WPL8toLaGnTSimM0JnjR75LL4Zecfgc5T84cnlVgdac5N+WpEqxIqEYDtqoCciluPsngPy8FIZv9eYwlSdEi38maD6VZTy4zGxJ8d9GEvu9MeRw0KQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvGPcHGp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvGPcHGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B660DC116C6;
	Tue,  7 Apr 2026 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775577305;
	bh=bpiOOia207x4yViF+TMnhqBm+TS6r0k5rDi7kdxXoqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvGPcHGpE6KxifNE0rA+t9kjNcOVdBVB8P3GNs3s1w1LXs5ObQfjTP973GmttIyE4
	 oVMnN7lH9vc8k+09gWz5W3bAgDLR7l/t6Vuer1CW86yU/5wPuyryOEDyceg2bFHHhJ
	 1tRgze+8qWfMjnh8vS1CTC2Ff5oqSf6uZd6XiWCTUfWa3aS3Lv91t+M728weIVjY0l
	 qtRyG3d6sDcpIVQDRWV76keeVXu7b2018sAElcp2gWSJKof1caU3UC3KWi06C2LAHa
	 9g0n1s39o87pVsfg/wxe09bMWYNDKQOKbQ3FqtBc+rBl/p4znEKZapqW4bxKv8hnAd
	 gH3yag2fCQZKg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v3 03/10] mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
Date: Tue,  7 Apr 2026 08:55:04 -0700
Message-ID: <20260407155504.51888-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407010536.83603-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko argues two issues that I think ok to ignore, so I will do so.

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260407010536.83603-4-sj@kernel.org
> # start of sashiko.dev inline review
> commit 233e1cffd501d91418c4d1f0badd7f5b509664c0
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
> 
> Implement the user-space ABI for the DAMOS action failed region
> quota-charge ratio setup.  For this, add two new sysfs files under the
> DAMON sysfs interface for DAMOS quotas.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 5186966dafb35..d5bfba79f105f 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> [ ... ]
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
> 
> Is it possible for large values of fail_charge_num to cause integer
> overflows in the quota calculation?
> 
> Because kstrtouint allows values up to UINT_MAX without bounds checking,
> the multiplication in mult_frac(sz_region - sz_applied,
> quota->fail_charge_num, quota->fail_charge_denom) during
> damos_charge_quota() might silently overflow the unsigned long capacity.
> 
> Upon overflow, the calculated charge wraps around to a significantly
> smaller value.
> 
> Could this artificially suppress the accumulated quota->charged_sz,
> causing damos_quota_is_full() to incorrectly return false and completely
> bypass the user-configured quota limits?

As I mentioned on the second patch thread, I will just let this overflows if
the user really wants to set such large number, since it will make DAMON
behavior bit weird but not breaking something serious, unless other humans have
different opinions.

> 
> > +
> > +	if (err)
> > +		return -EINVAL;
> > +	return count;
> > +}
> > +
> > +static ssize_t fail_charge_denom_show(struct kobject *kobj,
> > +		struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct damon_sysfs_quotas *quotas = container_of(kobj,
> > +			struct damon_sysfs_quotas, kobj);
> > +
> > +	return sysfs_emit(buf, "%u\n", quotas->fail_charge_denom);
> > +}
> > +
> > +static ssize_t fail_charge_denom_store(struct kobject *kobj,
> > +		struct kobj_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct damon_sysfs_quotas *quotas = container_of(kobj,
> > +			struct damon_sysfs_quotas, kobj);
> > +	int err = kstrtouint(buf, 0, &quotas->fail_charge_denom);
> 
> Can the lack of bounds checking on fail_charge_denom also contribute to
> unexpected behaviors or overflows in the same mult_frac() calculation?

Ditto.

> 
> > +
> > +	if (err)
> > +		return -EINVAL;
> > +	return count;
> > +}
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260407010536.83603-4-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260407010536.83603-4-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
