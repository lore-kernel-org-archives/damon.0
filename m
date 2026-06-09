Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5735AC31;
	Tue,  9 Jun 2026 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016769; cv=none; b=aG0hsynqBcWMyUabM6IW9Nr1t7EO0ke31E2Jv2BNkOt9eBislOWJTRHiWYHrh8JvYIcQwF/XmHoUsHqMQvS2urX0Tepf5w7XJ2icfk7zqWb1QnKTEbK40RO2vtgxUMCWCeHgko7x4OAyyrQFmgWTeGeVAkzALTTPX7jCZ0/FMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016769; c=relaxed/simple;
	bh=0t8tNfszhGDNRdx/v3V4Yp/9419uR1+Cr6Yv85PTjqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQuORK9ROKKwNpODZH6VmEueVq4DHFtM5NbM0AFx9h7JkUx/Kk4Qj4Hou816mn7T0vdjDTz3E1bGCNG/x0QYER3zHKScHrlanzTMKte6rXiD8C61esAi2sTnnHTziUB5BuBzzSu7pxGEVXUh36h6ttOQ0wrTpAKds7AXJ+gfnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3MXmFZc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3MXmFZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80F01F0089B;
	Tue,  9 Jun 2026 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016767;
	bh=sqM1UPb6//lhStsTox8slzMJFvB7zQlNefHJrEgI4kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n3MXmFZczAtrKvRB9P4XloAiKLtlLQWlFOCqhWefhjxf6dkDdw04R0XVQKdjtvRqH
	 JkT3mPovpqJeTU9233PX6TVtBSKPDwPDdGQR5MlM2HVflnanneNNIlgoMsGOEzy5Wd
	 HsuqceDngkbfpJRWqt3Un/MivLK6xifPrW3b/XeLs0quOvJONKLoQTGAJXEiTLsxdJ
	 hkc89iJFvbfJq6av2oOuinlBUBw7T6K8JAtBBKB5mL0YDQK6aLLuXkAVhmfps11mDR
	 L9L3zoV6HKGjAaNTCM8NJJxon25PXZDNukxQYXcFnBmbqH76umnNSN2LCvyXSXCKFm
	 oVS1erAehovZQ==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	sashiko-reviews@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 1/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Tue,  9 Jun 2026 07:52:39 -0700
Message-ID: <20260609145240.69552-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a834e981-c292-43c1-8f02-d581a0d0b4bc@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Jun 2026 14:01:07 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 6/6/2026 3:12 AM, SeongJae Park wrote:
> > On Fri, 5 Jun 2026 13:57:47 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >>
> >>
> >> On 6/4/2026 6:19 PM, sashiko-bot@kernel.org wrote:
[...]
> >>> [Severity: Medium]
> >>> Is there a risk of a 32-bit overflow in this calculation?
> >>>
> >>> On 32-bit architectures, mult_frac() preserves types, and computing
> >>> thp * 10000 could exceed the maximum unsigned long value if there are
> >>> more than ~1.7 GB of THPs, producing an arbitrarily small quota target.
> >>>
> >> Good catch! I will cast 10000 to unsigned long to preserve the types.
> > 
> > But still it is 'unsigned long' that has only 32 bits on 32-bit architectures?
> > So it shouldn't make any change here.  Or, am I missing something?
> How about just a warning? Something like
> 
> WARN_ONCE(!IS_ENABLED(CONFIG_64BIT),
> 	"In 32bit systems DAMOS_QUOTA_HUGEPAGE_MEM_BP may not be accurate!\n");

I'm not sure if this is a real problem for our real users.  I'd suggest to
ignore Sashiko's concern for now and revisit if real users find and report this
as a problem.


Thanks,
SJ

[...]
