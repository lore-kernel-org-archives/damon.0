Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAE3F6C3B
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483508; cv=none; b=UkCaFiBZH8hKupTfALJTrd2VPlUdLeTb8c+nPFwf9IToXSV2lPqUBINGfL6ysKJauIyU1sMYWi1VosT26oDcZDQHCFG22he9pPW/VmwU0C+XH0XzHu5CjyTG8fhhA4Gff++poSzzwaIsZEW3Z0gmZguw3RpzlyN+tP1sqv2yJk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483508; c=relaxed/simple;
	bh=27JSuXW2+iPnlEMAFCkLJCa4AbWcVBxZgXokPRHCV1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnSb3nECT9RRfQ5OBKuLkUqazaevAu+6Ly+h7rosB5qkv57/PJIJd0T3bKH/vqpnWo5W7YPE/vIlUJoqpMwpL5kgzoPR517oSTB/JpdG3T+ajeIYrUmoZA3MlU23DoDAdy9PWO2uMYdbsaX6FWMGyoiBq8e6rnOYze3+Nh8WfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSZxxfSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSZxxfSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850591F000E9;
	Fri, 26 Jun 2026 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782483507;
	bh=fSqrO2bqW4dSYaxlrIc5+ZVhWS8NkgGiGqjtTA9ncRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SSZxxfSYlWcVT5jvIJ9nz2ueUduvU5pmr6hfphnHMxRs44ttAkP++FeuBcMZAniz+
	 XKgpXoqOPxXhGcrWyoy7CjrjyYlbzMZRpReiOFTKieSAxbPbwX+K4Soo3jrxsT24EJ
	 VB/EJ8jIdNFNmcOzW+rjjZrAUHIq4+a3vqUnz2O2Q+5UOGYH78I9AP8MM8wHeoAShG
	 p7FhqZQRFN8sU6U2uNMBBfZP3+/Fjt8iwoDlQuFkwV8mDUo3sasov9UqXrT+t8F8bt
	 6oBhi0sfNZDuxlv4FlFLHQV5xXzftdNMC2FzZqneQCyyc+/8suTxEdCjMxP33NrkMU
	 4nuVQXuuju1oQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/reclaim: add 'available' memory as an optional watermarks metric
Date: Fri, 26 Jun 2026 07:18:18 -0700
Message-ID: <20260626141819.86269-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626081038.46569-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,


Thank you for this patch!

On Fri, 26 Jun 2026 16:10:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> 
> Currently, DAMON's watermarks metric is calculated based on the
> proportion of the system's free memory.
> 
> However, on devices like Android, the system typically maintains a very
> low amount of free memory, even when the available memory is abundant.
> This causes DAMON_RECLAIM to prematurely or aggressive trigger memory
> reclamation, thereby increasing the risk of page refaults.
> 
> Solution
> ========
> 
> Introduce a new sysfs parameter 'memrate_type' to DAMON_RECLAIM. Users
> can switch DAMON's watermark metric evaluation to be based on available
> memory by writing 'available' to this parameter and commit the change.

How about using DAMOS quota with its aim-based auto-tuning, instead?

I developed DAMOS watermarks and quota as safe guards of DAMOS.  In more
detail, DAMOS quota is for restricting only resource usage of DAMOS.
Meanwhile, watermarks is for restricting resource usage of both DAMON and
DAMOS.  That is, when the watermarks condition is met, not only DAMOS but also
DAMON is completely paused.  Also, watermarks feature was considered smarter
than quota, because it is a kind of auto-tuning.

However, it turned out completely turning DAMON off is not a very good idea,
because it drops monitoring results when the watermarks condition is met and
therefore completely stops DAMON and DAMOS.  It drops the region shapes and
'age' information.  Especially, 'age' of some regions commonly cumulated up to
hours or even days.  Dropping that was a problem in production use cases.

Meanwhile, we introduced aim-oriented DAMOS quota auto-tuning (a.k.a DAMOS
quota goal).  It made DAMOS quota smarter and easier to extend than watermarks.
Nowadays, users can also pause and resume [1] DAMON/DAMOS without losing the
monitoring information when they want.

So, I personally don't encourage people to use watermarks.  Of course, I may
missing some problems in alternatives.  Hence I'm asking the question to you.

How about using DAMOS quota with its aim-based auto-tuning, instead?  If you
cannot, could you share more details?

I'll hold reviewing the code until this high level discussion is resolved.

[1] https://lore.kernel.org/20260427151231.113429-1-sj@kernel.org


Thanks,
SJ

[...]
