Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D32E737C;
	Tue, 16 Jun 2026 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571868; cv=none; b=Znqy7fFEnvRDskDo4Uel5PRcDUnOVwrPEVnoQwOVRQgwwKOotiT0huIReH/+EYGRFpE2n+S5i5yqdHrlWiWPmUiVbgOHfJRbPF1TUOYxq119xquvy4D6z6Vrm2ep3HWFKCmblzWZYE21zcL94nvagLD8eaEzvvynkvO8daRiG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571868; c=relaxed/simple;
	bh=OJ8Y5133l5l9mxYBYXKRWlvy9HhyNhEFaoeWJSOooV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoIihgqLESElyFpmr1ZtHTBCQeuJUf19hmuc0oyYHwGCa1zh8FXpJZGHK9dE1eC38y+eLcJO28xSwl9zrHkhqkMo2NEMTjndqi4Lwx7bNUrXNV87mCbja/TizHSJZErntOsCh9nb8Px6i85Muarh8Pp0yA7lHe9gacjEq0ERtd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu4i8jOq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu4i8jOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969681F00A3A;
	Tue, 16 Jun 2026 01:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781571866;
	bh=Ov1bJ3cICSDL6GNTG8BcHE0AZKSzTa1Ldumid0EFUbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cu4i8jOq0eb3nLKCzcpITLXPtCr9fQxHlDpRekjeQWrzFVLIrZelyMU3g54CfePun
	 +3rUIWfnHOiDB39IDH4TyZr0ZlrsH8/gHeXrQEegeqFHyO7pf1CQsEuD4vz6pYV0Wr
	 gSHCCEfMLLf3AnvWjDFqWGQFBGmf4qhNgkrUbfVazGsJQtLoHBo2Ptk+vGvJ5pLlu7
	 4yw8s1y0tJlFCG1RdL7CvAHT4BrjiOJzCc2vNOehv3LOycYv3GKcnGxCxLYSoNTZ1c
	 F9ThgSD1wo+aUIihZGd03MrX+KrQGhI80l7itVyb/m/dq6Tk2hqb/wqdWSsjEhZ47d
	 A4AlVn1TDyINg==
From: SeongJae Park <sj@kernel.org>
To: Philippe Laferriere <plafer@proton.me>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: use secs_to_jiffies() instead of msecs_to_jiffies()
Date: Mon, 15 Jun 2026 18:04:18 -0700
Message-ID: <20260616010419.142184-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260615214113.122923-1-plafer@proton.me>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jun 2026 21:41:43 +0000 Philippe Laferriere <plafer@proton.me> wrote:

> The conversion of a duration expressed in seconds reads as
> msecs_to_jiffies(5 * MSEC_PER_SEC), which obscures the intent and
> needlessly goes through milliseconds. Use the dedicated
> secs_to_jiffies() helper, which expresses the 5-second refresh
> interval directly. No functional change.

Thank you for this patch!

> 
> Found using Coccinelle (scripts/coccinelle/misc/secs_to_jiffies.cocci).
> 
> Signed-off-by: Philippe Laferriere <plafer@proton.me>

Reviewed-by: SeongJae Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree.  We are now in the merge window.
We (mm community) want to focus on making the stabilized mm changes be merged
into the mainline until the merge window is closed, rather than adding more
changes that are not really urgent.  I understand this patch is not really
urgent.  Hence, Andrew might not add this patch until next -rc1 release.  In
the case, I will request adding this to mm.git after next -rc1 release.  So, no
action from your side is needed for now.  Let me know if you think this is
really  urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
