Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FA25D215
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111668; cv=none; b=KVigJr37TmgjegTtZPWa8hCW56dPggLeC57mh6g6qSK9qihpFIG75c5TqIi70zrVAKe9m/zFN3I8f/PZ/is1vJmbYdO2A4eBbY5qSTwoVzuBnZWsaMD/2ieF0Q6wfAbSjLf2rgkf1lqP2n00J3l+vsJmK7sJkr2p88PFzCbLkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111668; c=relaxed/simple;
	bh=ZZjD4aZT1Tgz8+Vs1HtkXoYSJOVk+xcnrHle9EsAaU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxissTavPNMLb0zzjWU+n9KMtEhPBV5GicFhRhdXJE+qbPG6KlWVX5ZLTsGWQKOV0l6XOzV1KiHjqiD+WQrZnEqORn69QLLdZdn0AWaZnUFmoh4dJU2sPdDOKC6ZauHAHer/WumSxdoIzu1NUqJhUwV+nLbqmQHH294veHyYLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmX4tl3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmX4tl3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E59A1F000E9;
	Fri,  7 Aug 2026 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786111667;
	bh=DQqH9N8cRtNFukXaAbTPupUZURdwJwhrhW3sLeMpOdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hmX4tl3MKGsF9m/+hq1ZYLMiEusVyRG/sxJXQhGQIfDXHZ3aKnHgAAk5mLU8U4Evk
	 4B9xWCJIZoEU29h7oq3RtU2ZNw62xPI40xgq4r/sdkOUZqLmf4Emq3cxVuljcHYLEC
	 O+uE+ZWL1QB2sFDY+uxCd3v9YGArQBP7yKn9cdgLHihtM6SAj/vFscY1XkfiJ/f16P
	 U8B8w+RTVwp/G3RmKUJeFFcDB+yUlnBtWO4wNTCb/M6IpYZudbsWmq6bDMHUwefc/P
	 nTxWREoGIlCQ8gFsZ70ACBvApQ5bV7x5+rGCHL1lYtZwb11qwuXipVSWJsVqQ4fFRp
	 Cr98S2n6yIWUA==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/damon: skip deactivated schemes in watermark checks and add fallback sleep
Date: Fri,  7 Aug 2026 07:07:39 -0700
Message-ID: <20260807140739.91238-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807093526.183009-3-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,

On Fri,  7 Aug 2026 17:35:26 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> According to DAMOS design documentation, a scheme is deactivated when
> nr_snapshots reaches max_nr_snapshots. However, the previous
> kdamond_wait_activation() still checked the schemes which nr_snapshots
> reached max_nr_snapshots.
> 
> This caused an issue - when all schemes were deactivated due to
> max_nr_snapshots, but their watermarks were still satisfied,
> damos_wmark_wait_us() would return 0, causing kdamond_wait_activation()
> to return 0 (activated). The main loop would then continue without
> sleeping, leading to unnecessary overhead since all schemes would be
> skipped in damon_do_apply_schemes().

This is an intended implementation.

When all schemes are deactivated by watermarks, DAMON stops monitoring.  It was
implemented in the way because we didn't want DAMON consumes system resource in
the case.  But, later it turned out DAMON's resource consumption is really
negligible.  Rather, it is turned out that it makes DAMON runs with stale
history when it is activated again.  Particularly, regions have 'age' and their
start/end addresses that was emerged before the deactivation.  Those are
meaningless and could even cause wrong DAMOS decisions.

We don't want that anymore.  For a case the user really want DAMON completely
stops, we introduced 'pause'.  For max_nr_snapshot-based deactivation, we don't
intend to completely stop DAMON.

Maybe the documentation can be updated to further clarify this.


Thanks,
SJ

[...]
