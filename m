Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955630F543
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 05:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808064; cv=none; b=lJ9O+ogVK/TmpytJEcIruBjdJk6ydz8V+LMTpFS5a4m2DPFa/uHajUBKA2Q0bfAvtsNix6BYqL9SRstxSSxddGIXwycxGwsmRUrcy6tm5m/pOeBp3JwmhbEcPlcRLM+4Uww7b3HLUXUHXlesyzlrH/1qlkGum1Bi6B6CSBipCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808064; c=relaxed/simple;
	bh=Xs/s11WGphczqqGhFF/k0kpbwdVyS4BiJpOApSBkpHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h19iWzQ6C3Q29gbRjO3pRDC1OD9G/13KOWcD4gu2tE0IsLy8Uin5dbYVFHgJbe26ISNgSbUt0gXd0lN5p+IKvXLi83BZikdrGzHcUrFKciK6DeusMS3SzvpgR3JM6flaqCCstT2AMpkaHYPeh6crurHqdCmO97OruPXG57fUd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D53U492b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D53U492b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C098B1F000E9;
	Thu, 27 Aug 2026 05:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787808062;
	bh=nCGtFWpQO0SRvR+hWValR8lWDjwJFGQ85QulRbsRZgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D53U492bOJZTovYwIQFclE7dQUbExB/6U688ikB/fbJmS9+SKhvbpmcz1X2gsMajW
	 iTPraIvOjfqvA6bDgNO9ttioKjLOYcM1xaH2RLnY+idqc2Yelu5mjSs/f+ztWfNNXG
	 gEkcl34kbFC5PmJHSwoJVLCW6iXJF6eQHUx3u0aCayQAmfudypaQn9NXHPWJHFb33H
	 M+3TiIRennw8iylr2UHOqyN9EkCWK6pEpoz2xUo/9IjfrLmAfcysDAPfPBIj4zoapx
	 oDxfyWrVxmyIxMMJsLBIugYze3a6OYhW9pIOhdXtZnn7CLMgDnluVmReni5BDH9prS
	 rWjcwL0zC/aZQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/2] mm/damon/core: initialize damos_quota_goal->last_psi_total
Date: Wed, 26 Aug 2026 22:20:53 -0700
Message-ID: <20260827052054.108913-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827045035.94611-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Aug 2026 21:50:34 -0700 SJ Park <sj@kernel.org> wrote:

> On Thu, 27 Aug 2026 04:45:47 +0000 sashiko-bot@kernel.org wrote:
[...]
> > [Severity: High]
> > This is a pre-existing issue, but does this switch statement omit the
> > DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric?
> > 
> > When a user configures a DAMOS quota goal using the
> > DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric via sysfs, a new quota goal is
> > allocated in damos_new_quota_goal() via kmalloc_obj(), where the memory is
> > not zeroed. 
> > 
> > Because DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP is missing from the switch statement
> > in damos_commit_quota_goal_union(), its nid field is not copied over during
> > parameter updates. This leaves the node ID uninitialized and potentially
> > causes eligible memory queries to evaluate using garbage data, completely
> > breaking the metric's functionality.
> 
> Good catch.  I will separately work on this.

Actually the fix will be quite straightforward.  I will add that as a part of
the next version of this series.


Thanks,
SJ

[...]
