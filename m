Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F341C62;
	Mon, 18 May 2026 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148424; cv=none; b=BBgeYhruv98KjE5x8ha1eVHGT0McdIR6bdYSq0au02zm7o0RC7g49k0t9Df1fmMxmCYJWbpGvly8tjZI38bAwdoGDvdXU+PPbczRy9U4d8OIiyMCYFpJhXvM3kCTwgbVhVJmOUahdG/+2CRqexHYxIN6S7ASntmJ+ZmycIvljpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148424; c=relaxed/simple;
	bh=CCybTItl2l5Gf43MmCAPz8mcPgmYEVNMNLsLUpJUbN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfeWDL0eBZ422ymJveS+Z34gAEw6zEZgWxwOs3/750GyTQoDYb3IErTK0QJifBX0OXK8bgKeUAN6v2lPtQo43AUpSmGn3cw6JuIX8Zsbe3+rmCFGKISF8wa9hOQjH+XJXC0VnJzklY7VS16zrv9kPl/4SZe09RuNG8xTzZiSYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtC4UE8f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtC4UE8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69000C2BCB7;
	Mon, 18 May 2026 23:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779148424;
	bh=CCybTItl2l5Gf43MmCAPz8mcPgmYEVNMNLsLUpJUbN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtC4UE8f9YImDELdTsR30s9qV7Sfy4huKZAEnlT6YqC/XF3AEhhTAyUsPwtmB1gEp
	 5V3/u/FryBPMIgLDc3+KiBYI//28T90ZNylyhhL+dCm967kY+L9Lt4sVVXjtlfT/H6
	 OGa8/dTsHX2DOOGqd9VYAe78UBi/gNm5TcWKDpwA2F3ey8PE8IHmt6OM7ULx93g/tP
	 icavgCFw35jPGHgsURhE8Eytx0+35+qAEZhJReQLirfR9U5dqKSjYHgcE5abXh4T5R
	 DSagiQST1o/j8A7b2V6Mr8HQy4WSBtSlWhqKKpc5NvRwuJxCOik7bZiny3OMranSvz
	 wEgoRBGgIw/9g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 00/28] mm/damon: introduce data attributes monitoring
Date: Mon, 18 May 2026 16:53:34 -0700
Message-ID: <20260518235335.98776-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 May 2026 16:40:48 -0700 SeongJae Park <sj@kernel.org> wrote:

> TL; DR
> ======
> 
> Extend DAMON for monitoring general data attributes other than accesses.
> The short term motivation is lightweight page type (e.g., belonging
> cgroup) aware monitoring.  In long term, this will help extending DAMON
> for multiple access events capture primitives (e.g., page faults and
> PMU) and eventually pivotting DAMON to a "Data Attributes Monitoring and
> Operations eNgine" in long term.
[...]
> Changes from RFC v3
> - rfc v3: https://lore.kernel.org/20260516183712.81393-1-sj@kernel.org
> - Wordsmithing documentation.
> - Drop RFC tag.
> - Rebase to mm-new.

Sashiko failed [1] to reivew this series because it is still having an old
version of mm-new, while this series is based on mm-new.  Same issues were
found in RFC versions, so I was making those to based on mm-stable, and got
Sashiko reviews.  On the last version (RFC v3), I confirmed [2] Sashiko find no
more blocker.  So I believe this is good to go for more testing in mm-new.  I
will of course happy to get different inputs.

[1] https://sashiko.dev/#/patchset/20260518234119.97569-1-sj%40kernel.org
[2] https://lore.kernel.org/20260516220317.4300-1-sj@kernel.org


Thanks,
SJ

[...]
