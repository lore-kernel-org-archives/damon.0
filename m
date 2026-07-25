Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD4346AE1
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785017205; cv=none; b=MdkWbMUEt/6tu+4cHp6K3tnp/6Ez1Rl7VPC3swF3ZVjDOcGljLusAYoS1tSLoDivyzAnkG0CKzXi+lYHKRk8GUT7hX2pkaezDnU1SJ8Sz/QSEORQykAf7DD9T/rX+Xm2LiFqiHD0QnUwfK97wJMN+ePqVBnzgYU0/wNBLKKW03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785017205; c=relaxed/simple;
	bh=nhUgazBn3aJK7/Y86hN5qPqJZdb2eKGPzgpuxrY3mkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkymBf4x4HDTthjrrPDSjwbfBlIAyiM8mfElSGhNT54JF6ebyhBxTQ+mZtorF9NR6C3SDy6FAbd4bUrOhEclPgjo+nN4AoMuBHzgpEt7i2x72IBsriOqbEkLNwh/uCAglIuvPxJ/OoJxRJhPxWwbjPaOkfIxpm3E5YzlzF6FaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKZakGkZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKZakGkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6E01F000E9;
	Sat, 25 Jul 2026 22:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785017204;
	bh=o2akdRdB3VQj29lmC+lOqJAYo4H84UFMz0Zt9iDKpIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VKZakGkZW+ILJXXvzUenu3CN7d/M2KU3t29U9CQsSysQgZOMasdIhKaH2SQ9yYFmp
	 ps5QRpAavqFTRc039e478R7yX2bUhovF98vBXTd/em7nr/bwX4M6y4lekxL7byfK7I
	 8K36JUBpgIRUz7k9LF0/uHtZoAe48AumTfKcUI+n8AkWTmG/6z645H9eOrd6+twUTy
	 X8PnprgLZjJetp+kfS/g4mjWjpuUwc3i5yYcjYGmy+x17CBNebEN0/OEkPVmT1aKpS
	 +CW/W5KIOdJuAsyPIaPWEZ4taV5l1YSj0ErOZFOfM4RXA0VDi2oQ7YM3JNyEmbvbbY
	 6SMuH8J7P9ztw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 16/17] Docs/admin-guide/mm/damon/usage: document probe preps sysfs files
Date: Sat, 25 Jul 2026 15:06:35 -0700
Message-ID: <20260725220637.137090-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210813.DFD701F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:08:13 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Multiple typographical and grammatical errors in the newly added documentation.
> --
> 
> --- Patch [16]: [RFC PATCH 16/17] Docs/admin-guide/mm/damon/usage: document probe preps sysfs files ---
> commit b237c3e5209fc4981028c7362f98db1f8e443546
> Author: SJ Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/usage: document probe preps sysfs files
> 
> Update DAMON usage document for the newly added DAMON probe preps sysfs
> files.
> 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index da5f9afd08aef..1f5a39e1fc38d 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> 
> [ ... ]
> 
> > @@ -283,9 +286,18 @@ In the beginning, this directory has only one file, ``nr_probes``.  Writing a
> >  number (``N``) to the file creates the number of child directories named ``0``
> >  to ``N-1``.  Each directory represents each monitoring probe.
> >  
> > -In each probe directory, one directory, ``filters`` exists.  The directory
> > -contains files for installing filters for the probe, that is used to determine
> > -the data attribute for the probe.
> > +In each probe directory, two directories, ``preps`` and ``filters`` exists.
> > +The directories contains files for installing probing preparation actions and
> 
> [Severity: Low]
> This isn't a bug, but there are grammatical errors here with "exists" and
> "contains".

I will rephrase.

> 
> > +filters for the probe, that is used to determine the data attribute for the
> > +probe.
> > +
> > +In the beginning, ``preps`` directory has only one file, ``nr_preps``.
> > +Writiing a number (``N``) to the file creates the number of child directories
> > +names ``0`` to ``N-1``.  Each directory represents each preparation action.
> 
> [Severity: Low]
> This isn't a bug, but there are typos here with "Writiing" and "names".

Good catch, I will fix.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725210225.129944-1-sj@kernel.org?part=16


Thanks,
SJ
