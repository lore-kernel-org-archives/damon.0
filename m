Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406F3921D1;
	Fri, 10 Apr 2026 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865502; cv=none; b=Aag6tVRceGBcUHPgjR3FRyiuoGTT1rNMg2ViYqNB39O0bpwKgmSqaDNakbUdIG5kD2BS1QOYOirlYmbYBDkzbiTPmBmVIbuyk/1YdiIlsp1D03QES1gi44qqpAnIA3/xlu47sYaNusANQlcIzF29N2epHScHj5CA+NDFcLgGMv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865502; c=relaxed/simple;
	bh=u6dUJAiT+Pm0l56lG2RUtGPm/TrRVQse8BkRehkw5Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owi5Qm7/MevP+SnRMjpuO7XnUvqc2uXboH4o6KFqWnE5W85yr6bPeA/YNK7qK2JGhCzy1cKGK0bdH3NXJLwrWeXYxAqLhWrzNzaeSA3vsyDHwbihljuCdJ5cEJe1aRFv6tYVPVUCtSmgCxNSrK5Xyy/BdHKtzP2eaos2bd7bMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2fUmmAw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2fUmmAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF204C19421;
	Fri, 10 Apr 2026 23:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775865501;
	bh=u6dUJAiT+Pm0l56lG2RUtGPm/TrRVQse8BkRehkw5Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2fUmmAw08Qwd7I9H/YkS6V49OVT9cnwKs2ul0tRBzEVbsIIzHzcEZI5VmE2sQwPK
	 evshluf+HwhFM/S7LAg02cB0gfchFnW9Xomf4eSdo37ph8cKMumr2cq7SUqFG6WsE5
	 kgk/+mad9S5QkOz+1PYKWO5DImEkSTZ7J09KQ7icUugX/7oGr2+uJ0u9YdYZH02/Yq
	 rueOzDq5GphY6gWk+bvl7RZWgRge5k40vqrLjye/V51/NF+/B4UQ9AS8JVeu6dcUmE
	 Ay3awib8Z3YndRRjjnFwFyx5sxQ6L7LJpSfMwGt6Q9HqsG5lW/1jdj5KfJwgRc5tld
	 WhqgSunWu0Swg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 04/11] mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
Date: Fri, 10 Apr 2026 16:58:18 -0700
Message-ID: <20260410235819.91133-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410142034.83798-5-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko asking a question that was raised on the previous version and I
decided to ignore.  My opinion is still same.

Forwarding sashiko review in a reply format with my inline
comments below, for details of my view and doing discussions
via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260410142034.83798-5-sj@kernel.org
> # start of sashiko.dev inline review
> commit efc09e724c58ae44645ba20d1865e976eae67242
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
> 
> This commit implements the user-space ABI for the DAMOS action failed region
> quota-charge ratio setup. It adds fail_charge_num and fail_charge_denom
> sysfs files for reading and setting the numerator and denominator of the
> failed regions charge ratio.
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
> 
> Could unbounded values set here cause an integer overflow in
> damos_charge_quota() on 32-bit architectures?
> 
> Because kstrtouint() allows values up to UINT_MAX, fail_charge_num and
> fail_charge_denom can be quite large. When these are used in mult_frac()
> for calculating the fractional charge:
> 
>     mult_frac((sz_region - sz_applied), quota->fail_charge_num,
>               quota->fail_charge_denom)
> 
> The mult_frac(x, n, d) macro computes (x / d) * n + (x % d) * n / d, where
> the types are determined by typeof(x). Here x is an unsigned long.
> 
> If userspace provides large values like 1,000,000 for both the numerator
> and denominator, the remainder (x % d) can be up to 999,999. The
> intermediate multiplication (x % d) * n could be around 10^11, which would
> silently overflow ULONG_MAX on 32-bit systems.
> 
> Is this potential integer overflow a regression that results in an incorrectly
> small fractional charge, causing DAMON to under-charge the quota limit and
> bypass the configured scheme quotas?
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260410142034.83798-5-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260410142034.83798-5-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
