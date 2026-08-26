Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B31922FD;
	Wed, 26 Aug 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753117; cv=none; b=ioCxe8rIq4+WbFl+ECIFRt2Hut6vbt2Oo9mj8+ReP0gMVB6OsupdbQnxv1dNMfZafnSnTN03X2o7s1ginaadV+4BGazKmJTSMBBftD5eLIvkAYx/Hza7+dzFclQb/JM5ANTkerPisYQZKTnm1AP3DjLhycpitl34H+ucdD4md94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753117; c=relaxed/simple;
	bh=rCQV25oSfeZIOmfntnhqYkPhXHKaWWgDfG1pGhK9F10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8/ItR5QaqwoSsronMdThY2RC7Fzi4ZEEHxM/1/6V0tscS2SGavxrYE0WSWS6KsP/SJ0SciFuSd62s3qY3FUKi8AB3uau26jqoLBefF0Y0FPU11rm3sMndG+5m+g26QvKOn3wVpzeYGtYqYVA+iDAxr7FSF6q8R95DJHn3h2euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HV6638uc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV6638uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9291C1F000E9;
	Wed, 26 Aug 2026 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787753115;
	bh=899z5FOtzHECz2XWsKWnE5Ec9BBHfzGqQfwyQYF2l+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HV6638ucyNINBTmK0lEdfSWSwq99c7H7xz4cYjXlLUBJZJ9WaqnhaWV96BDAiQzVP
	 UXUQTCZb+FeccxQm7e3l/m9wq9ffhXi/IGI7IDzMMppk3cyqaVMgU4uSdL4+NIaXQB
	 8pgiRfLD2VOZ0loBSfJcEC1z7bnc8VYL2m9N7I+0LgLsEqtvbghcbl4RWnoTDAtLG2
	 TQ6crBMP0Oe0QM8VhHRnjKCjrCjB4sEFVRC61H2XALqcPuNCxLK6WmK5U61jWTpmvJ
	 Jq2qcpdrT5LyRwyYAln5+OUEdcn0qRyF29arNK2LCYAt6o0Lb7bCRggqhcVqw2Twb6
	 ysSgGJRF6akAA==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Wed, 26 Aug 2026 07:05:08 -0700
Message-ID: <20260826140508.74447-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826102413.8466-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Aug 2026 18:24:13 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Tue, 25 Aug 2026 06:54:57 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Tue, 25 Aug 2026 20:46:16 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > DAMOS uses charge_target_from/charge_addr_from to remember how far a
> > > quota-limited walk has progressed.  The current implementation has two
> > > problems:
> > > 
> > > 1. Once set, the cursor unconditionally skips and resets at the last
> > >    region of the tracked target, so the last region can be skipped even
> > >    when it has not been processed.
> > 
> > I don't fully understand this.  Could you please clarify more?  Maybe adding a
> > realistic example scenario would be helpful.
> > 
> 
> Problem: Unconditional skip of the last region
> 
> In the current damos_skip_charged_region(), there is this logic:
> 
>     if (r == damon_last_region(t)) {
>         quota->charge_target_from = NULL;
>         quota->charge_addr_from = 0;
>         return true; /* Skip */
>     }
> 
> Scenario:
> 1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
> 
> 2. Quota is configured to process only 50 bytes per window.
> 
> 3. Window 1: Processes R1 (0-50).  Quota is full.  Cursor is saved at
>    (Target, 50).
> 
> 4. Window 2: Skips R1 (0-50).  Processes R1 (50-100).  Quota is full.
>    Cursor is saved at (Target, 100), which is exactly the start of R2.
> 
> 5. Window 3: The loop reaches R2.  Because R2 is damon_last_region(t),
>    the old code unconditionally returns true, skipping R2 entirely and
>    resetting the cursor.
> 
> Result: R2 is permanently skipped even though it has never been
> processed.

Ok, makes sense.  The user impact should be not that big, though.

> 
> To fix this, the patch advances the cursor every time a region is
> walked, regardless of whether it is applied or filtered out.  This
> allows DAMON to accurately track whether the last region has already
> been visited, eliminating the need for the unconditional reset.

Sounds like a big change compared to the problem.  Why we cannot modify the
last region case?  Have you also considered other possible simpler approaches?

> 
> > > 
> > > 2. The cursor only advances when the quota becomes full.  Regions that
> > >    are filtered out do not move the cursor, and the scheme can remain
> > >    stuck on the same regions.
> > 
> > I don't fully understand this, either.  Could you pleae clarify more?
> > 
> 
> Problem 2 is a false positive.  As long as the quota is not full, DAMON
> will continue iterating to find applicable regions.  I mistakenly
> assumed in the commit message that encountering filtered-out or invalid
> regions would cause the cursor to stall.

Thank you for clarifying.  Please try to reduce this kind of false positives
from the next time.

> 
> This patch ensures that every target is traversed sequentially and
> deterministically, even when the quota is set very low.  I omitted this
> benefit in the initial problem description.  If you think it is okay, I
> will add it in the next revision.

What's the problem and benefit?  I still don't get it.  More clarification
would be nice.


Thanks,
SJ

[...]
