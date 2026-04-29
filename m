Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371334D4EA;
	Wed, 29 Apr 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473057; cv=none; b=FmsalNiNEi2c41z9gWN1DmKeVYR+s9UA7ctdmkwVUU6sFHmOHFN3y1+su+aeKPUtE0ZPRahpsGXzGY07v+7r12D2YZsGslyjiEpUIhhIiSgUFGKV8YA0PWrAaQ3nSzU1yPZ+kolj8baxGgf2Vf4KbX2q2CFgZmJ0+yZVPl+3S8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473057; c=relaxed/simple;
	bh=25669eAlVbHfJezMpC/Kwl7iJTxvlFiobYXmEPt9Zd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7y+tiHzJN5Ysu1q/CyOT0fcVLAIcrWxmdkZwzECDynzCnkMHOwHTqJ4ebixo+GXLbkQAWAV0UpeJfi4cowSVKMvLchk4ucCJSMYoxpgRnhe4XBviQcWSNFiilEbHeTzQTw57hKe8+MOYSoS+XUqrAYfZLg07mbSEjMfTOZDuMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpHYf61c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpHYf61c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC29C19425;
	Wed, 29 Apr 2026 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473057;
	bh=25669eAlVbHfJezMpC/Kwl7iJTxvlFiobYXmEPt9Zd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MpHYf61cRXlTqKuG9hB/u2iYXkA8SBvIMFOOsf3G0sfnfysZAiE5ds17hQr7DlAgS
	 HueC9gbqtEKddsPOx0JqDzRNoAr3kMIqTP5Cm3n+iiqu3itGt5OzW4sFEYYDT9fbGG
	 oyWPEswH2fz1o/FM4jKm7ZDtJeX4Cb9l7q5ty8aoGfurrUZWK2VJ8PE2dpHl7+TsAS
	 7w/p5L0lNyzhLStv2T2YtckcMYHEa52p54jioXzrnre34meVIFLc358WJ95Hy+4Kg8
	 dB66+tyPb7M1I3SJToJUdNjMGpRNVBwwQcCiPH+S+3XA4Oh+EjkQw15eFkMCURlA2b
	 lmlhFBWZVad7w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] mm/damon/reclaim,lru_sort: monitor all system rams by default
Date: Wed, 29 Apr 2026 07:30:52 -0700
Message-ID: <20260429143053.93890-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429041232.90257-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Apr 2026 21:12:22 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON_RECLAIM and DAMON_LRU_SORT set the biggest 'System RAM' resource
> of the system as the default monitoring target address range.  The main
> intention behind the design is to minimize the overhead coming from
> monitoring of non-System RAM areas.
> 
> This could result in an odd setup when there are multiple discrete
> System RAMs of considerable sizes.  For example, there are System RAMs
> each having 500 GiB size.  In this case, only the first 500 GiB will be
> set as the monitoring region by default.  This is particularly common on
> NUMA systems.  Hence the modules allow users to set the monitoring
> target address range using the module parameters if the default setup
> doesn't work for them.  In other words, the current design trades ease
> of setup for lower overhead.
> 
> However, because DAMON utilizes the sampling based access check and the
> adaptive regions adjustment mechanisms, the overhead from the monitoring
> of non-System RAM areas should be negligible in most setups.  Meanwhile,
> the setup complexity is causing real headaches for users who need to run
> those modules on various types of systems.  That is, the current
> tradeoff is not a good deal.
> 
> Set the physical address range that can cover all System RAM areas of
> the system as the default monitoring regions for DAMON_RECLAIM and
> DAMON_LRU_SORT.


FYI, Sashiko reviews and my review of the reviews are available on replies to
this thread that Cc-ing only me and damon@lists.linux.dev
(https://lore.kernel.org/20260429041232.90257-1-sj@kernel.org).  In short, no
real issue that blocks this series is found by Sashiko.


Thanks,
SJ

[...]
