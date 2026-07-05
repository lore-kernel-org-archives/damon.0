Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FD4253958
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783288100; cv=none; b=GVN8LVIMF+kd2a6fcnMIX4ToJtYkUZWSgqACBBOCtl6pB1VV8EKoPEb32aMlT4LwH5zxMmenTLg7Sb356oDWjiiGw9jEoemUSWAOyPSxeR0YWE23acJFXLV4z5is17SF95w1ibmJ3eRO2Jq31G1JJdnz2B9MHZNNq6CcSsbAsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783288100; c=relaxed/simple;
	bh=eIaqD3u5pAfPlIHowPcAmQMxDyl/kjf847VH7fs1AP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItfX5e4vNfHm6Okf0EKFeiq0WKWKbdR9904sLtu3+zyXq0N8sute0Vj/zZTQaz8bPya57sKA0O0Z3wRibk3J2q6T2icpf2Evb5whjM8OdgG2R8O7Ckbd8SBvTGKBUbjG5zgdM07Y6YQct7VzuP3yxxNxsV24Tb+/qxQb6071/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVN0aSc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVN0aSc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934F81F000E9;
	Sun,  5 Jul 2026 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783288098;
	bh=mNzk4yP3noFb2V+6i433SyVEafaSDhXrkVmgesU2Zus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVN0aSc6FaT2isXW59riJqplSpl1bhti5eTTAcikG9joaIjdEr9GHCsAbk5bpmcIa
	 d1gmKWvHAUaeGfKLZeg4td62KOdBpfGvFwFBC/vgmljzijBxxHXIQr0VnVKHtZIz8F
	 YlLJ707F8LtVgeMEaPSW9kMYXOZfvWPJQUGCj0xYu6WvvtAvAnrALSEMaMTn35J4j9
	 2TsbHxVo8E7ItdcGO8Q9MzbyugU/okoJ8+dqyDa7E9n58pc2iIwAKqwHH9vT/mZKP1
	 P9wJaGS0RWCxHj/FuzQ0YhSTbBEavRixByr/htuFwJL1tMhc/zYtmKQfd7RosyYr0R
	 An0vm+PrWBNVA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 15/16] Docs/admin-guide/mm/damon/usage: document weight sysfs file
Date: Sun,  5 Jul 2026 14:48:10 -0700
Message-ID: <20260705214811.101516-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705210706.C09271F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 21:07:06 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Misspelled word 'atttributes' with three 't's in the added documentation.
> --
> 
> commit 0678cc4de62904aa4e60ad181dd2e6c07336bf2d
> Author: SJ Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/usage: document weight sysfs file
> 
> This commit updates the DAMON usage document to include the newly added
> probe weight file.
> 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index b2649ea011f93..4515088eba968 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> 
> [ ... ]
> 
> > @@ -286,6 +287,10 @@ In each probe directory, one directory, ``filters`` exists.  The directory
> >  contains files for installing filters for the probe, that is used to determine
> >  the data attribute for the probe.
> >  
> > +Each probe directory also contains ``weight`` file.  Reading from and writing
> > +to the file gets and sets the :ref:`atttributes-only monitoring
> 
> [Severity: Low]
> This isn't a bug, but there is a typo here. The word attributes is misspelled
> with three ts.

Good finding, I will fix this in the next revision.

> 
> > +<damon_design_attrs_only_monitoring>` weight for the attribute of the probe.
> > +
> >  In the beginning, ``filters`` directory has only one file, ``nr_filters``.
> >  Writing a number (``N``) to the file creates the number of child directories
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260705205743.98656-1-sj@kernel.org?part=15


Thanks,
SJ
