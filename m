Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C222DB791;
	Sun,  5 Apr 2026 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417456; cv=none; b=N7zlW4Yr7+Km55pFTlwzqJS0QWowaLaO/oSPMcEt5bFrEWjol9qZGHQX2ArIGBfkGiKEvI1xMTrGlLH4XlF4O07/Idd5KUXKR87yOZxDSerCLNeEGMGRGI2aWGv712PuuMNPaht6wK6bD+S34mQtAO5MQgLq2jU7xRO2opmTn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417456; c=relaxed/simple;
	bh=1QNQpNTSfmMxXoXrDaRFueB6QVa4xuggWaTGAyI39qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3SV/jPwH9Z33ZMsgT7FGIE76KkzWCHMyM3RicutecNAKJoQaH3OF69LLpirylkWQrI0/XT/2d/+Pfb4VhE7jWVNUlq3uHwXx8nqnedeP/whIgAoyXdPUmPp9KM092JFK3d7Ccc95KeaYcecEgyBo+K3hy+T2jjLrq4erMb9AuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frzN249M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frzN249M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBA6C116C6;
	Sun,  5 Apr 2026 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775417456;
	bh=1QNQpNTSfmMxXoXrDaRFueB6QVa4xuggWaTGAyI39qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=frzN249M9ZZtE6NffDbKgnymInCMFwlgQOSgoKlR+VfwCW7gJKiFxzzRIqsSWYoXT
	 vtrRjQX5lYA22DSvRDYM7RkINm8p7efLN2acOYQQ/gNuiNZ1lEAGS++Hsox3CDm3dM
	 27jqchn6xHiHZvQqYlCJs2n4Y9JNXaEzS5Or+QaP017CYqZv5AeHQOWIuquD8q/Z9i
	 +OY93FSHujJdFUWfEbGhNYaWvC4KiLEgpAAJjkHrHPK1iBoMGDub80CgCGRVRBWHcR
	 GsS8HvnM3J1DC5HMA3y4g+PuLNycGRLgWU33YSZfVuX3hejtIuSGCkOhp8HFAQgl9G
	 YQ1TormpWOIcg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v2 2/9] mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
Date: Sun,  5 Apr 2026 12:30:43 -0700
Message-ID: <20260405193043.110172-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405151232.102690-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko found no issue in this patch.

Forwarding full sashiko review in a reply format with my inline comments below,
for sharing details of my view and doing followup discussions via mails if
needed.

> # review url: https://sashiko.dev/#/patchset/20260405151232.102690-3-sj@kernel.org
> # start of sashiko.dev inline review
> commit f076dcb3d9e8a7170daf7c4fcb085e3a2c869183
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
> [ ... ]
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
> Could this introduce a regression by allowing an integer overflow when
> calculating the charge ratio?
> 
> By using kstrtouint(), fail_charge_num can be set to any value up to
> UINT_MAX.
> 
> Later, in mm/damon/core.c:damos_charge_quota(), this numerator is passed to
> mult_frac(sz_region - sz_applied, fail_charge_num, fail_charge_denom).
> 
> The mult_frac() macro performs multiplications with the numerator. If a very
> large fail_charge_num is provided, could this overflow the unsigned long
> result, especially on 32-bit architectures?
> 
> When the calculation wraps around, quota->charged_sz could be incremented by
> a small or negative-equivalent value, potentially bypassing the DAMOS scheme
> quota limit.

Same question was raised to the previous version of this patch, and I decided
to ignore this.  Read the previous discussion for details.

> 
> > +	return count;
> > +}
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260405151232.102690-3-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260405151232.102690-3-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
