Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C21624C5;
	Tue, 30 Jun 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828232; cv=none; b=ODLgBJOMnS3+wybBmf1QhhjDgqgtA2aKgYQxdH3sgVHPduXxz8zJcR6P+xx/7ubuy+tXs/4XERJzUQNwiqHykRye7rw1ZQLy6MChkXji2+p0oJqesFVV/h8SWxUp4EjA7cK7XXcybzfGYQkyLNz0RzWPTw8nVSOWDN36BtLxABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828232; c=relaxed/simple;
	bh=dnA8j7yv6A5vmXycr2jMzNb/UH+ARJ4tMS3HoqPlkDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=halo8zg/TfgUDT2GHXvP/CkP6MKkWGi13yr+k1TZJdgTfK9xbOBvk3eUsb71sjzuKzBqJ3cUHVPSaKgVM5BiDelfcZ7nMAwiiaUC7X0uPgC0hjIIRpq/Fb9i/PYyXJ9DHjXAxae6IL9Dxu3ecasLHhGZfRCkGcZVia43Vi3jYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXXpJ6Sc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXXpJ6Sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3781F000E9;
	Tue, 30 Jun 2026 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782828231;
	bh=ClHDIHe24wi5Yo5FWGkzU3UQ8Z+yVvMWp5sTcgmzYDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UXXpJ6ScDKGWLDx/HgUzJ5sqtbpEXFA2Ctwbjq6K2MtMcDWYaEX94Gk0asH/tH/kA
	 iQfsHpW/G5+QPyWYgHQZ+raxxja9UDbc5KaMY8qqcx5ypmJbgKxucYJQz7ACutyeC+
	 hXENuFNiGhVTw4JzOBuubKINL8mI5jUDxDXctc9B3c0YOhH8OCYi8NOK8bcZ0amjtQ
	 FoVq4/zPENKLAwqqXzyjFl4Xzc3DMIw7QoLRGt+hPIfl7nLtbnkvvzEeUYznXte1W1
	 /NuGYU8As7v2GwZj24s0uelAhG9/j9W/z3vQuKMfFMgElgdclAyuQMjdkU0Ftp8dFa
	 WfGIV4wkZQ10A==
From: SJ Park <sj@kernel.org>
To: Igor Putko <igorpetindev@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/vaddr: remove redundant RCU lock
Date: Tue, 30 Jun 2026 07:03:36 -0700
Message-ID: <20260630140337.91100-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630130253.3843-1-igorpetindev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Igor,


Thank you for this patch.

From next time, please give enough time for others to comment before posting a
new revision of the patch.

Also, please post a new revision as a new thread with a changelog [1] including
links to previous revisions, rather than a reply to the previous revision.

On Tue, 30 Jun 2026 16:02:53 +0300 Igor Putko <igorpetindev@gmail.com> wrote:

> __damon_va_three_regions() is called only by damon_va_three_regions(),
> which already holds mmap_read_lock(). Since mmap_read_lock() is held,
> the maple tree and VMA list are protected from concurrent changes.
> Remove the unnecessary rcu_read_lock() and rcu_read_unlock() calls.

This is not explaining the test part change.  Could you please update for that?

Also, have you had a chance to theoretically or experiemently confirm the
problem [2] that motivated to add the rcu_read_lock() at that place is not
reintroduced by this change?  If so, could you please add that to the commit
log, too?


Thanks,
SJ

[1] https://docs.kernel.org/process/submitting-patches.html#commentary
[2] https://lore.kernel.org/b83651a0-5b24-4206-b860-cb54ffdf209b@roeck-us.net

[...]
