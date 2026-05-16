Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CC7405C48;
	Sat, 16 May 2026 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778969054; cv=none; b=KRmGNmdufCRY4Vr6GzfFtItyaiW/ldYdCQNBMV6vlFV5fQjDwaTITwfXUCb5iey174K2M1XFvhMgO5KY3hED9BiTSV7MEYDIf+nv2Ncp+i7nx6MrH/pG6vI/SlRXiyXEHi7OCLL+bH+tzwo8Lo7W90g6sZFD2Rn0hEiT2lFWaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778969054; c=relaxed/simple;
	bh=jqUJDOVFPnUp4elyBS4bsFweoUttqEpYWejG0EQ9Hc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBvVwmFe77HS8Ep2/ajjwPQ9lbmCznu/UbbGyC3uoiFrPCO4KlNuq1J4NEu8dxPwEbnYRDA1OLS8jhUqMCZW/5cUVXAWGQwiU7gvqJlZ3SLuH5kqAJmWrBS2UNuomFq+hVWtVkllJRSTSZ6mw/VaV+Ufk2TpaXXDMZPK6DbUcZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXDo6/EH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXDo6/EH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B7FC19425;
	Sat, 16 May 2026 22:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778969054;
	bh=jqUJDOVFPnUp4elyBS4bsFweoUttqEpYWejG0EQ9Hc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXDo6/EHMP7g5zKEG7iKB4Qxz3Lrf3sdPP5zBHOr7Y3UUAL8c43gxrU6tilYE41jC
	 PGIS05HaNt1c1lq39JLyLx7tr1fsaS4GxvX28m0svfsyH9NkRtxbHqZnAN8y5Ve3t1
	 HlD0mwOVEvoKTnYOYUqnHiTCC+xpylEd3rKQU7sdj576eo3TbikY88DaTTWQBv5MdH
	 oO6dwlxNN9jdO0fV8UGwzCWG9H++dAOoL5njpZ+OE6h0xY4GsC2lsx+bEuFrG4EGnu
	 TbM/kd4xFvBR4mbObgv9kexhyiyLNK9QLPvIdM+TO/4qNFO+ScKXoKfXEPvyKzpDpH
	 o7jpPzwCY6BKA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [RFC PATCH v3 00/28] mm/damon: introduce data attributes monitoring
Date: Sat, 16 May 2026 15:03:16 -0700
Message-ID: <20260516220317.4300-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 11:36:41 -0700 SeongJae Park <sj@kernel.org> wrote:

> TL; DR
> ======
> 
> Extend DAMON for monitoring general data attributes other than accesses.
> The short term motivation is lightweight page type (e.g., belonging
> cgroup) aware monitoring.  In long term, this will help extending DAMON
> for multiple access events capture primitives (e.g., page faults and
> PMU) and eventually pivotting DAMON to a "Data Attributes Monitoring and
> Operations eNgine" in long term.

Sashiko found [1] no blocker for this version but a nice document wordsmithing
idea.  Unless I get other opinions, I will drop RFC tag from the next version
of this series.

[1] https://lore.kernel.org/damon/20260516185032.82261-1-sj@kernel.org/


Thanks,
SJ

[...]
