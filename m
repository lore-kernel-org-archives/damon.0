Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BD405C2C;
	Sat, 16 May 2026 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778957436; cv=none; b=WOL85rEUrK06SsGzvkxuUy0dCwGtcKvvmkUrS+9NYvuAHvCEJrwZ3SXlKQ6NE11qRGwWnlUdBXx7iaOohugXgFn+UpvzYB9efawNy7UAhBYj4LBScKrBsAJ5qgQ4yoBRr7fhZdgwc/rOiY2Iy40VWNUHfqIsei6eI/FWqnF6kFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778957436; c=relaxed/simple;
	bh=/mc+Cv8/SoyCbsJ+SUSfV3aQIXou0Zvtdu64a7r8qYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXxYy60Fm61VAr41Y1pC/zRlfz5heRdS0M6em+tdN08aQlKH1gON3s6BFrGH4zYHIdOnURgLfjV5K75HYFb/ZjP4IjjpcnuSsmMOVisC4fklB1MlfQQ6UDw0v1fAQMT+v5UccdzYqp5RS0dzyIVkaoYFESwX0WRqJJBt0pOVQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN3fGvEE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN3fGvEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D941C19425;
	Sat, 16 May 2026 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778957436;
	bh=/mc+Cv8/SoyCbsJ+SUSfV3aQIXou0Zvtdu64a7r8qYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VN3fGvEEmvdhLyWQADuEhdcDPWtnDsteqJlC8SSPj08SiA2BC7rARwfG7WMURFPKL
	 f8yvxnb4/aE8Gt4eDMYAMxY9o3xfIU2L1g65OZoy9QyfOH/VwwWprRkgWmFU9FrC8C
	 t++NdPULqY8GumqhbwZ/npQZ+2soy480LiAvhD7e5/mS7syRAckwtveY3ZETiiNVpi
	 XUh6HIio2/H6vUKqL4DFe0uGf9TNHJRcMu4EyADux72g6DnaJGeTqfw0kRh9/b3Tet
	 Y/dZ1iHkp8Z/1b26B0xcD6Csi8gbq6y+UFYUBRfwD7+YgFwrVu/g+r+Aa5cy7G2t0e
	 /aFo9vFPiNAJw==
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
Date: Sat, 16 May 2026 11:50:31 -0700
Message-ID: <20260516185032.82261-1-sj@kernel.org>
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
[...]
> Changes from RFC v2.1
> - rfc v2.1: https://lore.kernel.org/20260514140904.119781-1-sj@kernel.org
> - Rebase to mm-stable (7.1-rc3) to avoid Sashiko patch apply failure.

Still this seires is based on mm-stable (7.1-rc3) for the same reason.  The
patches that based on mm-new is available at damon/next tree [1].

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
