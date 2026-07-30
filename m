Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACF10F1
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370050; cv=none; b=RIAYfDiAbnKcZYz5wLegg9shJbxzb7Pn9m/T+4sBRetqZWtchGZ2yREl6y7kuNsuDQyKkveiLv9if/c5x5TvtZCsgJT3qOHCqKoPIYCAyrPzlpUxWRRS+LkhnvCWubYQj3Ei0l0b4HlGltYCWSObnPBKHtCxk3g6ScDQYyq+xdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370050; c=relaxed/simple;
	bh=NTgQDoAH6ggsXXpxLQZz40P/HFjH2B0q2FX4AYLEogE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3ltppMclJjuvNUNutKeH8JIxu+mFIZ5x7HQ6qsE/MDwkGQzFLeqUv2bTwIPIamgvEBxfLSRtjcINE0GprzHKxklj3RS7rjGmE2fpRMpadfAnLPtV+QbHVB+y+M8yFStGcfsld0SSGUFoAroTEkvZ6I0ZLh5io8+YwJZ/Y+jhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No1oM8zW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No1oM8zW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A521F000E9;
	Thu, 30 Jul 2026 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785370049;
	bh=uJRq/2SJ8LcXiMovd/XVDg6J9s+PxTk5bUnVy/xsNDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=No1oM8zW3b6KSJK/JPadzxGQJ+Ovv5XOIBGw0UB5mjFH6Aw2oW3XGqdzqc/uyuo9Z
	 sIAUVLmDwdLaweLkz5IkFlC/NeiGErxZyhT+HDUfpXx1N1pghBYF6af0+Bin/nGCmO
	 HA60jV62XplKT+bTuBdqvtNwermNEsH3dBQ93nReaVqLAM0UFURV0goCRVmF8V29Qa
	 Q5v66YXh1rsNt6zsT5G7YRQgB+3RfBho9mb190qQfrisd3LQG26N2IgwMcwU+rQGMR
	 NvtLMhxO5lY9/4EfzYjkRbbf0z1rn5FXg8xFArnnc2LVVwviy7EGOh7uNkc1dc5CEs
	 5C7U3bZBDOMNg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 6/6] selftests/damon/sysfs.py: test damon probes
Date: Wed, 29 Jul 2026 17:07:19 -0700
Message-ID: <20260730000720.100207-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729151934.3B8481F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 15:19:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] DamonProbe.stage() completely ignores the error returned when writing to the 'weight' sysfs file, masking potential write failures.
> --
> 
> --- Patch [6]: [RFC PATCH 6/6] selftests/damon/sysfs.py: test damon probes ---
> commit e47c18c7c1e4b19237b2738bc5c072c3c570dcc9
> Author: SJ Park <sj@kernel.org>
> 
> selftests/damon/sysfs.py: test damon probes
> 
> This commit extends sysfs.py to test DAMON probes by committing them via
> sysfs and checking the in-kernel status using drgn.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> > index 8c2dfc5ed8e04..852b6887a75ce 100755
> > --- a/tools/testing/selftests/damon/sysfs.py
> > +++ b/tools/testing/selftests/damon/sysfs.py
> > @@ -319,7 +319,21 @@ def main():
> >                  intervals_goal=_damon_sysfs.IntervalsGoal(
> >                      access_bp@0, aggrs=3, min_sample_usP00,
> >                      max_sample_us000000),
> > -                update_us 00000),
> > +                update_us 00000,
> > +                probes=_damon_sysfs.DamonProbes(
> > +                    probes=[_damon_sysfs.DamonProbe(
> > +                        weightB,
> 
> [Severity: Medium]
> Will this properly catch setup failures when setting the probe weight?
> 
> When testing DamonProbes, DamonProbe.stage() writes the weight to sysfs
> but overwrites the returned error status without checking it:
> 
> tools/testing/selftests/damon/_damon_sysfs.py:DamonProbe.stage()
> 
>     def stage(self):
>         err = write_file(
>                 os.path.join(self.sysfs_dir(), 'weight'), '%d' % self.weight)
>         return self.filters.stage()
> 
> If the sysfs write fails, such as the kernel rejecting the weight value
> or the sysfs node being absent, the error is silently ignored. Could this
> cause the test suite to proceed as if setup succeeded, leading to false
> positive passes or confusing downstream errors?

Yes, I will fix it.

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729144738.90895-1-sj@kernel.org?part=6
> 


Thanks,
SJ
