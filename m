Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA13CCFC3
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512521; cv=none; b=XVyBjwp36/vPkGfbWMUhVB9Z2FXSkQ2P3FPx7HDwRgqCP/kCmV6JFH2LonQED5AeFmBA9M/5EUYn7z/A72sGFAJ0XvG3u14ooxPh9B3wSxu/HG7qivjqOxQaDqNByj3WV1zcGR0nRQFJQUSC4PlzQM6AnFiawrhJZbysR025OdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512521; c=relaxed/simple;
	bh=CZfNg/gmnc5EGRTvaNEHB/HV8CGrTnKrnCkGO7Lm2xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOAVG7P/gc0lMSqTDlUrCDhViaY4jkILRBe6ItD6VVd1d0qiZTnSuSxkEdZNsQppKV6FT6SWPOq8iOnXrkJvcq3YOFY0eYyiNAdzW2nDBSRtPhUhwIsxwHH4JlBdmS2VThqybPM/r5Bkvh8zGh2ISEyOHKH+mdFuS7aSmNCmbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9eUY/h6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9eUY/h6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EC71F000FF;
	Sun, 27 Sep 2026 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512517;
	bh=XkbIu6cj31ElbPcEGupnnznChPp+Ol1e4Ce7Sik+lHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z9eUY/h6rie9lGXTgl4QRZ+8QU2LGEJzehjbVK1F60Pvx1+f06XelH4bVrY/7Ydak
	 1uJpNk2wHASEpy9kZ1l7B5mt5fsV/12pI1MK3bcpWb5noB6y4gldiAk5B5kvzBO0fc
	 ifWKgM3mwRpDfE6Ly6LeJBR6OaT/MBdEzPvAIgNyQ4o5N8+tY4KgUIfbyIyY6yfVLB
	 3sV5A51kpwgGEA+FsmeETM8PlCTTX0Mfov6xUcM/rm1f2wW1hqdbmMCEZK9I3kaV4x
	 GPnCXCQbD2xIg7p5QpBYLLfIWcLb9KG/N9WGT/4TKlwmN1k+Q+cjzRc+VBfIL+GU3Q
	 zrWR6C/iT+nuQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v4 5/7] Docs/mm/damon/design: document damos quota goal complement flag
Date: Sun, 27 Sep 2026 05:35:13 -0700
Message-ID: <20260927123514.58286-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927121315.D21FD1F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026 12:13:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] kselftest/damon: missing sysfs test coverage for quota goal complement
> --
> 
> commit d3c6455ce7af443b98334d4d8484051c2827e265
> Author: SJ Park <sj@kernel.org>
> 
> Docs/mm/damon/design: document damos quota goal complement flag
> 
> Update DAMON design document for the newly added damos quota goal metric
> value complement flag.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index e82390e77a70a..5cd651b1b7aa8 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -702,10 +702,10 @@ There are two such tuning algorithms that users can select as they need.
> >    that the zero quota is a valid quota, and therefore ``qt_exceeds`` :ref:`stat
> >    <damon_design_damos_stat>` will keep increasing in this case.
> >  
> > -The goal can be specified with five parameters, namely ``target_metric``,
> > -``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
> > -mechanism tries to make ``current_value`` of ``target_metric`` be same to
> > -``target_value``.
> > +The goal can be specified with six parameters, namely ``target_metric``,
> > +``complement``, ``target_value``, ``current_value``, ``nid`` and ``path``.  The
> > +auto-tuning mechanism tries to make ``current_value`` of ``complement``-ed
> > +``target_metric`` be same to ``target_value``.
> 
> [Severity: Low]
> Does the kselftest framework need to be updated to cover this new parameter?
> 
> Looking at the selftests, test_goal() in
> tools/testing/selftests/damon/sysfs.sh explicitly tests for target_metric and
> other parameters, but lacks a check for the newly added complement parameter:
> 
>     ensure_file "$goal_dir/target_metric" "exist" "600"
> 
> Additionally, DamosQuotaGoal.stage() in
> tools/testing/selftests/damon/_damon_sysfs.py provides no fields or logic to
> set complement:
> 
>     err = write_file(os.path.join(self.sysfs_dir(), 'target_metric'),
>                      self.metric)
> 
> Could we add these test parameters to ensure the new sysfs feature is covered
> by the existing framework?

good catches.  Not blockers of this series, though.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260927120533.50484-1-sj@kernel.org?part=5
> 


Thanks,
SJ
