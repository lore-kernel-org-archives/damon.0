Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E142868AB;
	Fri,  9 Oct 2026 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533903; cv=none; b=adw9FG5qrr6jQTCmG5koIomRjfAEu5Xb+vIpiRF9QpKiT8FH6kH8ZVF8FCI0ZSoSYo32rCwfaynaQT58VI+p0eXaIBZUqaE4aSMRoQDzrNEJPdELqUmydCPsvLUwy9lbxO8IAnh9i8ai6xbIaD9rP8AL85m4lGb+6CUlVE0x0f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533903; c=relaxed/simple;
	bh=kPOtD809QWf9NdRwM+j9GDwaXH3JOZWnOPZjduilyYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFtH2JdRAx2+Y5MAmvjn9dogkMUm1ROW+UyfDznWh2RYYuVylBQyz1KwGmydDqgDnu7zSikAp1T2+uJrZXeolQxNEbtJZTgVc255jyA0ivRoybwurq5WiLGKFvTv4wRjHjwEC8NDiDsUgh6GAo33wCcitmQT+xZ06SwGYVM5ECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh2aiK8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh2aiK8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AFF1F000FF;
	Fri,  9 Oct 2026 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791533902;
	bh=QHhA7f6V65XQBZlA+M5P12SyKfroOAmYrTWgXRy7NBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qh2aiK8feprPn0+LiLNLX+i4kAHkS5xWpbXECCGTLaCQubPIBLGNCSEZ8GTYqlR7z
	 6RxLRLtNYj2IZN5XSK5+ydKgKnx64u+6OoX9zNsiTIXarxVBFBjulBkrEEGh3sUDQh
	 pSOwEbXQTGeOxMwqWxRIhUMI+cF3OLRdNI2W+zAGnEgkWAMN/R7Ad/uVhaAfAyvHbC
	 jKv3La3n39rIrTxv3eEN6013Zdk+Zg7TokL1rf52VXCOnU7qT/qFjtu3Duueppr/AW
	 0CFxzepM1S7vloIDvueeVgOhcQFI328iRnKa3/6zBIz1n1TOr5WtGK38RNniyWySgG
	 ybl07iXhcYWxQ==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix typo and grammar
Date: Fri,  9 Oct 2026 01:18:16 -0700
Message-ID: <20261009081816.41705-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008162010.4010682-2-manuelebnerli@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Manuel,


Let's use "mm/damon/reclaim:" as the subject prefix.

On Thu,  8 Oct 2026 18:20:10 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> DAMON_RCLAIM -> DAMON_RECLAIM
> set as -> set to
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> CC: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Other than the subject prefix,

Reviewed-by: SJ Park <sj@kernel.org>

> ---
> I hope I got the right git-tree. somehow there's 'damon/next'
> and 'damon/next/damon/next'
> The other patches will take a couple more days.

mm-new is the recommended baseline for now.  It might change in future.  Please
refer to this document [1] for more details.

I applied  this patch to damon/next [1] tree after changing the subject prefix
to what I suggested.  We are now quite close to next merge window.  It may
better to focus on making mm.git more stabilized and therefore ready for the
next merge window, rather than adding more changes that are not really urgent.
I understand this series is not really urgent.  Hence, Andrew might not add
this patch until next -rc1 release.  In the case, I will request adding this to
mm.git after next -rc1 release.  So, no action from your side is needed for
now.  Let me know if you think this is really  urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
