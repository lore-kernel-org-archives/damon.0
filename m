Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE53289E13;
	Sat,  4 Apr 2026 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336327; cv=none; b=XAijb5yC8teaYvmQNhveIKD3EL8z33dM7vG5eJVK6e3eD1ViyHSzjA6y3cLODJpvtIZt9duPbLF9MZmNUXufZLNeEfYWkT2w/+CzHPT2z8cyXEEprzMrqP7geLgeLcBtE9u3f8tCpdP2D4rOKpSdTWznyiRYHx32beOA0PT0v5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336327; c=relaxed/simple;
	bh=JjuMIdaMEdHQJUEtMAZ1M1peq0Edg56ahCnVKrCmJWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orNuezki4CsHhgPhSZYJ6GqIiNV1Rq2nETt5ayZHoiGFB8m9fJNzI6CZ08HBVFBJRoFrkDr+gkjoBj+2sFpYJHu7VkI8PRIzoLEfvtzVRmhjnyOgiQmwHfFcn04Z1NKYHFh5AtNlNIFx1Xd156b+8SUyU3MIzCmzNkRuO2XOmYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBEMj2I/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBEMj2I/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2251C19421;
	Sat,  4 Apr 2026 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775336327;
	bh=JjuMIdaMEdHQJUEtMAZ1M1peq0Edg56ahCnVKrCmJWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBEMj2I/xb5UVjhrDP+WtqhL8610rRzEFHBaQ4FiiURHmjaHAGZVcdmKgatJmT7GZ
	 8LdCLO1tNKZ3IDEcLD11AmZbUR8zQM7joWvk31sVOaRQnXxW0nY0C+nyrbdPlOi0h0
	 Dw8dOjexIprwCdfLrHlcB3NqzPA31V+p8x79Xg5Ox5Jwq+KhNZyyTHgsa+qpHwqDhG
	 KlkGxgwGq2P5Hi2fRZJ64JODvz+6j1KMkPDd5w8xKlJqEoRLh6gBC0EXg49EEGIE4L
	 SMC9MHhd3ckYgqHh+cTK/BHNzI4GNVRrkgAHm8ZGH8+aPTF7g5Ch+wUfRu1dSi/EN+
	 yaCI/JVKXBcRw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 3/9] Docs/mm/damon/design: document fail_charge_{num,denom}
Date: Sat,  4 Apr 2026 13:58:35 -0700
Message-ID: <20260404205837.87382-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dropped individual Cc's except myself to reduce unnecessary traffic.  I
initailly thought it would be good to keep Andrew in the Cc list, but even
Andrew may not really interested in each sashiko review for RFC patch, so I
dropped him from the list, too.

sashiko found issues.  I will fix those in the next revision.

Forwarding sashiko review in a reply format with my inline
comments below, for details of my view and doing discussions
via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260404163943.89278-4-sj@kernel.org
> # start of sashiko.dev inline review
> commit bab641e86f0e9820b2ac0a7d4ae493d23c4c50f4
> Author: SeongJae Park <sj@kernel.org>
> Docs/mm/damon/design: document fail_charge_{num,denom}
> 
> This commit updates the DAMON design document to explain the action-failed
> memory charging ratio. It provides an example of how to calculate the
> charged memory when an action fails for a portion of a region.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index afc7d52bda2f7..01047e8431d17 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -565,6 +565,27 @@ interface <sysfs_interface>`, refer to :ref:`weights <sysfs_quotas>` part of
> >  the documentation.
> >  
> >  
> > +.. _damon_design_damos_quotas_failed_memory_charging_ratio:
> > +
> > +Action-failed Memory Charging Ratio
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +DAMOS action to a given region can fail for sub subsets of the memory of the
> 
> This isn't a bug, but should "sub subsets" just be "some subsets" or
> "subsets"?

Good eye.  I will fix this in the next revision.

> 
> > +region.  For example, if the action is ``pageout`` and the region has some
> > +unreclaimable pages, applying the action to the pages will fail.  The amount of
> > +system resource that is taken for such failed action applications is usually
> > +different from that for successful action applications.  For such cases, users
> > +can set different charging ratio for such failed memory.  The ratio can be
> > +specified using ``fail_charge_num`` and ``fail_charge_denom`` parameters.  The
> > +two parameters represent the numerator and denominator of the ratio.
> > +
> > +For example, let's suppose a DAMOS action is applied to a region of 1 GiB size.
> > +The action is successfully applied to only 700 MiB of the region.
> > +``fail_charge_num`` and ``fail_charge_denom`` are set to ``1`` and ``1024``,
> > +respectively.  Then only 700 MiB and 300 KiB of size (``700 MiB + 300 MiB * 1 /
> > +1024``) will be charged.
> 
> Is this calculation accurate? Since 1 GiB is 1024 MiB, if 700 MiB are
> successfully applied, the remaining failed region would be 324 MiB rather
> than 300 MiB. Does the example intentionally use 1 GiB = 1000 MiB, or should
> the remaining portion be updated to 324 MiB?

Nice finding.  I will fix this in the next revision.


Thanks,
SJ

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260404163943.89278-4-sj@kernel.org

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260404163943.89278-4-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
